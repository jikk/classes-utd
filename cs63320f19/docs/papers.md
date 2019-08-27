# Paper list

[How to read academic papers](https://medium.com/ai-saturdays/how-to-read-academic-papers-without-freaking-out-3f7ef43a070f)

Particularly for systems security papers: (1) Read Abstract -> Introduction -> Conclusion, (2) Find and read a motivation (representative) example or case studies. They include a complete (and often realistic) story and how the proposed idea solves the problem with newly proposed methods. 


* Dynamic/Static Analysis Frameworks. 

    * Pin: building customized program analysis tools with dynamic instrumentation [PLDI'05]
    * Valgrind: A Framework for Heavyweight Dynamic Binary Instrumentation [PLDI'07]
    * LLVM: A Compilation Framework for Lifelong Program Analysis &
      Transformation [CGO'04]

* Data-flow tracking and Data-flow analysis
    * libdft: Practical Dynamic Data Flow Tracking for Commodity Systems [VEE'12]
    * A General Approach for Efficiently Accelerating Software-based Dynamic Data Flow Tracking on Commodity Hardware [NDSS'12]
    * LDX: Causality Inference by Lightweight Dual Execution [ASPLOS'16]

* Control-flow tracking and Control-flow analysis
    * Control-Flow Integrity [MSR-TR-05-18]
    * Efficient Path Encoding [MICRO'96]
    * Precise Calling Context Encoding [ICSE'10]
    * LDX: Causality Inference by Lightweight Dual Execution [ASPLOS'16]

* Evasive techniques
    * Evading android runtime analysis via sandbox detection [ASIACCS'14]
    * Detecting Malware and Sandbox Evasion Techniques [SANS InfoSec Reading Room]

* News Article
    * X-Force: Force-Executing Binary Programs for Security Applications [USENIX'14]
    * Revolver: An Automated Approach to the Detection of Evasive Web-based Malware [SP'13]

* Code obfuscation/de-obfuscation
    * Deobfuscation of virtualization-obfuscated software: a semantics-based approach [CCS'11]
    * LOOP: Logic-Oriented Opaque Predicate Detection in Obfuscated Binary Code [CCS'15]
    * Code obfuscation against symbolic execution attacks [ACSAC'16]

* Record and replay / N-version systems
    * Intrusion recovery using selective re-execution [OSDI'10]
    * Record and transplay: partial checkpointing for replay debugging across heterogeneous systems [SIGMETRICS'11]
    * Transparent Mutable Replay for Multicore Debugging and Patch Validation [ASPLOS'13]
    * Varan the Unbelievable: An Efficient N-version Execution Framework [ASPLOS'15]

* Audit-logging
    * High Accuracy Attack Provenance via Binary-Based Execution Partition [NDSS'13]
    * LogGC: Garbage Collecting Audit Log [CCS'13]
    * Efficient patch-based auditing for web application vulnerabilities [OSDI'12]

* Web/Browser Security
    * The Security Architecture of the Chromium Browser 
    * UCognito: Private Browsing without Tears [CCS'15] 
    * WebCapsule: Towards a Lightweight Forensic Engine For Web Browsers  [CCS'15]
    * Riding out DOMsday: Toward Detecting and  Preventing DOM Cross-Site Scripting [NDSS'18]
    * FlashDetect: ActionScript 3 malware detection [RAID'12]
    * The Postman Always Rings Twice: Attacking and Defending postMessage in HTML5 Websites [NDSS'13]

* Sandboxing/isolation, Fault localization
    * Native Client: A Sandbox for Portable, Untrusted x86 Native Code [SP'09]
    * Mobile/IoT Security
    * iRiS: Vetting Private API Abuse in iOS Applications [CCS'15]
    * GUITAR: Piecing Together Android App GUIs from Memory Images. [CCS'15]
    * Fear and Logging in the Internet of Things [NDSS'18]
    * IoTFuzzer: Discovering Memory Corruptions in IoT Through App-based Fuzzing [NDSS'18]
    * Sensitive Information Tracking in Commodity IoT [USENIX'18]

* Machine Learning (Added)
    * Learning from Mutants: Using Code Mutation to Learn and Monitor Invariants of a Cyber-Physical System 
    * DeepXplore: Automated Whitebox Testing of Deep Learning Systems
    * Towards Deep Learning Models Resistant to Adversarial Attacks

----
Page last revised on: {{ git_revision_date }}