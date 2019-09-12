# Assignment 0x01

## Assignment set-up

PEDA: http://ropshell.com/peda/

    # install PEDA
    $ git clone https://github.com/longld/peda.git ~/peda
    $ echo "source ~/peda/peda.py" >> ~/.gdbinit

    # TIP. if you don't want to see gdb's init banner
    $ echo 'alias gdb="gdb -q"' >> ~/.bashrc


## Part 1 (4pt): Control flow hijacking

### Prepration
Download *crackme0x00* from http://cs6332.syssec.org/crackmes/crackme0x00

### Description

In this assigment, we are going to hijack the control flow of *crackme0x00*
by overwriting the instruction pointer. As a first step, let's make it print
out "Password OK :)"!

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


### Output to submit

Save your attack payload to `input1`. The expected running example would be like the following.

    $ cat input1 | ./crackme0x00
    CS6332 Crackme Level 00
    Password: Invalid Password!
    Password OK :)
    Segmentation fault


## Part 2 (8 piont): Jump Shellcode 

### Prepration
Download *crackme0x00-nonx* from http://cs6332.syssec.org/crackmes/crackme0x00-nonx and check its binary to ensure stack section (*GNU_STACK*) is in `RWE` permission which mean you can write and run a shellcode snippet from stack.

```
$ readelf -W -l ./crackme0x00-nonx|grep STACK
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RWE 0x10
```

### Description

From this assignment, Peda will generate a shellcode. You will craft an input to overwrite the stack with shellcode and transfer control the beginning of shellcode as *main()* function returns.

Peda generates a shellcode snippet for you.
```
gdb-peda$ shellcode generate x86/linux exec
# x86/linux/exec: 24 bytes
shellcode = (
    "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x31"
    "\xc9\x89\xca\x6a\x0b\x58\xcd\x80"
)
```
which disassembled as below.

![](https://i.imgur.com/qhId2Vy.jpg)

Check shellcode length, and make sure shellcode should fit in to stack.

```python
>>> shellcode = (
...     "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x31"
...     "\xc9\x89\xca\x6a\x0b\x58\xcd\x80"
... )
>>> len(shellcode)
24
```

```
$ objdump -j .text -d crackme0x00-nonx
...
5bc:	83 ec 20             	sub    $0x20,%esp
...
```

Create an input that would run *shellcode* and subsequently give */bin/sh* prompt. 

### Output to submit

Save your attack payload to `input2`. The expected running example would be like the following.

    $ cat input2 | ./crackme0x00-nonx
    CS6332 Crackme Level 00
    Password: Invalid Password!
    $ whoami
    kjee


## Part 3 (8 point): Return-to-libc

### Prepration
For this part, we will use *crackme0x00* binary again. Download *crackme0x00* from http://cs6332.syssec.org/crackmes/crackme0x00 and check its binary to ensure stack section (*GNU_STACK*) is in `RW` permission which mean you can overwrite a stack, but cannot run any code from there.

```
$ readelf -W -l ./crackme0x00|grep STACK
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x4
```

You need to turn off ASLR from your system in order for libraries loaded to a fixed address across different executions.

```
$ sudo echo 0 > /proc/sys/kernel/randomize_va_space
$ cat /proc/sys/kernel/randomize_va_space
0
```

### Description

From this part of the assignment, you can still hijack the control by overwriting the return address, but you don’t know where to transfer the control, to run the desired command (say */bin/sh*). In this part of the assignment, we want to use *system()* function provided by Glibc library. For its usage, please check out `man -s 3 system`.

Please write an input that would overwrite the address of *system()* to return address of main() and transfer the control at main() returns. Don't forget to prepare the argument (*/bin/sh*) of the function call from the stack.

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

$ gcc  /tmp/system.c
$ ./a.out
$ whoami
kjee
```

### Obtaining address of *system()* at runtime

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

Save your attack payload to `input3`. The expected running example would be like the following.

    $ cat input3 | ./crackme0x00
    CS6332 Crackme Level 00
    Password: Invalid Password!
    $ whoami
    kjee

###### tags: `utd`,`assignment`,`cs6332`,`r2`