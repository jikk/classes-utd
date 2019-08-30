# Project ideas

## General guideline

In this page, I list a few *exemplary* project ideas to help you. Please note that this is to give you a guideline regarding my expectation for the course project.

I wish the list can help you developing the right senses for the proper problem definition, size of the project, and techniques to be used. The list generally reflects my research interest and expertise, and I believe you can think hard to find security problems that would interest you the most. My preference is to see your project is about a problem defined and proposed by you. It is always better to have a course project in which you find yourself interested.
It is okay for you to pick one of the following project ideas. Taking it as one starting point, you can either work all the way or diverge to pursue your direction as the project proceeds.

The course is about *system security* and I expect the course project and related techniques remain around the vicinity of system security topics and techniques. However, if you are compelled to have a problem less relevant to system security, please feel free to find me and discuss. The bottom line is that it still has to be a security problem.

Please find your team members as early as you can and have as much discussion as possible. If you need any help or want to consult with me, you can always find me during my office hours or send an email to set up an appointment. 

### Expected outcomes

The followings project outcomes that I expect to see at the end of semester.

* Project documentation (small/medium version research paper)
* Project source code with documentations (comments, API ...)
* Project Demo

For the course project, I will strongly encourage students to aim high to produce an outcome with larger impact. With an interesting problem, and solid result, a student or a team of students can shoot for undergraduate or master thesis or a publication from a academic conference.

------------------------------------------------------------------------

## System call level data collection for behavioral security analysis

### Motivation

* In implementing in-host (vs. out-host or network) security measures efficient and reliable source for data collection is an essential building block.

* While different design choices are available in terms of monitoring granularities, system call level monitoring seems to be reasonable compromise consideration in terms of performance overhead and monitoring accuracy (granularity). Many existing in-host monitoring solutions choose a subset of system calls to capture, monitor and report for security analysis. 

* Can we implement a better data collection for system call tracing?

* Leveraging the existing system call collection mechanisms (say sysdig, or dtrace, linux audit), how much overhead that we expect? can we collect and 

* This area is in large demand and can spun into a number of different research directions. 

### Project idea 1: System-call level data collection framework for Windows

* A number of existing implementation exists for Linux systems (Linux Audit, OSX DTrace, Sysdig project), but not many implementation exists for Windows operating systems. 

* The main purpose of the project will be implementing MS Windows version of system call level data collection framework. Students will study and investigate a cadidate data source [ETW (Event Tracing for Windows)](). 

* Students with previous experience MS Windows system programming may find this project interesting. 

### Project idea 2: A comparision study of different system call data collection frameworks

* We it is previously mentioned, we have different data collection sources (Linux Audit, Sysdig, DTrace ...) that can run on a same system (say Linux). Students can try to build a same data collection framework for leveraging different mechanisms to  compare the efficency and capability. 

* Project can start by 
    * Data collection implemented/configured to collection the same subset of system calls (e.g., read(), write(), exec(), fork(), send(), recve()) and run those against standardized workload (e.g., benchmark suites and workloads). 

### Project idea 3: User-level support for process-DNS query association

* Besides system call entries which can be obtained by the above mentioned data sources, we have other interested system events with higher/more security implications worth collected and analyzed. DNS is one of those information, traditionally collected from outside the host, only to associated to the host level without having the finer association with regard to a process which process actually initiated the DNS query of our interestes. 

* A previous of previous proposal exists leveraging kernel level association or system interfaces. These turn out to be too intrusive enforcing users to kernel modules or to be subject to unexpected changes of system implementation.

* The project will implement the process-DNS association much lighter fashion without loosing/sacrifing the accuracy, but associating and cor-relating network system call (i.e., send(), recv()) and PCAP data.

* With this project aim to bridge the gap between two different domains of network and system security. 

### Project idea 4: TPM leveraged Integrity and Safety Assurance for Edge Data Collection Agent
* In implementing host-based security solutions, the guarantee for integrity of data collection agent and trustworthiness of its report have  always been a challenging problem. For instance, the security analyst from Security Operation Center (SoC) does not have many options to confirm reports from end-devices (e.g., computers, servers, IoT devices) are indeed genunie (uncompromised). 

* In this project, we want to leverage the hardware encoded security to build a root of trust for end-host security monitoring agents and confirm the authenticity and integrity of its status and messages it is reporting.

* From the project, students will 
    * Investigate and study threat model for end-host security agent.
    * Inverstigate the capability and limitation of generally used TPM devices.
    * Design and propose different level of security design and their trade-offs.
    * Build prototype for TPM leveraged data collection agent 
----

## Binary Similarity Analysis to Detect Supply Chain Attack

* Newly updated programs may contain security backdoor. 
* Without source code in hand can we measure the difference and specify the changes made to the code?
* Students can compare binaries of different versions program analysis representation such Control-Flow Graph (CFG), Function call graph. 
* Such feature may provide an important and useful primitive detecting and mitigating the latest threats such as [supply-chain-attacks](https://arstechnica.com/information-technology/2019/08/the-year-long-rash-of-supply-chain-attacks-against-open-source-is-getting-worse/). 
    * Many different ways for such attacks to be implanted to a public and well-trusted sources. 
    * The software vendor may implant attack vectors to get capabilities beyond its users expectation pretending it to be as a mere functionality extension.
    * Or the active attacker plays a hat of open source programer and contribute to a widely adopted projects pretending to be a simple functionality extensions. 

### Project steps

1. Literature survey
2. Impelement your own prototype example
    *  Choose a not-to-big but interesting open source project
    *  Build the source to produce a bianry. 
    *  Extract program representation against the binary.
3. Inject a threat vector(e.g., simple backdoor)
    *  Build the source to produce a bianry. 
    *  Extract program representation against the binary.
4. Compare two representations to confirm your approach.
5. Apply your approach to real softwares
    * You can test your approach with ....

### References

* [Towards Automatic Software Lineage Inference](https://users.ece.cmu.edu/~jiyongj/papers/usenixsec13.pdf)
    * Usenix Security 2013
----

## Edge TPU related project

* Google and Nvidia deployed edge-based computing devices for accelerating machine learning workloads. 
    * [Nvidia Jetson nano]()
    * [Google Edge TPU processing board]()

* The motivation behind the direction is to offload expensive tasks of data transfer to the cloud and processing to on-the-spot edge devices.

* While this open a new computational model and further facilitates new usage cases with the various applications based on accelerated ML support on-the-fly, at the same time it can also bring new security landscapes eitherproviding new ways of implementing security task or exposing new attack surface for the adversaries can aim to take over.

### Project idea 1: Security application using Edge-TPU

* With new device and its new capability, students can be wild and creative to propose a new security application. 
* Note that image and video at the edge devices (similar size of Raspberry Pi board) will have much larger throughout and performed much faster.
 
### Project idea 2: Protecting assets from Edge-TPU
* With new edge device, important intellectual assets such as Prediction Model needs to be offloaded and transferred to each edge devices. 
* For the portablity nature of Edge device, adversary can easily obtain devices phsycally or over the network. 
* For the project, students can think of ways to prevent such assets from being taken over by the adversary. 
* Students needs to consider both runtime and offline aspects. 
* Note that CPU components of the devices by default [Trustzone]() featuress. 
----

## Improvement for Automated Large-scale Malware Analysis Study

Recently, we observe millions of allegedly payloads are found and reported daily and this phenomenon pushes the task of manual investigation and analysis nearly infeasilble. Industry and academia together have proposed and worked on automated framework to scale process and analyze malware payloads by implemented automated security sandbox for security and malware analysis. Yet, such proposal has improved the status, we as a community yet to see many pitfalls and limitation in replaying malware and capture the essence of malicious behavior. From this project, students will perform the following tasks.

* First implement one of the most well-known [opensource sandbox for malware analysis](https://www.cuckoo.org). 

* Write behavioral signature by extending a Cuckoo community API to better judge whethter a given payload is indeed malicous thus require further investigation.

* Investigate different techniques (Anti-VM, Anti-Debug) that give malware writers employs to probes the sandbox execution to silencing any of malicious behaviors, thus can remain undetected/undiscovered by the analysis.

* For a given malware payload, extend the sandbox framework by implementing functionalities to spot anti-debugging techinques and find a way to go around it.

### References
* [Cuckoo Sandbox]()
* [Cuckoo Community]()
* [Spotless Sandboxes: Evading Malware Analysis Systems using Wear-and-Tear Artifacts](https://securitee.org/files/wearntear-oakland2017.pdf)

----
## Implementation of Advanced Persitent Threat (APT) framework for Security Evaluation

More research and industry together focuses on Advanced Persistent Threat (APT) designed and launched by nation-level threat actors. Different approaches to monitor, analyze, and mitigate such attacks are proposed. However, research and industry together lacks in framework level support for testing and confirm their effectiveness in protecting valuable assets against such attempts. In this project, students will

* First, perform a literature research APT attacks.
* Build a mini-lab environment that would emulate a real-world enterprise environment.
* Implement and document a number of APT cases 

### References
* APT Notes - Github project: [new repo](https://github.com/aptnotes/data), [old repo](https://github.com/kbandla/APTnotes)
* [APT3 scenario by MITRE]()

----
## Steganography or image forensics -- Analysis and defense for malcious payload embedded documentation

Steganography has been an effective techinques for the hacker community in embedding different types of malcious payloads into seemingly benign document to evade security detection measures. This provides attacker easy way to propagated their malicious payloads yet remain undetected by any security measure. When you see any databases or public resources for malware collections, you realizes malware-embedded documents now take majority. 

* [Analyzing Malicious Documents Cheat Sheet](https://zeltser.com/analyzing-malicious-documents/)
* https://www.youtube.com/watch?v=np0mPy-EHII
* [Steganography: A Safe Haven for Malware](https://securityintelligence.com/steganography-a-safe-haven-for-malware/)
* https://books.google.com/books?hl=en&lr=&id=qMB9AiFUWF0C&oi=fnd&pg=PP1&ots=glBaUv19cd&sig=VrUI34kRvs67Lf7r7EMHNRbBtz0
* ['Dresden Image Database' for benchmarking digital image forensics](https://dl.acm.org/citation.cfm?id=1774427)

## Comparsion of process-level instrumentation approachs virtualization 
* As our course proceeds, we will learn a number of different choices in instrumenting software program to introspect process and system internals at runtime. The one can leverage such frameworks to monitor, analyze, and mitigate process and system activities. 
    * Instrumentation frameworks
        * Binary re-writing: [DynInst]()
        * Process-level: [PIN](), [Valgrind](), [DynamoRIO]()
        * System-level: [QEmu]()

* While we have different options and frameworks in implemening such meastures, design options and its trade-offs are not fully explored by the literatures.

* For this project, students will
    * First, study and understand different instrumentation frameworks
    * Implement security/program analysis using the framework
        * E.g., Control Flow Graph generator
    * Define a standard workload to run and measure overhead, and usability.

### Resources

* [Pin project](), [Pin paper]()
* [DynamoRio project](), [DynamoRio paper]()
* [Valgrind project](), [Valgrind paper]()
* [QEmu project](), [QEmu paper]()
* [DynInst project](), [DynInst paper]()

## Automated IOC processing to produce actionable security rules

*Indicator of Compromise (IOC)* indicates an artifact observed on a network or in an operating system that, with high confidence, indicates a computer intrusion. While IOC transforms the game security by cultivating the smooth exchange of security indicators. To further facilitates security information exchange by addressing the complexity and hectic nature of such security information that we have observed with the existing protocol (e.g., [Yara rules]()),  a number of different standards are proposed and work on progress ([STIX](), [TAXI]()). While these proposals attempt to address large portion of problem domain, still we have non-negligible rooms remain for improvements, for instance, many of important security IOCs are posted in a hard to parse not confirming to Internet standard. For instance, many security analysis are written in a plain English in a form of technical report, whitepaper, or blog postings. 

From this project, student will attempts to parse malformed security indicators into STIX or TAXI conpatiable formation, so as it can be properly translated into standard IOC format and further circulated.  

----

Page last revised on: {{ git_revision_date }}