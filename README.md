# HeyTeddy: Conversational Test-Driven Development for Physical Computing

Physical computing is a complex activity that consists of different but tightly coupled tasks: programming and assembling hardware for circuits. Prior work clearly shows that this coupling is the main source of mistakes that unfruitfully take a large portion of novices' debugging time. While past work presented systems that simplify prototyping or introduce novel debugging functionalities, these tools either limit what users can accomplish or are too complex for beginners. In this paper, we propose a general-purpose prototyping tool based on conversation. HeyTeddy guides users during hardware assembly by providing additional information on requests or by interactively presenting the assembly steps to build a circuit. Furthermore, the user can program and execute code in real-time on their Arduino platform without having to write any code, but instead by using commands triggered by voice or text via chat. Finally, the system also presents a set of test capabilities for enhancing debugging with custom and proactive unit tests. We codesigned the system with 10 users over 6 months and tested it with realistic physical computing tasks. With the result of two user studies, we show that conversational programming is feasible and that voice is a suitable alternative for programming simple logic and encouraging exploration. We also demonstrate that conversational programming with unit tests is effective in reducing development time and overall debugging problems while increasing users' confidence. Finally, we highlight limitations and future avenues of research.

For more information check the IMWUT Dec. 2019 paper: "HeyTeddy: Conversational Test-Driven Development for Physical Computing".

![Overview](https://drive.google.com/uc?export=view&id=1LLMAeqPSI_qU-twRaWR3pzYkHlS5-Ut8)

## Video
[![Watch the video](https://drive.google.com/uc?export=view&id=1dG4YO4WY-fyy0QPmaBvcFpsEw-7sLqrs)](https://youtu.be/ajI_WC4VRFo)

## License
MIT License

## Citing
```
@article{10.1145/3369838,
 author = {Kim, Yoonji and Choi, Youngkyung and Kang, Daye and Lee, Minkyeong and Nam, Tek-Jin and Bianchi, Andrea},
 title = {HeyTeddy: Conversational Test-Driven Development for Physical Computing},
 year = {2019},
 issue_date = {December 2019},
 publisher = {Association for Computing Machinery},
 address = {New York, NY, USA},
 volume = {3},
 number = {4},
 url = {https://doi.org/10.1145/3369838},
 doi = {10.1145/3369838},
 journal = {Proc. ACM Interact. Mob. Wearable Ubiquitous Technol.},
 month = dec,
 articleno = {Article 139},
 numpages = {21},
 keywords = {End-user development, Conversational agent, Test-driven development, Physical computing}
}
```
