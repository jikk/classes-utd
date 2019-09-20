------------------------------------------------------------------------

## System call level data collection for behavioral security analysis

### Motivation

In modern security scene, many security solutions are based on data collected from each end-host (vs. out-host or perimeter network monitoring).
Therefore, it is essential to have an efficient and robust data collection agent at each end-host. Many existing in-host monitoring solutions choose to collect a subset of system calls and their argument for security analysis. Efficient and reliable data collection at end-host is high demand, and provide essential building block data-driven security research. Therefore, it brings in a number of interesting research questions such as can we implement a better data collection for system call tracing? What the information that we want to collect from end-host?

### Project direction 1: System-call level data collection mechanism comparison study

We have several existing data collection mechanisms([Linux Audit](http://todo), [DTrace](http://todo), [Sysdig](http://todo), [osquery](http://todo), [Bluespawn](http://todo)). While most support Linux, we have a few works for Windows and OSX.
Students can implement the same data collection policies for leveraging the different framework to compare efficiency and capability. 
For instance, student will need to configure data collection mechanisms to collect  the same subset of system calls (*e.g.,* read(), write(), exec(), fork(), send(), recv()).
Then the student will run those against standardized workload (*e.g.,* benchmark suites) and measure the overhead.

### Project direction 2: User-level support for process-DNS query association

Traditional syscall-level monitoring is limited, since system call sequences do not convey much security implication for itself. So we want to explore other events with higher security implications worth collected and analyzed. DNS is one of such indicators, which has been collected by network-level monitoring (e.g., firewall), outside the host.  Therefore, we have only been able to  associate DNS query to the host, without knowing which process initiated the query.

The existing solution gets this implement by installing a kernel module to define the association between the process to mbuf, which later be transferred to the user-level agent. The approach turns out to be too intrusive affecting the system stability. The user also needs to re-install kernel modules for every system update.
The project will implement the process-DNS association much lighter fashion by associating two information sources available at user-level. The one is network system call (i.e., send(), recv()) trace and the other is PCAP data.

<p><img alt="PDNS diagram" src="https://i.imgur.com/Q9Cy6Yt.jpg" width="65%"/></p>  
<br>

### Project direction 3: Collect system data for high-level security analytic

You can install data collection agent to your system to collect and store the interesting system events 24x7 and to model system and application behaviors.

----

## Binary Similarity Analysis to Detect Supply Chain Attack

[Supply-chain attack](https://arstechnica.com/information-technology/2019/08/the-year-long-rash-of-supply-chain-attacks-against-open-source-is-getting-worse/) i is a new breed of attack that incurs severe damage to software development and deployment model. From the user perspective, without source code in hand can we measure the difference and specify the changes made to the software.
In this project, students can come up with an analysis approach that compares binaries (or bytecodes). The analysis may leverage different representations such Control-Flow Graph (CFG), Function call graph to calculate the delta. The analysis can provide useful primitives detecting and mitigating suspicious changes as follows.

* Attacker contributing to a well-trusted open-source project.
* The software vendor implanting a backdoor pretending it to be a mere functionality extension.
* Programmer mistakes that expose security hole.

### Project steps

1. Literature survey for Supply Chain Attacks
    * Choose your own update frameworks (Golang, NPM, PIP ...)
2. Implement your own example updates
    *  Choose a not-to-big, but interesting open source project.
    *  Build the source to produce a binary.
    *  Extract program representation against the binary.
3. Inject an attack vector (e.g., simple backdoor)
    *  Build the source to produce a binary. 
    *  Extract program representation against the binary.
4. Compare two representations to confirm your approach.
5. If it works, apply your approach to real softwares
    * You can test your approach with ....

### Reference paper

* [Towards Automatic Software Lineage Inference](https://users.ece.cmu.edu/~jiyongj/papers/usenixsec13.pdf): Usenix Security 2013

## Edge-ML device project

Google and Nvidia recently announced their new products to offload machine learning tasks to edge-based IoT computing devices. These devices are equipped with special computation units to accelerate machine learning workloads.
While this creates new usage cases,  edge-ML also bring new opportunities and threats at once. Edge-ML provides new ways of implementing security solutions or exposes new attack surface for the adversaries to take over.

* [Nvidia Jetson nano board](https://developer.nvidia.com/embedded/jetson-nano-developer-kit)
* [Google Edge TPU processing board](https://cloud.google.com/edge-tpu/)

<p><img alt="Edge TPU" src="https://augmentedstartups.com/wp-content/uploads/2019/06/AI_Board_Fig01_a0f5afa5c01d296dc09d895c8d933997_2000.png" width="75%"/></p>

 If you choose this project, you will provide you edge-ML devices. 

### Project direction 1: Build your own security application using Edge-ML device

With new device and its new capability, students can be wild and creative to propose a new security application. For instance, why don't write an security application that monitors your backyard?
Note that edge-ML devices are specialized for image and data processing tasks.

### Project direction 2: Protecting important information from Edge-ML device

With new computation model that edge-ML device introduces, important intellectual assets such as prediction model will be offloaded and transferred to each edge devices.
As it is to be deployed outside data center, edge-ML is exposed to the physical attack.

For the project, students can think of ways to prevent such assets from being taken over by the adversary. Students needs to consider both runtime and offline aspects. You may consider to utilize [Trustzone]() a security feature supported by ARM processor.

----

## Improvement for Automated Large-scale Malware Analysis Study

Recently, we observe millions of allegedly payloads are found and reported daily, and this phenomenon pushes the task of manual investigation and analysis nearly infeasible. Industry and academia together have proposed and worked on an automated framework to scale process and analyze malware payloads by implemented automated security sandbox for security and malware analysis. Such a proposal has improved the status, we as a community yet to see many pitfalls and limitation in replaying malware and capture the essence of malicious behavior. From this project, students will perform the following tasks..

### Project direction 1: Bridging Threat Intelligence

Leveraging Cuckoo environment, we run malware samples to check the consistency between its file, and network threat intelligence (IOCs).  How credibility/trust propagate across different domains? We can perform this task as an extension sandbox project.

### Project steps

* First implement one of the most well-known [open-source sandbox for malware analysis](https://www.cuckoo.org).
* Write behavioral signature by extending a Cuckoo community API to better judge whether a given payload is indeed malicious thus require further investigation.
* For a given malware payload, extend the sandbox framework by implementing functionalities to spot anti-debugging techniques and find a way to go around it.

### References

* [Cuckoo Sandbox](https://cuckoosandbox.org)
* [Cuckoo Community](https://github.com/cuckoosandbox/community)
* [Spotless Sandboxes: Evading Malware Analysis Systems using Wear-and-Tear Artifacts](https://securitee.org/files/wearntear-oakland2017.pdf)

## Implementation of Advanced Persistent Threat (APT) framework for Security Evaluation

More research and industry together focuses on Advanced Persistent Threat (APT) designed and launched by nation-level threat actors. Different approaches to monitor, analyze, and mitigate such attacks are proposed. However, research and industry together lacks in framework level support for testing and confirm their effectiveness in protecting valuable assets against such attempts. In this project, students will

* First, perform a literature research APT attacks.
* Build a mini-lab environment that would emulate a real-world enterprise environment.
* Implement and document a number of APT cases.

<p><img alt="" src="https://d1zq5d3dtjfcoj.cloudfront.net/base_network.png" width="80%"/></p>

### Resources

* APT Notes - Github project: [new repo](https://github.com/aptnotes/data), [old repo](https://github.com/kbandla/APTnotes)
* [APT3 scenario by MITRE](https://attackevals.mitre.org)

## Comparison of process-level instrumentation approaches virtualization

As our course proceeds, we will learn many different choices in instrumenting software program using different hypervisors to introspect process and system internals at runtime. One can leverage such frameworks to monitor, analyze, and mitigate process and system activities.

* Instrumentation frameworks
    * Binary re-writing: [DynInst](https://www.dyninst.org)
    * Process-level: [PIN](https://software.intel.com/en-us/articles/pin-a-dynamic-binary-instrumentation-tool), [Valgrind](http://www.valgrind.org), [DynamoRIO](https://www.dynamorio.org)
    * System-level: [QEmu](https://www.qemu.org)

While we have different options and frameworks in implementing such measures, design options and its trade-offs are not fully explored by the literatures.
For this project, students will

* First, study and understand different instrumentation frameworks
* Implement security/program analysis using the framework
    * E.g., Control Flow Graph generator
* Define a standard workload to run and measure overhead, and usability.

## Automated IOC processing to produce actionable security rules

*Indicator of Compromise (IOC)* refers to an artifact observed on a network or in an operating system that, with high confidence, indicates a computer intrusion. While IOC transforms the game security by cultivating the smooth exchange of security indicators. To further facilitates security information exchange by addressing the complexity and hectic nature of such security information that we have observed with the existing protocol,  a number of different standards are proposed and work on progress ([STIX]()). While these proposals attempt to address large portion of problem domain, still we have non-negligible rooms remain for improvements, for instance, many of important security IOCs are posted in a hard to parse not confirming to Internet standard. For instance, many security analysis are written in a plain English in a form of technical report, white-paper, or blog postings. 

### Goal and Problem Statement

* *Threat intelligence* is knowledge that allows you to prevent or mitigate cyber-attacks.
* In this project,
    1. We want to survey threat intelligence and verify its correctness and soundness.
    2. From valid threat intelligences, We want to find actionable threat intelligence.
    3. We want to build a platform or system that can automatically generates the behavioral rule for detection.
        * [Link for Actionable Threat Intelligence](https://www.tripwire.com/products/tripwire-enterprise/actionable-threat-intelligence-automated-ioc-matching-with-tripwire-register/)

* We have too much sources for threat intelligence whose validity and effectivenesses are not well verified.
* Some of threat intelligence are well-formed information circulated using community standard (STIX), while the others are just written in paragraphs of plain text, for instance, simple description of attack vectors, blog posts and so forth.
* IOC (Indicator of Compromise) is one form of threat intelligence, mostly referred as static indicators -- IP addresses, file hashes which are indicators easier for the attackers to forge and evade.
* we want to extract more dynamic robust indicators which can represent in a form of  behavioral action sequence  - e.g., process creation tree.
  * Present them using structured notations.
* can we automate the process?

From this project, student will attempts to parse malformed security indicators into STIX or TAXI compatible formation, so as it can be properly translated into standard IOC format and further circulated.  

### Resources

* [Introduction to STIX](https://oasis-open.github.io/cti-documentation/stix/intro)
* [OpenCTI](https://opencti-platform.github.io/docs/getting-started/introduction)

## Conntrack Visualizer

What is Conntrack?

<p><img alt="What is Conntrack?" src="https://pbs.twimg.com/media/DrK2undX0AAzH1S.jpg" width="85%"/></p> 

All of your connections are accessible from your kernel (even ones that you don't know of!). Can you make a service to visualize for all of Conntrack entries?

<p><img alt="Conntrack Visualization" src="https://i.imgur.com/RXhtJxq.png" width="85%"/></p> 

### Resources 

* [conntrack-tools](http://conntrack-tools.netfilter.org)


## Steganography or image forensics -- Analysis and defense for malicious payload embedded documentation

Steganography has been a useful technique for the hacker community in embedding different types of malicious payloads into a seemingly benign document to evade security detection measures. This provides attacker an easy way to propagate their malicious payloads yet remain undetected by any security measure. When you see any databases or public resources for malware collections, you realize malware-embedded documents now take the majority. 

* [Analyzing Malicious Documents Cheat Sheet](https://zeltser.com/analyzing-malicious-documents/)
* https://www.youtube.com/watch?v=np0mPy-EHII
* [Steganography: A Safe Haven for Malware](https://securityintelligence.com/steganography-a-safe-haven-for-malware/)
* https://books.google.com/books?hl=en&lr=&id=qMB9AiFUWF0C&oi=fnd&pg=PP1&ots=glBaUv19cd&sig=VrUI34kRvs67Lf7r7EMHNRbBtz0
* ['Dresden Image Database' for benchmarking digital image forensics](https://dl.acm.org/citation.cfm?id=1774427)

----

Page last revised on: {{ git_revision_date }}