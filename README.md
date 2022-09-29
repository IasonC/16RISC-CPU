# 16-bit RISC CPU

This project is a 16-bit RISC Harvard-architecture CPU coded fully in SystemVerilog (SV). This CPU's instruction set is comprised of numeric, bitwise, branching and jump commands. Furthermore, it follows the Harvard architecture (more complex than Von Neumann architecture) as it contains separate ROM (stores program instructions) and RAM (stores execution data) memory elements which can communicate with the Register File (GPRs) through the same databus. The choice of Harvard architecture increases complexity and decreases CPU runtime. SV is a Hardware Description Language (HDL) used to simulate digital circuits and also synthesise them onto a physical netlist of logic gates. The netlist can be realised in an FPGA, ASIC etc. Therefore, this project's future aim is to deploy this SV CPU onto an FPGA to observe its operation in real time.

## CPU Diagram

## Instruction Set

## Unit and Integration Testing


## Future Work

The future aim of this project is to verify correct CPU operation with a simulation tool like Xilinx ISim and to then deploy the CPU to a real FPGA (Terasic Cyclone IV) with pin binding to display CPU outputs visually - perhaps to an LCD display.

## References
1. C. Venkatesan, M. T. Sulthana, M. G. Sumithra and M. Suriya, "Design of a 16-Bit Harvard Structure RISC Processor in Cadence 45nm Technology," 2019 5th International Conference on Advanced Computing & Communication Systems (ICACCS), 2019, pp. 173-178, doi: 10.1109/ICACCS.2019.8728479.
2. A. Morlan, "Building an 8-bit CPU on an FPGA", 2021. https://austinmorlan.com/posts/8bit_breadboard_fpga/
3. FPGA4Student, "Verilog Code for 16-bit RISC Processor", n.d. https://www.fpga4student.com/2017/04/verilog-code-for-16-bit-risc-processor.html
