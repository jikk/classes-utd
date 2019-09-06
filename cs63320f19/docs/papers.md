# Reading list

!!! Note
    Particularly for systems security papers:

    (1) Read Abstract &rarr; Introduction &rarr; Conclusion.

    (2) Find and read a motivation (representative) example or case studies. They include a complete (and often realistic) story and how the proposed idea solves the problem with newly proposed methods.

    **TIP**: [How to read academic papers](https://medium.com/ai-saturdays/how-to-read-academic-papers-without-freaking-out-3f7ef43a070f)
---

<!-- 
## Sources

* [VPK](https://cs.brown.edu/courses/csci2951-u/lectures.html#l01)
* [Suman seminar course](http://www.cs.columbia.edu/~suman/coms_e6183.html)
* [Taesoo Kim seminar course](https://tc.gts3.org/cs8803/2014/cal.html)
* [Suman system security course](http://www.cs.columbia.edu/~suman/security_1.html)
* [Youngjin Jang - seminar course](https://syssec-s18.unexploitable.systems/cal.html)
* [Mu Zhang seminar course](https://sites.google.com/site/muzhang82/cs6956-001-2019fall)
-->

## Memory Corruption and Control Flow Hijacking

* [SoK: Eternal War in Memory](https://ieeexplore.ieee.org/abstract/document/6547101)
* **Smashing the Stack**: Read the following two articles
      * [Smashing the Stack for Fun and Profit](http://phrack.org/issues/49/14.html#article)
      * [Smashing the Stack in 2011](https://paulmakowski.wordpress.com/2011/01/25/smashing-the-stack-in-2011/)
* [On the effectiveness of Address-Space Randomization](https://web.stanford.edu/~blp/papers/asrandom.pdf) [CCS 04]

## ROP Attacks

* [Return-Oriented Programming: Systems, Languages, and Applications](https://dl.acm.org/citation.cfm?id=2133377) [TISSEC 12]
* [Return-oriented programming without returns](https://dl.acm.org/citation.cfm?id=1866370) [CCS 12]
* [You Can Run but You Can't Read: Preventing Disclosure Exploits in Executable Code](https://www.infsec.cs.uni-saarland.de/wp-content/uploads/sites/2/2014/10/nuernberger2014ccs_disclosure.pdf) [CCS 14]
* [Readactor: Practical Code Randomization Resilient to Memory Disclosure](https://www.ics.uci.edu/~sjcrane/papers/sjcrane15_readactor.pdf) [SP 15]

## Control Flow and Code Pointer Integrity

* [Control-Flow Integrity](https://dl.acm.org/citation.cfm?id=1102165) [CCS 05]
* [Control Flow Integrity for COTS Binaries](https://www.usenix.org/node/174767) [SEC 13]
* [Code-Pointer Integrity](https://syssec-s18.unexploitable.systems/l/week03/cpi.pdf) [OSDI 2014]

## More Binary Attack and Defenses

### Advanced Attacks

* [Framing Signals—A Return to Portable Shellcode](https://syssec-s18.unexploitable.systems/l/week03/srop.pdf)
* [APISAn: Sanitizing API Usages through Semantic Cross-Checking](https://syssec-s18.unexploitable.systems/l/week04/apisan.pdf)
* [(State of) The Art of War: Offensive Techniques in Binary Analysis](https://syssec-s18.unexploitable.systems/l/week04/angrSoK.pdf)

### Integer Vulnerabilities and Defenses

* [Understanding Integer Overflow in C/C++](http://www.cs.utah.edu/~regehr/papers/overflow12.pdf) [ICSE 2012]
* [Improving Integer Security for Systems with KINT](https://syssec-s18.unexploitable.systems/l/week04/kint.pdf) [OSDI 12]

## Dynamic/Static Analysis Frameworks

* [Pin: building customized program analysis tools with dynamic instrumentation](https://www.cs.ucr.edu/~heng/teaching/cs260-winter2017/luk05pin.pdf) [PLDI 05]
* [Valgrind: A Framework for Heavyweight Dynamic Binary Instrumentation](http://valgrind.org/docs/valgrind2007.pdf) [PLDI 07]
* [LLVM: A Compilation Framework for Lifelong Program Analysis & Transformation](https://llvm.org/pubs/2003-09-30-LifelongOptimizationTR.pdf) [CGO'04]
* DynInst [Anywhere, any-time binary instrumentation](ftp://128.105.2.31/pub/paradyn/papers/Bernat11AWAT.pdf) [PASTE 11]
* [AddressSanitizer: A Fast Address Sanity Checker](https://www.usenix.org/system/files/conference/atc12/atc12-final39.pdf) [ATC 12]

<!--  More control flow
* [Control-Flow Bending: On the Effectiveness of Control-Flow Integrity](https://www.usenix.org/node/190961) [SEC 15]
* Efficient Path Encoding [MICRO'96]
* Precise Calling Context Encoding [ICSE'10]
* LDX: Causality Inference by Lightweight Dual Execution [ASPLOS'16]
-->

## Dynamic Analysis

* [libdft: Practical Dynamic Data Flow Tracking for Commodity Systems](https://dl.acm.org/citation.cfm?id=2151042) [VEE 12]
* [A General Approach for Efficiently Accelerating Software-based Dynamic Data Flow Tracking on Commodity Hardware](https://liberty.princeton.edu/Publications/ndss12_tfa.pdf) [NDSS 12]
* [FlowDroid: Precise Context, Flow, Field, Object-sensitive and Lifecycle-aware Taint Analysis for Android Apps](https://www.bodden.de/pubs/far+14flowdroid.pdf) [PLDI 14]
* [LDX: Causality Inference by Lightweight Dual Execution]() [ASPLOS 16]

## Static Analysis

* [Compiler-assisted Code Randomization](https://www3.cs.stonybrook.edu/~mikepo/papers/ccr.sp18.pdf) [SP 18]

## Symbolic Execution

* [KLEE: Unassisted and Automatic Generation of High-Coverage Tests for Complex Systems Programs](https://dl.acm.org/citation.cfm?id=1855741.1855756) [OSDI 08]
* [(State of) The Art of War: Offensive Techniques in Binary Analysis](https://syssec-s18.unexploitable.systems/l/week04/angrSoK.pdf) [SP 16]

## Virtualization and Security

* [When Virtual is Harder than Real: Security Challenges in Virtual Machine Based Computing Environments](http://dforeman.homedns.org/~dj/550pages/Readings/garfinkle05when.pdf) [HotOS 05]
* [Virtualization: Issues, Security Threats, and Solutions](https://pdfs.semanticscholar.org/1ee8/0058d38b69ceed7ad22b3bf4c55040b1c2ec.pdf)
* [CloudVisor: Retrofitting Protection of Virtual Machines in Multi-tenant Cloud with Nested Virtualization](https://www.researchgate.net/profile/Haibo_Chen9/publication/220910130_CloudVisor_Retrofitting_protection_of_virtual_machines_in_multi-tenant_cloud_with_nested_virtualization/links/559dba5d08ae76bed0bb4730/CloudVisor-Retrofitting-protection-of-virtual-machines-in-multi-tenant-cloud-with-nested-virtualization.pdf) [SOSP 11]
* [Hey, You, Get Off of My Cloud: Exploring Information Leakage in Third-Party Compute Clouds](https://css.csail.mit.edu/6.858/2011/readings/get-off-my-cloud.pdf) [CCS 09]

## Kernel security

* [Linux kernel vulnerabilities: State-of-the-art defenses and open problems](https://tc.gts3.org/cs8803/2014/r/kbugs.pdf) short paper
* [ret2dir: Rethinking Kernel Isolation](https://www.usenix.org/system/files/conference/usenixsecurity14/sec14-paper-kemerlis.pdf) [SEC 14]
* [Breaking Kernel Address Space Layout Randomization with Intel TSX](https://dl.acm.org/citation.cfm?id=2978321) [CCS 16]


## Sandboxing: Isolation, and Fault localization

* [The Security Architecture of the Chromium Browser](https://syssec-s18.unexploitable.systems/l/week05/chrome.pdf)
* [Native Client: A Sandbox for Portable, Untrusted x86 Native Code](https://syssec-s18.unexploitable.systems/l/week05/nacl.pdf) [S&P 09]
* [Spotless Sandboxes: Evading Malware Analysis Systems using Wear-and-Tear Artifacts](https://www3.cs.stonybrook.edu/~mikepo/papers/wearntear.sp17.pdf) [SP 17]

## IoT and CPS Security

<!--
Refer to Mu Zhang, Yonghwi list

* [iRiS: Vetting Private API Abuse in iOS Applications](https://cyfi.ece.gatech.edu/publications/CCS_15_iRiS.pdf) [CCS 15]
-->

* [GUITAR: Piecing Together Android App GUIs from Memory Images](https://dl.acm.org/citation.cfm?id=2813650) [CCS 15]
* [Fear and Logging in the Internet of Things](http://seclab.illinois.edu/wp-content/uploads/2017/12/wang2018fear.pdf) [NDSS 18]
* [IoTFuzzer: Discovering Memory Corruptions in IoT Through App-based Fuzzing](https://web.cse.ohio-state.edu/~lin.3021/file/NDSS18b.pdf) [NDSS 18]
* [Sensitive Information Tracking in Commodity IoT](https://www.usenix.org/system/files/conference/usenixsecurity18/sec18-celik.pdf) [SEC 18]

* [Stuxnet: Dissecting a Cyberwarfare Weapon](https://ieeexplore.ieee.org/abstract/document/5772960) [SP 11]
    * [Revealed: How a secret Dutch mole aided the U.S.-Israeli Stuxnet cyberattack on Iran](https://news.yahoo.com/revealed-how-a-secret-dutch-mole-aided-the-us-israeli-stuxnet-cyber-attack-on-iran-160026018.html) [News article]

<!--
* [Efficient patch-based auditing for web application vulnerabilities]() [OSDI 12]
-->

## Threat Intelligence Computing

* [Threat Intelligence Computing](https://dl.acm.org/citation.cfm?id=3243829) [CCS 18]
* [Reading the Tea leaves: A Comparative Analysis of Threat Intelligence](https://www.usenix.org/conference/usenixsecurity19/presentation/li) [SEC 19]
* [Understanding and Securing Device Vulnerabilities through Automated Bug Report Analysis](https://www.usenix.org/conference/usenixsecurity19/presentation/feng) [SEC 19]
* [ATTACK2VEC: Leveraging Temporal Word Embeddings to Understand the Evolution of Cyberattacks](https://www.usenix.org/conference/usenixsecurity19/presentation/shen) [SEC 19]

## Audit-logging and Provenance Analysis

* [Traps and Pitfalls: Practical Problems in System Call Interposition Based Security Tools](https://www.ndss-symposium.org/wp-content/uploads/2017/09/Traps-and-Pitfalls-Practical-Problems-in-System-Call-Interposition-Based-Security-Tools-Tal-Garfinkel.pdf) [NDSS 03]
* [LogGC: Garbage Collecting Audit Log](https://friends.cs.purdue.edu/pubs/LogGC.pdf) [CCS 13]
* [Towards a Timely Causality Analysis for Enterprise Security](https://kangkookjee.github.io/publications/liu-ndss2018.pdf) [NDSS 18]


### Code obfuscation/de-obfuscation

* [SoK: Deep Packer Inspection: A Longitudinal Study of the Complexity of Run-Time Packers](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=7163053) [SP 15]
* Deobfuscation of virtualization-obfuscated software: a semantics-based approach [CCS'11]
* LOOP: Logic-Oriented Opaque Predicate Detection in Obfuscated Binary Code [CCS'15]
* Code obfuscation against symbolic execution attacks [ACSAC'16]

## Hardwares

### Hardware Vulnerabilities - Cases for Meltdown / Spectre Attacks

* [Meltdown: Reading Kernel Memory from User Space](https://www.usenix.org/system/files/conference/usenixsecurity18/sec18-lipp.pdf)[Sec 18]
* [Spectre Attacks: Exploiting Speculative Execution](https://spectreattack.com/spectre.pdf)[S&P 19]

### Hardware and Enclave (SGX) Security

* [Inferring Fine-grained Control Flow Inside SGX Enclaves with Branch Shadowing](https://www.usenix.org/system/files/conference/usenixsecurity17/sec17-lee-sangho.pdf) [SEC 17]
* [High-Resolution Side Channels for Untrusted Operating Systems](https://syssec-s18.unexploitable.systems/l/week06/sgx-side.pdf)[ATC 17]
* [Graphene-SGX: A Practical Library OS for Unmodified Applications on SGX](https://www.usenix.org/conference/atc17/technical-sessions/presentation/tsai) [ATC 17]

<!-- 
### Evasive techniques

* Evading android runtime analysis via sandbox detection [ASIACCS'14]
* Detecting Malware and Sandbox Evasion Techniques [SANS InfoSec Reading Room]

## News Topics
* X-Force: Force-Executing Binary Programs for Security Applications [USENIX'14]
* Revolver: An Automated Approach to the Detection of Evasive Web-based Malware [SP'13]

## Record and replay / N-version systems
* Intrusion recovery using selective re-execution [OSDI'10]
* Record and transplay: partial checkpointing for replay debugging across heterogeneous systems [SIGMETRICS'11]
* Transparent Mutable Replay for Multicore Debugging and Patch Validation [ASPLOS'13]
* Varan the Unbelievable: An Efficient N-version Execution Framework [ASPLOS'15]
-->

----
Page last revised on: {{ git_revision_date }}