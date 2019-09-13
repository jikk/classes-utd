# Assignment 0x01

## Assignment set-up

### GDB Plug-in

In this document, I will use [PEDA](http://ropshell.com/peda/) GDB Plugin, to illustrate assignment details.

    # install PEDA
    $ git clone https://github.com/longld/peda.git ~/peda
    $ echo "source ~/peda/peda.py" >> ~/.gdbinit

You can also try to use more updated GDB plug-ins such as [gef](https://github.com/hugsy/gef), [pwndbg](https://github.com/pwndbg/pwndbg).

### Disable Address Space Layout Randomization (ASLR)

In this assignment (part2 and part3), you can need to disable ASLR. Use one of the following commands.

    echo 0 | sudo tee /proc/sys/kernel/randomize_va_space

or 

    sudo sysctl -w kernel.randomize_va_space=0

or 

    setarch `uname -m` -R /bin/bash

To open a new *bash* shell for you with ASLR disabled.

## Part 1 (4pt): Control flow hijacking

### Preparation ###

Download *crackme0x00* from http://cs6332.syssec.org/crackmes/crackme0x00

### Description ###

In this assignment, we are going to hijack the control flow of *crackme0x00* binary
by overwriting the instruction pointer. As a first step, let's make it print
out "Password OK :)" without providing correct answer to your question.

```
$ objdump -d crackme0x00
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

    $ echo AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA | ./crackme0x00
    CS6332 Crackme Level 0x00
    Password: Invalid Password!
    Segmentation fault

There are a few ways to check the status of the last segmentation
fault:

1. checking logging messages

        $ dmesg | tail -1
        [237413.117757] crackme0x00[353]: segfault at 41414141 ip 0000000041414141 sp 00000000ff92aef0
        error 14 in libc-2.24.so[f7578000+1b3000]

2. running gdb

        $ echo AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA > input
        $ gdb ./crackme0x00
        > run <input
        Starting program: ./crackme0x00 <input
        CS6332 Crackme Level 0x00
        Password: Invalid Password!

        Program received signal SIGSEGV, Segmentation fault.
        0x41414141 in ?? ()

 <p><img alt="stack layout 1" src="https://i.imgur.com/T6x4QNn.jpg" width="75%"/></p>  

### Control EIP ###

Let's figure out which input tainted the instruction pointer.

    $ echo AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHHIIIIJJJJ > input
    $ dmesg | tail -1
    [238584.915883] crackme0x00[1095]: segfault at 48484848 ip 0000000048484848 sp 00000000ffc32f80
    error 14 in libc-2.24.s

What's the current instruction pointer? You might need this help:

    $ man ascii

You can also figure out the exact shape of the stack frame by looking at
the instructions as well.

    $ objdump -d crackme0x00
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

### Output to submit

Save your attack payload to `input1`. The expected running example would be like the following.

    $ cat input1 | ./crackme0x00
    CS6332 Crackme Level 00
    Password: Invalid Password!
    Password OK :)
    Segmentation fault


## Part 2 (8 point): Return-to-libc

### Preparation

For this part, we will use *crackme0x00* binary again. Download *crackme0x00* from http://cs6332.syssec.org/crackmes/crackme0x00 and check its binary to ensure stack section (*GNU_STACK*) is in `RW` permission which mean you can overwrite a stack, but cannot run any code from there.

```
$ readelf -W -l ./crackme0x00|grep STACK
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
$ gdb  crackme0x00
gdb-peda$ b main
gdb-peda$ run
...

gdb-peda$ print system
$1 = {<text variable, no debug info>} 0xf7e26d10 <system>
```

`0xf7e26d10` is address that you want to return to run the function.

### Output to submit

Save your attack payload to `input2`. The expected running example would be like the following. You will pretend *env -i*, so as for the stack layout to be more deterministic.

    $ cat input2 | env -i ./crackme0x00
    CS6332 Crackme Level 00
    Password: Invalid Password!
    $ whoami
    kjee

## Part 3 (8 piont): Jump Shellcode

### Prepration

Download *crackme0x00-nonx* from http://cs6332.syssec.org/crackmes/crackme0x00-nonx and check its binary to ensure stack section (*GNU_STACK*) is in `RWE` permission which mean you can write and run a shellcode snippet from stack.

```
$ readelf -W -l ./crackme0x00-nonx|grep STACK
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RWE 0x10
```

### Description

From this assignment, PEDA will generate a shellcode. You will craft an input to overwrite the stack with shellcode and transfer control the beginning of shellcode as *main()* function returns. You can google for *execve() shellcode x86* that would eventually run */bin/sh* command for you.

Check shellcode length, and make sure shellcode should fit in to stack.

Let's see we have enough space in stack.

```
$ objdump -j .text -d crackme0x00-nonx
...
5bc:	83 ec 20             	sub    $0x30,%esp
...
```

Create an input that would run *shellcode* and subsequently give */bin/sh* prompt. Please note that different lengths of environment variables + arguments can also vary the resulting stack address widely from computer to computer. A way to mitigate this issue is doing a NOP slide (see https://old.liveoverflow.com/binary_hacking/protostar/stack5.html).

### Output to submit

Save your attack payload to `input2`. The expected running example would be like the following. You will pretend *env -i*, so as for stack layout to be more deterministic.

    $ cat input3 | env -i ./crackme0x00-nonx
    CS6332 Crackme Level 00
    Password: Invalid Password!
    $ whoami
    kjee

## Submission

```bash
tar czvf <your-netid>.tgz input1 input2 input3
```

----

Page last revised on: {{ git_revision_date }}