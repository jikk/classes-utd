# Quiz 1 (10pt) - Disassembling binary and patching

From this exercise, we aim to run the basics of binary reverse engineering to find a secret from binary, modify its value, and change the execution.

## Exercise description

### [Step 0] Set-up your environment (Ubuntu VM)

* Download [VirtualBox](https://www.virtualbox.org/wiki/Downloads) install it to your computer.
* Create a [Ubuntu 16.04 (64-bit)](http://releases.ubuntu.com/16.04/) VM instance
* After initial boot, enable 64-bit Ubuntu to run 32-bit executables by running,
```bash
    sudo apt update
    sudo apt install libc6-i386
```

2. Install necessary tools
    * [gdb-peda](https://github.com/longld/peda), [radare2](https://github.com/radare/radare2) ...

3. Download binaries from the folliwng links
    [crackme0x00](http://www.syssec.org/crackmes/crackme0x00), [crackme0x01](http://www.syssec.org/crackmes/crackme0x01), [crackme0x02](http://www.syssec.org/crackmes/crackme0x02)

### [Part 1 - 3pt] Find the secret

* Reverse engineering three payloads with Radare 2 (or with your favorite tools) to find a secret. Write a secret value to *README.md* and simple description of how did you find secrets.

### [Part 2 - 3pt] Modify binary to change the secret

For *crackme0x00* and *crackme0x01* payloads, you will modify binaries to change the secret values. The new secret value will be specific to your *net_id*. The following will give you new secret value. 

```bash
$ export m=$(echo "<your_net_id>" |md5sum |cut -d ' ' -f 1|tr '[:lower:]' '[:upper:]') ;echo "obase=10; ibase=16; ${m: -4}"|bc

```

Modified binaries will be named as below. 

```bash
crackme0x00_<your_net_id>
crackme0x01_<your_net_id>
```

### [Part 3 - 4pt] Modify binary to change execution

For *crackme0x01* and *crackme0x02* payloads, overwrite an instruction so as to print success message regardless of its inputs. Modified binary will be named as below.

```bash
crackme0x01_jmp
crackme0x02_jmp
```

### [Extra] other tools?

* IDA Pro (free version), Ghidra (open-sourced by NSA)
* Tools for the same purpose, with better GUI interface.
* Share your experience! (15 ~ 20 min) This can replace paper presentation.

## Submission

*Tar/gzip* your outputs using the following command and upload it to eLearning. For each part, please add simple description regarding how did you get the result.

```sh
tar cvzf cs6332q01.tgz README.md crackme0x0?_* 
```