# Reading list

!!! Note
   [How to read academic papers](https://medium.com/ai-saturdays/how-to-read-academic-papers-without-freaking-out-3f7ef43a070f)

Particularly for systems security papers: 
    (1) Read Abstract -> Introduction -> Conclusion
    (2) Find and read a motivation (representative) example or case studies. They include a complete (and often realistic) story and how the proposed idea solves the problem with newly proposed methods. 
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

## Memory Corruption and Control Flow Hijacking 1-0-1

* [SoK: Eternal War in Memory](https://ieeexplore.ieee.org/abstract/document/6547101)
* **Smashing the Stack**: Read the following two articles
    * [Smashing the Stack in 2011](https://paulmakowski.wordpress.com/2011/01/25/smashing-the-stack-in-2011/)
    * [Smashing the Stack for Fun and Profit](http://phrack.org/issues/49/14.html#article)
* [On the effectiveness of Address-Space Randomization](https://web.stanford.edu/~blp/papers/asrandom.pdf) [CCS 04]

## ROP attacks
* [Return-Oriented Programming: Systems, Languages, and Applications](https://dl.acm.org/citation.cfm?id=2133377) [TISSEC 12]
* [Return-oriented programming without returns](https://dl.acm.org/citation.cfm?id=1866370) [CCS 12]
* [You Can Run but You Can't Read: Preventing Disclosure Exploits in Executable Code](https://www.infsec.cs.uni-saarland.de/wp-content/uploads/sites/2/2014/10/nuernberger2014ccs_disclosure.pdf) [CCS 14]
* [Readactor: Practical Code Randomization Resilient to Memory Disclosure](https://www.ics.uci.edu/~sjcrane/papers/sjcrane15_readactor.pdf) [SP 15]

## More binaries

* [(State of) The Art of War: Offensive Techniques in Binary Analysis](https://syssec-s18.unexploitable.systems/l/week04/angrSoK.pdf)
* [Framing Signals—A Return to Portable Shellcode](https://syssec-s18.unexploitable.systems/l/week03/srop.pdf)
* [APISAn: Sanitizing API Usages through Semantic Cross-Checking](https://syssec-s18.unexploitable.systems/l/week04/apisan.pdf)



## Control Flow Integrity (CFI)

* [Control-Flow Integrity](https://dl.acm.org/citation.cfm?id=1102165) [CCS 05]
* [Control Flow Integrity for COTS Binaries](https://www.usenix.org/node/174767) [SEC 13]
* [Control-Flow Bending: On the Effectiveness of Control-Flow Integrity](https://www.usenix.org/node/190961) [SEC 15]

<!--
* Efficient Path Encoding [MICRO'96]
* Precise Calling Context Encoding [ICSE'10]
* LDX: Causality Inference by Lightweight Dual Execution [ASPLOS'16]
-->






## Hardware vulnerabilities - Cases for Meltdown / Spectre Attacks

* [Meltdown: Reading Kernel Memory from User Space](https://www.usenix.org/system/files/conference/usenixsecurity18/sec18-lipp.pdf)[Sec 18]
* [Spectre Attacks: Exploiting Speculative Execution](https://spectreattack.com/spectre.pdf)[S&P 19]


## Sandboxing. Isolation, and Fault localization

* [The Security Architecture of the Chromium Browser](https://syssec-s18.unexploitable.systems/l/week05/chrome.pdf)
* [Native Client: A Sandbox for Portable, Untrusted x86 Native Code]() [S&P 09]


## Mobile/IoT Security
* iRiS: Vetting Private API Abuse in iOS Applications [CCS 15]
* GUITAR: Piecing Together Android App GUIs from Memory Images. [CCS 15]
* Fear and Logging in the Internet of Things [NDSS'18]
* IoTFuzzer: Discovering Memory Corruptions in IoT Through App-based Fuzzing [NDSS'18]
* Sensitive Information Tracking in Commodity IoT [USENIX'18]

## Kernel security 

* [ret2dir: Rethinking Kernel Isolation]() [SEC 14]
* [Breaking Kernel Address Space Layout Randomization with Intel TSX](https://dl.acm.org/citation.cfm?id=2978321) [CCS 16]
* [Linux kernel vulnerabilities: State-of-the-art defenses and open problems](https://tc.gts3.org/cs8803/2014/r/kbugs.pdf) short paper

## Audit-logging

* [High Accuracy Attack Provenance via Binary-Based Execution Partition]() [NDSS 13]
* [LogGC: Garbage Collecting Audit Log]() [CCS'13]
* [Efficient patch-based auditing for web application vulnerabilities]() [OSDI 12]

## Dynamic/Static Analysis Frameworks

* [Pin: building customized program analysis tools with dynamic instrumentation [PLDI'05]]()
* [Valgrind: A Framework for Heavyweight Dynamic Binary Instrumentation [PLDI'07]]()
* [LLVM: A Compilation Framework for Lifelong Program Analysis & Transformation [CGO'04]]()
* [Anywhere, any-time binary instrumentation](ftp://128.105.2.31/pub/paradyn/papers/Bernat11AWAT.pdf)

## Misc
* [Inferring Fine-grained Control Flow Inside SGX Enclaves with Branch Shadowing](https://www.usenix.org/system/files/conference/usenixsecurity17/sec17-lee-sangho.pdf) [SEC 17]
* [High-Resolution Side Channels for Untrusted Operating Systems](https://syssec-s18.unexploitable.systems/l/week06/sgx-side.pdf)[ATC 17]

## Data-flow tracking and Data-flow analysis
* libdft: Practical Dynamic Data Flow Tracking for Commodity Systems [VEE'12]
* A General Approach for Efficiently Accelerating Software-based Dynamic Data Flow Tracking on Commodity Hardware [NDSS'12]
* LDX: Causality Inference by Lightweight Dual Execution [ASPLOS'16]

## Control-flow tracking and Control-flow analysis


## Evasive techniques
* Evading android runtime analysis via sandbox detection [ASIACCS'14]
* Detecting Malware and Sandbox Evasion Techniques [SANS InfoSec Reading Room]

## News Article
* X-Force: Force-Executing Binary Programs for Security Applications [USENIX'14]
* Revolver: An Automated Approach to the Detection of Evasive Web-based Malware [SP'13]

## Code obfuscation/de-obfuscation
* Deobfuscation of virtualization-obfuscated software: a semantics-based approach [CCS'11]
* LOOP: Logic-Oriented Opaque Predicate Detection in Obfuscated Binary Code [CCS'15]
* Code obfuscation against symbolic execution attacks [ACSAC'16]

## Record and replay / N-version systems
* Intrusion recovery using selective re-execution [OSDI'10]
* Record and transplay: partial checkpointing for replay debugging across heterogeneous systems [SIGMETRICS'11]
* Transparent Mutable Replay for Multicore Debugging and Patch Validation [ASPLOS'13]
* Varan the Unbelievable: An Efficient N-version Execution Framework [ASPLOS'15]

]

## Sandboxing/isolation, Fault localization


----
Page last revised on: {{ git_revision_date }}