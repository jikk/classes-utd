
# Tutorial for R2 + crackme0x00 

```
➜  quiz0 wget www.syssec.org/crackmes/crackme0x00

[0x08048360]> aaa    :analyze binary
[x] Analyze all flags starting with sym. and entry0 (aa)
[x] Analyze len bytes of instructions for references (aar)
[x] Analyze function calls (aac)
[x] Use -AA or aaaa to perform additional experimental analysis.
[x] Constructing a function name for fcn.* and sym.func.* functions (aan)

## Investigating binary

[0x08048360]> i:(nfo)
blksz    0x0
block    0x100
fd       3
file     crackme0x00
format   elf
...

[0x08048414]> i~nx
nx       true

[0x08048414]> izzz

000 0x00000028 0x08048028   4  10 (LOAD0) utf16le 4 \t(
001 0x00000154 0x08048154  18  19 (.interp) ascii /lib/ld-linux.so.2

[0x08048414]> izzz~Password
014 0x00000581 0x08048581  10  11 (.rodata) ascii Password:
016 0x00000596 0x08048596  18  19 (.rodata) ascii Invalid Password!\n
017 0x000005a9 0x080485a9  15  16 (.rodata) ascii Password OK :)\n
```

