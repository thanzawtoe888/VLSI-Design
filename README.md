# VLSI-Design

A comprehensive resource for VLSI Design(LTspice, Quartus, GTKwave, Note++), featuring RTL coding, synthesis, simulation, and verification. This repository includes project files, scripts, and methodologies for designing and implementing digital systems using Verilog/VHDL, SPICE, and other VLSI tools.

For Human detection device
This project is to design a Human Tracking Device using Verilog. This device counts the number of people entering a room, displays the total on a 7-segment display, and triggers an alarm when the count exceeds 80. The design was compiled using Quartus II 13.1 Web Edition and simulated using Iverilog and GTKWave. Here’s the simulation process; 
1.Compiled the Verilog files using the following command.
 iverilog -o my_htd htd_tb.v htd.v 
2. After compilation, run the simulation with the command.
 	vvp my_htd 
3.The simulation generated a .vcd file (human_detection.vcd), which can open with GTKWave. 
  gtkwave human_detection.vcd  

On FPGA Design and Compilation with Quartus II 13.1. First, open Quartus II 13.1 Web Edition and create a new project for the (human_counter). Then, add the RTL code (htd.v) to the project. The design was compiled using Quartus II.(###Check the module name before creating the QuartusII)


