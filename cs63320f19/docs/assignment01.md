# Assignment 0x01

## Assignment set-up

We have a submission server (10.176.90.84) set-up for this assignment. The student will log-in with different accounts for different parts of the assignment. From your host (Linux or OS X), use the following command to log-in to the submission server. We the same password for all accounts, the log-in password is `guest`. You can use ssh client program (e.g., [putty](https://www.chiark.greenend.org.uk/~sgtatham/putty/)) for Windows machine.

```bash
# For part 1
$ ssh -p 2222 assign_0x1_p1@10.176.90.84
assign_0x1_p1@10.176.90.84 password:      # type in "guest"
...
# For part 2
$ ssh -p 2222 assign_0x1_p2@10.176.90.84
assign_0x1_p2@10.176.90.84 password:      # type in "guest"
...
# For part 3
$ ssh -p 2222 assign_0x1_p3@10.176.90.84
assign_0x1_p3@10.176.90.84 password:      # type in "guest"
...
```

### Assignment binaries

Assignment binaries are available for download. Download and study it from a local machine first. Once you figure out how to solve, you can log in to the submission server to get flags for each part.

* [assign_0x1_p1](http://cs6332.syssec.org/crackmes/assign_0x1_p1)
* [assign_0x1_p2](http://cs6332.syssec.org/crackmes/assign_0x1_p2)
* [assign_0x1_p3](http://cs6332.syssec.org/crackmes/assign_0x1_p3)

### Capturing the flag

Once you log into your system, you will see the files of the followings. 

```bash
assign_0x1_p1@cs6332-lab0:~$ ls -trl
total 24
-r-xr-sr-x 1 root assign_0x1_p1_pwn 7376 Sep 20 05:27 assign_0x1_p1
-rw-r--r-- 1 root root              1761 Sep 26 08:58 README
-r-xr-x--- 1 root assign_0x1_p1_pwn  424 Sep 20 05:34 solve
```

For each part, the goal is to run *solve* to get your flag (hash value).
With the correct input that exploits each part, you will get to run *solve*, and it will give you the following prompt, which asks you to provide your NetID.

```bash
Your NetID:
kxj1234556
Congratulations!
Here is your answer hash: 19154be089a9f0cf7627a68bcfd1c26f
```

As you solve different parts of the assignment, each part will generate different hashes.
You can submit the hash values along with your inputs.

### Radare2 disassembler and GDB Plug-ins

[PEDA](http://ropshell.com/peda/) and [gef](https://gef.readthedocs.io) are installed to the submission server.
You can load plug-ins by running the following commands from *GDB* prompt.
    
    source /opt/gef/gef.py
    source /opt/peda/peda.py

We also installed Radare2 to the submission host, but we recommend you to study assignment binary thoroughly from your own host first, before you try payloads from submission server. In this document, I will use [PEDA](http://ropshell.com/peda/) GDB Plugin to illustrate assignment details.

## Part 1 (4pt): Control flow hijacking

### Preparation

Download [*assign_0x1_p1*](http://cs6332.syssec.org/crackmes/assign_0x1_p1) to your local (Linux) host to analyze first. Once you get ready, you can login to your submission server to confirm your input and get your hash value.

### Description

In this assignment, we are going to hijack the control flow of *assign_0x1_p1* binary
by overwriting the instruction pointer. As a first step, let's make it print
out "Password OK :)" without providing correct answer to your question.

```
$ objdump -d assign_0x1_p1
...
    80485ad:	e8 fe fd ff ff       	call   80483b0 <strcmp@plt>
    80485b2:	83 c4 08             	add    $0x8,%esp
    80485b5:	85 c0                	test   %eax,%eax
    80485b7:	75 1c                	jne    80485d5 <main+0x7f>
    80485b9:	68 9c 86 04 08       	push   $0x804869c
 -> 80485be:	e8 1d fe ff ff       	call   80483e0 <puts@plt>
    80485c3:	83 c4 04             	add    $0x4,%esp
    80485c6:	68 ab 86 04 08       	push   $0x80486ab
    80485cb:	e8 20 fe ff ff       	call   80483f0 <system@plt>
    80485d0:	83 c4 04             	add    $0x4,%esp
    80485d3:	eb 0d                	jmp    80485e2 <main+0x8c>
    80485d5:	68 c5 86 04 08       	push   $0x80486c5
    80485da:	e8 01 fe ff ff       	call   80483e0 <puts@plt>
    80485df:	83 c4 04             	add    $0x4,%esp
    80485e2:	b8 00 00 00 00       	mov    $0x0,%eax
    80485e7:	c9                   	leave
    80485e8:	c3                   	ret
```

!!!Note
    Upon a successful control hijack will eventually call *system()* function. Try to figure out its argument!

Please craft your input to overflow stack and overwrite RIP so that main function will return to `0x80485be`, subsequently prints out "Password OK :)".

What happens if you provide a long string? Like below.

    $ echo AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA | ./assign_0x1_p1
    CS6332 Crackme Level 0x00
    Password: Invalid Password!
    Segmentation fault

There are a few ways to check the status of the last segmentation
fault:

1. checking logging messages

        $ dmesg | tail -1
        [237413.117757] assign_0x1_p1[353]: segfault at 41414141 ip 0000000041414141 sp 00000000ff92aef0
        error 14 in libc-2.24.so[f7578000+1b3000]

2. running gdb

        $ echo AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA > input
        $ gdb ./assign_0x1_p1
        > run <input
        Starting program: ./assign_0x1_p1 <input
        CS6332 Crackme Level 0x00
        Password: Invalid Password!

        Program received signal SIGSEGV, Segmentation fault.
        0x41414141 in ?? ()

The following diagram illustrates the state of stack.

 <p><img alt="stack layout 1" src="https://i.imgur.com/T6x4QNn.jpg" width="75%"/></p>  

Which portion of string in input should be changed to `0x80485be`? 

### Control EIP ###

Let's figure out which input tainted the instruction pointer.

    $ echo AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHHIIIIJJJJ > input
    $ ./assign_0x1_p1 <input
    $ dmesg | tail -1
    [238584.915883] assign_0x1_p1[1095]: segfault at 48484848 ip 0000000048484848 sp 00000000ffc32f80
    error 14 in libc-2.24.s

What's the current instruction pointer (ip)? You can see that CPU was trying to instruction and 0x48484848, and is seg-faulted.  To figure out what does 0x48 translate to. You can lookup ascii table:

    $ man ascii

or from GDB, run the following to print the character.

    gdb-peda$ printf "%c\n", 0x48 

You can also figure out the exact shape of the stack frame by looking at
the instructions as well.

    $ r2 assign_0x1_p1
    ...
    8048414:       55                      push   %ebp
    8048415:       89 e5                   mov    %esp,%ebp
    8048417:       83 ec 28                sub    $0x14,%esp
    ...
    804858c:	   83 c4 04                add    $0x4,%esp
    804858f:	   8d 45 ec                lea    -0x14(%ebp),%eax
    8048592:	   50                      push   %eax
    8048593:	   68 92 86 04 08          push   $0x8048692
    8048598:	   e8 63 fe ff ff          call   8048400 <scanf@plt>
    ...

The following diagram illustrates the state of stack.

<p><img alt="stack layout 2" src="https://i.imgur.com/9ZzeLOn.jpg" width="75%"/></p>  

### Output to submit

On a successful exploitation, the program will run `solve` program which will
ask you to provide your NetID and return your hash value. For this part of
assignment, i please submit the followings

  1. Your *input* to exploit the buffer overflow vulnerability
  2. Hash value generated by *solve* as a return for your NetID.

## Part 2 (8 pionts): Jump to your own shellcode

### Preparation

Download [*assign_0x1_p2*](http://cs6332.syssec.org/crackmes/assign_0x1_p2) to your local (Linux) host to analyze first.
Once you get ready, you can login to your submission server to confirm your input and get your hash value.
Please, check its binary to ensure stack section (*GNU_STACK*) is in `RWE`
permission which mean you can write and run machine instructions  from stack.

```
$ readelf -W -l ./assign_0x1_p3|grep STACK
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RWE 0x10
```

From this part, you will save your payload as *a file* and provide it as an
argument to the vulnerable program (assign_0x1_p2).

    echo -ne "payload\xef\xbe\xad\xde" > /tmp/myinput
    ./assign_0x1_p2 /tmp/myinput
    IOLI Crackme Level 0x00
    Invalid Password!

!!!Note
    The submission server (and account for each part) is shared by the entire
    class, please try to use a unique filename for your input to avoid potential
    conflict.

### Description

From this assignment, You will craft an input
to overwrite the stack with shellcode and transfer control the beginning of
shellcode as *main()* function returns. You can google for *execve()
shellcode x86* that would eventually run */bin/sh* command for you.
Check shellcode length, and make sure shellcode should fit in to stack.

Create an input that would run *shellcode* and subsequently give */bin/sh* prompt. Please note that different lengths of environment variables + arguments can also vary the resulting stack address widely from computer to computer. A way to mitigate this issue is doing a NOP slide (see https://old.liveoverflow.com/binary_hacking/protostar/stack5.html).

Upon a successful exploitation, you will see the shell prompt as below.

    assign_0x1_p2@cs6332-lab0:~$ ./assign_0x1_p2 /tmp/input2
    IOLI Crackme Level 0x00
    Invalid Password!
    $ id
    uid=1002(assign_0x1_p2) gid=1004(assign_0x1_p2_pwn) groups=1004(assign_0x1_p2_pwn),1003(assign_0x1_p2)
    $ ./solve
    Your NetID:   # input your NetID here.

!!!Note
    Even with ASLR, stack location may vary slightly due to environment
    variables. You may consider padding your payload with sled (NOP instruction) to
    make your exploit robust.

!!!Note
    if you want to make your environment as similar as possible, prepend
    `env -i` before your program command, i.e. `env -i ./assign_0x1_p2`.


### Output to submit

On successful exploitation, the program will run the `solve` program, which
will ask you to provide your NetID and return your hash value. For this part of
the assignment, please submit the followings

  1. Your *input* to exploit the buffer overflow vulnerability and deliver shellcode payload.
  2. Hash value generated by *solve* as a return for your NetID.

## Part 3 (8 point): Return-to-libc

### Preparation

Download [*assign_0x1_p3*](http://cs6332.syssec.org/crackmes/assign_0x1_p3)
to your local (Linux) host to analyze first. Once you get ready, you can
login to your submission server to confirm your input and get your hash
value. This time, your stack is not executable anymore. Please check its
binary to ensure stack section (*GNU_STACK*) is in `RW` permission which mean
you can overwrite a stack, but cannot run any code from there.
```
$ readelf -W -l ./assign_0x1_p3|grep STACK
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x4
```

### Description

From this part of the assignment, you can still hijack the control by overwriting the return address, but you don’t know where to transfer the control, to run the desired command (say */bin/sh*) using *system()* function provided by Glibc library. For its usage, please check out `man -s 3 system`.

Please write an input that would overwrite the return address of main() and transfer the control aa *main()* function returns. You need to craft your payload to call *system()* having a string (*/bin/sh*) as the first function argument.

#### *system()* function example

The following snippet would give you a command prompt.

```bash
$ cat << EOF > /tmp/system.c
#include <stdlib.h>
// system.c
int main() {
    system("/bin/sh");
}
EOF

$ gcc /tmp/system.c
$ ./a.out
$ whoami
assign_0x1_p3
```

### Getting addresses of necessary ingredients.

Using GDB, you can easily find the address of *system()*.

```sh
$ gdb  assign_0x1_p3
gdb-peda$ b main
gdb-peda$ run
...

gdb-peda$ print system
$1 = {<text variable, no debug info>} 0xf7e26d10 <system>
```

`0xf7e26d10` is address that you want to return to run the function.
Then as a next step, you need to think about how to pass the argument to the function.

### Output to submit

On successful exploitation, the program will run the `solve` program, which
will ask you to provide your NetID and return your hash value. For this part of
the assignment, please submit the followings

  1. Your *input* to exploit the buffer overflow vulnerability and run system()
     function from libc library.
  2. Hash value generated by *solve* as a return for your NetID.

## Submission

Submit a file with following entries.

```bash
NetID: <Your NetID>

Part 1
------

* Input

<input for part1>

* Hash

<hash from /home/assign_0x1_p1/solve>

Part 2
------

* Input

<input for part1>

* Hash

<hash from /home/assign_0x1_p2/solve>

Part 3
------

* Input

<input for part1>

* Hash

<hash from /home/assign_0x1_p3/solve>
```

**[Credit]**: Henry Wang has significantly contributed to improve the assignment.

----

Page last revised on: {{ git_revision_date }}