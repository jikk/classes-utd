# Assignment 0x01

## Assignment set-up

We  have a submission server (10.176.90.84) set-up for this assignment. Student will log-in with different accounts for different parts of assignment.
From you host (Linux or OSX), use the following command to log-in to the submission server. We a same password for all accounts, the log-in password is `guest`.

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

### Capturing the flag!

Once you log into your system, you will see the files of the followings. 

```bash
assign_0x1_p1@cs6332-lab0:~$ ls -trl
total 24
-r-xr-sr-x 1 root assign_0x1_p1_pwn 7376 Sep 20 05:27 assign_0x1_p1
-r-xr-x--- 1 root assign_0x1_p1_pwn  424 Sep 20 05:34 solve
```

For each part, the goal is to run *solve* to get your flag. 
With the correct input to each part, you will get to run *solve*, and it will give you the following prompt. Which will ask you to provide your NetID and student ID.

```bash
Your NetID:
kxj1234556
Your student ID:
25415
Here is your answer hash: 19154be089a9f0cf7627a68bcfd1c26f
```

Your *student ID* will be gained by the following command. 
```
m=$(echo "kxj1234556" |md5sum |cut -d ' ' -f 1);echo "obase=10; ibase=16; ${m: -4}" |bc
```

As you solve different parts of the assignment, each part will produce different hashes.
You can submit the hash values.

###

### GDB Plug-ins

You can find [PEDA](http://ropshell.com/peda/) and [gef](https://gef.readthedocs.io).
You can enable a plug-in by running the following commands from *GDB*.
    
    source /opt/gef/gef.py
    source /opt/peda/peda.py

In this document, I will use [PEDA](http://ropshell.com/peda/) GDB Plugin, to illustrate assignment details.
You can also try to use more updated GDB plug-ins such as [pwndbg](https://github.com/pwndbg/pwndbg).

## Part 1 (4pt): Control flow hijacking

### Preparation ###

Download *assign_0x1_p1* from http://cs6332.syssec.org/crackmes/assign_0x1_p1

### Description ###

In this assignment, we are going to hijack the control flow of *assign_0x1_p1* binary
by overwriting the instruction pointer. As a first step, let's make it print
out "Password OK :)" without providing correct answer to your question.

```
$ objdump -d assign_0x1_p1
...
    8048469:       e8 e2 fe ff ff          call   8048350 <strcmp@plt>
    804846e:       85 c0                   test   %eax,%eax
    8048470:       74 0e                   je     8048480 <main+0x6c>
    8048472:       c7 04 24 96 85 04 08    movl   $0x8048596,(%esp)
    8048479:       e8 c2 fe ff ff          call   8048340 <printf@plt>
    804847e:       eb 0c                   jmp    804848c <main+0x78>
 -> 8048480:       c7 04 24 a9 85 04 08    movl   $0x80485a9,(%esp)
    8048487:       e8 b4 fe ff ff          call   8048340 <printf@plt>
    804848c:       b8 00 00 00 00          mov    $0x0,%eax
    8048491:       c9                      leave
    8048492:       c3                      ret
```

main function will return to `0x08048480` such that it prints out "Password OK :)". Which characters in input should be changed to 0x08048480? Let me remind you that x86 is a little-endian machine.

What happens if you provide a long string? Like below.

    $ echo AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA | ././assign_0x1_p1
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

 <p><img alt="stack layout 1" src="https://i.imgur.com/T6x4QNn.jpg" width="75%"/></p>  

### Control EIP ###

Let's figure out which input tainted the instruction pointer.

    $ echo AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHHIIIIJJJJ > input
    $ ./assign_0x1_p1 <input
    $ dmesg | tail -1
    [238584.915883] assign_0x1_p1[1095]: segfault at 48484848 ip 0000000048484848 sp 00000000ffc32f80
    error 14 in libc-2.24.s

What's the current instruction pointer? You might need this help:

    $ man ascii

You can also figure out the exact shape of the stack frame by looking at
the instructions as well.

    $ r2 assign_0x1_p1
    ...
    8048414:       55                      push   %ebp
    8048415:       89 e5                   mov    %esp,%ebp
    8048417:       83 ec 28                sub    $0x28,%esp
    ...
    8048448:       8d 45 e8                lea    -0x18(%ebp),%eax
    804844b:       89 44 24 04             mov    %eax,0x4(%esp)
    804844f:       c7 04 24 8c 85 04 08    movl   $0x804858c,(%esp)
    8048456:       e8 d5 fe ff ff          call   8048330 <scanf@plt>
    ...

<p><img alt="stack layout 2" src="https://i.imgur.com/9ZzeLOn.jpg" width="75%"/></p>  


!!!Note
    Successful control hijack will eventually run *system("/home/assign_0x1_p1/solve")*! Look inside the binary!

The following is the disassembly of *assign_0x1_p1* binary.  

    $ r2 assign_0x1_p1
        ....
    ┌ (fcn) main 136
        ....
    │           0x080485c2      e809feffff     sym.imp.strcmp ()           ; int strcmp(const char *s1, const char *s2)
    │           0x080485c7      83c408         esp += 8
    │           0x080485ca      85c0           var = eax & eax
    │       ┌─< 0x080485cc      751c           if (var) goto 0x80485ea
    │       │   0x080485ce      68ac860408     push str.Password_OK_:      ; 0x80486ac ; "Password OK :)"
    │       │   0x080485d3      e838feffff     sym.imp.puts ()             ; int puts(const char *s)
    │       │   0x080485d8      83c404         esp += 4
    │       │   0x080485db      68bb860408     push str.home_assign_0x1_p1_solve ; 0x80486bb ; "/home/assign_0x1_p1/solve"
    │       │   0x080485e0      e83bfeffff     sym.imp.system ()           ; int system(const char *string)
    │       │   0x080485e5      83c404         esp += 4
    │      ┌──< 0x080485e8      eb0d           goto 0x80485f7
    │      ││      ; JMP XREF from 0x080485cc (main)
    │      │└─> 0x080485ea      68d5860408     push str.Invalid_Password   ; 0x80486d5 ; "Invalid Password!"
    │      │    0x080485ef      e81cfeffff     sym.imp.puts ()             ; int puts(const char *s)
    │      │    0x080485f4      83c404         esp += 4
    │      │       ; JMP XREF from 0x080485e8 (main)
    │      └──> 0x080485f7      b800000000     eax = 0
    │           0x080485fc      c9
    └           0x080485fd      c3             return 0


### Output to submit

Save your attack payload to `input1`. The expected running example would be like the following.

    $ cat input1 | ./assign_0x1_p1
    CS6332 Crackme Level 00
    Password: Invalid Password!
    Password OK :)
    Segmentation fault


## Part 2 (8 point): Return-to-libc

### Preparation

For this part, we will use *assign_0x1_p1* binary again. Download *assign_0x1_p1* from http://cs6332.syssec.org/crackmes/assign_0x1_p1 and check its binary to ensure stack section (*GNU_STACK*) is in `RW` permission which mean you can overwrite a stack, but cannot run any code from there.

```
$ readelf -W -l ./assign_0x1_p2|grep STACK
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x4
```

### Description

From this part of the assignment, you can still hijack the control by overwriting the return address, but you don’t know where to transfer the control, to run the desired command (say */bin/sh*). In this part of the assignment, we want to use *system()* function provided by Glibc library. For its usage, please check out `man -s 3 system`.

Please write an input that would overwrite the address of *system()* to return address of main() and transfer the control aa *main()* function returns. Don't forget to find a way to pass a string of command that you want to run (*/bin/sh*) as the first function argument to *system()* function. You can provide it from your stack or you can simply search for the string from Glibc.

#### *system()* function example

The above snippet would give you a command prompt.

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
kjee
```

### Getting addresses of necessary ingredients.

* GDB (Peda) will the address of *system()* at runtime. 

```
$ gdb  assign_0x1_p2
gdb-peda$ b main
gdb-peda$ run
...

gdb-peda$ print system
$1 = {<text variable, no debug info>} 0xf7e26d10 <system>
```

`0xf7e26d10` is address that you want to return to run the function.

### Output to submit

Save your attack payload to `input2`. The expected running example would be like the following. You will pretend *env -i*, so as for the stack layout to be more deterministic.

    $ cat input2 | env -i ./assign_0x1_p2
    CS6332 Crackme Level 00
    Password: Invalid Password!
    ....
    $ sh ./solve
    ....

## Part 3 (8 piont): Jump to your own shellcode

### Preparation

Download *assign_0x1_p3* from http://cs6332.syssec.org/crackmes/assign_0x1_p3 and check its binary to ensure stack section (*GNU_STACK*) is in `RWE` permission which mean you can write and run a shellcode snippet from stack.

```
$ readelf -W -l ./assign_0x1_p3|grep STACK
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RWE 0x10
```

### Description

From this assignment, PEDA will generate a shellcode. You will craft an input to overwrite the stack with shellcode and transfer control the beginning of shellcode as *main()* function returns. You can google for *execve() shellcode x86* that would eventually run */bin/sh* command for you.

Check shellcode length, and make sure shellcode should fit in to stack.

Let's see we have enough space in stack.

```
$ objdump -j .text -d assign_0x1_p3
...
5bc:	83 ec 20             	sub    $0x30,%esp
...
```

Create an input that would run *shellcode* and subsequently give */bin/sh* prompt. Please note that different lengths of environment variables + arguments can also vary the resulting stack address widely from computer to computer. A way to mitigate this issue is doing a NOP slide (see https://old.liveoverflow.com/binary_hacking/protostar/stack5.html).

### Output to submit

Save your attack payload to `input2`. The expected running example would be like the following. You will pretend *env -i*, so as for stack layout to be more deterministic.

    $ cat input3 | env -i ./assign_0x1_p3
    CS6332 Crackme Level 00
    Password: Invalid Password!
    ...
    $ sh ./solve
    ....

## Submission

Submit a file with following entries.

```bash
NetID: <Your NetID>
* Part 1
<hash from /home/assign_0x1_p1/solve>

* Part 2
<hash from /home/assign_0x1_p2/solve>

* Part 3
<hash from /home/assign_0x1_p3/solve>
```

----

Page last revised on: {{ git_revision_date }}