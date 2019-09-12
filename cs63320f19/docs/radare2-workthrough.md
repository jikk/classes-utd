
# Tutorial for R2 + crackme0x00 


## Starting R2

```
$ tmux a
$ wget www.syssec.org/crackmes/crackme0x00
$ r2 crackme0x00
```

```
[0x08048360]> aaa    :analyze binary
[x] Analyze all flags starting with sym. and entry0 (aa)
[x] Analyze len bytes of instructions for references (aar)
[x] Analyze function calls (aac)
[x] Use -AA or aaaa to perform additional experimental analysis.
[x] Constructing a function name for fcn.* and sym.func.* functions (aan)

[0x08048493]> afl ; list functions
0x080482f8    1 23           sym._init
0x08048320    1 6            sym.imp.__libc_start_main
0x08048330    1 6            sym.imp.scanf
0x08048340    1 6            sym.imp.printf
```

## Investigating binary

```

[0x08048360]> i:(nfo)
blksz    0x0
block    0x100
fd       3
file     crackme0x00
format   elf
...

[0x08048414]> i~nx : i|grep nx
nx       true
...

[0x08048414]> ii : imports
...

[0x08048414]> is : symtab entries
...

[0x08048414]> izzz : dump all strings from the binary
...

000 0x00000028 0x08048028   4  10 (LOAD0) utf16le 4 \t(
001 0x00000154 0x08048154  18  19 (.interp) ascii /lib/ld-linux.so.2

[0x08048414]> izzz~Password
014 0x00000581 0x08048581  10  11 (.rodata) ascii Password:
016 0x00000596 0x08048596  18  19 (.rodata) ascii Invalid Password!\n
017 0x000005a9 0x080485a9  15  16 (.rodata) ascii Password OK :)\n

```

## Investigate function

```

[0x08048493]> s main # seek to main symbol
[0x08048414]> pdf # disasemble function
...

[0x08048414]> pdc ; decompiled code

[0x08048414]> v  # visual mode - rotate with 'p', hex, disasm, debug, words, buf; exit with 'q'
[0x08048414]> VV  # visual mode graph; rotate with 'p' for different BB representations; exit with 'q'

[0x0804848c]> ps @ str.250382  # string type variable
250382

[0x0804848c]> s str.250382
[0x0804858f]> pds
;-- str.250382:
0x0804858f "250382"
;-- str.Invalid_Password:
0x08048596 "Invalid Password!\n"
...
```

## Basic Command format

Command syntax: `[.][times][cmd][~grep][@[@iter]addr!size][|>pipe]`
* `;` Command chaining: `x 3;s+3;pi 3;s+3;pxo 4;`
* `|` Pipe with shell commands: `pd | less`
* `!` Run shell commands: `!cat /etc/passwd`
* `!!` Escapes to shell, run command and pass output to radare buffer
* Note: The double exclamation mark tells radare to skip the plugin list to find an IO plugin handling this command to launch it directly to the shell. A single one will walk through the io plugin list.
* `` ` `` Radare commands: `` wx `!ragg2 -i exec` ``
* `~` grep
* `~!` grep -v
* `~[n]` grep by columns `afl~[0]`
* `~:n` grep by rows `afl~:0`
```
	pi~mov,eax  		  ; lines with mov or eax
	pi~mov&eax  		  ; lines with mov and eax
	pi~mov,eax:6  		  ; 6 first lines with mov or eax
	pd 20~call[0]:0       ; grep first column of the first row matching 'call'
```
* `.cmd` Interprets command output
```
is* prints symbols
.is* interprets output and define the symbols in radare (normally they are already loaded if r2 was not invoked with -n)
```
* `..` repeats last commands (same as enter \n)
* `(` Used to define and run macros
* `$` Used to define alias
* `$$`: Resolves to current address
* Offsets (`@`) are absolute, we can use $$ for relative ones `@ $$+4`
* `?` Evaluate expression
```
[0x00000000]> ? 33 +2
35 0x23 043 0000:0023 35 00100011 35.0 0.000000

Note: | and & need to be escaped
```
* `?$?` Help for variables used in expressions
* `$$`: Here
* `$s`: File size
* `$b`: Block size
* `$l`: Opcode length
* `$j`: When `$$` is at a `jmp`, `$j` is the address where we are going to jump to
* `$f`: Same for `jmp` fail address
* `$m`: Opcode memory reference (e.g. mov eax,[0x10] => 0x10)
* `???` Help for `?` command
* `?i` Takes input from stdin. Eg `?i username`
* `??` Result from previous operations
* `?s from to [step]`: Generates sequence from <from> to <to> every <step>
* `?p`: Get physical address for given virtual address
* `?P`: Get virtual address for given physical one
* `?v` Show hex value of math expr
```
?v 0x1625d4ca ^ 0x72ca4247 = 0x64ef968d
?v 0x4141414a - 0x41414140  = 0xa
```
* `?l str`: Returns the length of string
* `@@`: Used for iterations
```
wx ff @@10 20 30      Writes ff at offsets 10, 20 and 30
wx ff @@`?s  1 10 2`  Writes ff at offsets 1, 2 and 3
wx 90 @@ sym.*        Writes a nop on every symbol
```