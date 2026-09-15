# 8-bit ALU Design using SystemVerilog

An 8-bit Arithmetic Logic Unit (ALU) designed using SystemVerilog and verified through simulation and waveform analysis. The RTL design was synthesized using Yosys to generate a gate-level netlist.

## Features

The ALU accepts two 8-bit inputs and a 3-bit operation code.

### Supported Operations

| OP | Operation | Description |
|----|-----------|-------------|
| 000 | ADD | A + B |
| 001 | SUB | A - B |
| 010 | AND | Bitwise AND |
| 011 | OR | Bitwise OR |
| 100 | XOR | Bitwise XOR |
| 101 | NOT | Bitwise NOT of A |
| 110 | SHIFT LEFT | A << 1 |
| 111 | SHIFT RIGHT | A >> 1 |

## Outputs

- `RESULT[7:0]` - 8-bit operation result
- `CARRY` - Carry/no-borrow or shift carry flag
- `ZERO` - Indicates whether the result is zero
- `OVERFLOW` - Signed arithmetic overflow flag

## Design Flow

```text
SystemVerilog RTL
       |
       v
Icarus Verilog Simulation
       |
       v
Self-Checking Testbench
       |
       v
GTKWave Waveform Verification
       |
       v
Yosys RTL Synthesis
       |
       v
Gate-Level Netlist
Verification

The ALU was verified using a SystemVerilog testbench covering:

Addition
Addition with carry
Subtraction
Subtraction with borrow
AND
OR
XOR
NOT
Left shift
Right shift
Signed addition overflow
Signed subtraction overflow
Zero flag
Carry flag

Simulation result:  ALL TESTS PASSED

Synthesis

Synthesis was performed using Yosys.

Generic synthesis statistics
Wires: 260
Wire bits: 283
Ports: 7
Port bits: 30
Cells: 264

Synthesized Logic

| Cell Type | Count |
| --------- | ----: |
| ANDNOT    |    93 |
| AND       |     9 |
| MUX       |    10 |
| NAND      |     5 |
| NOR       |    28 |
| NOT       |     6 |
| ORNOT     |     8 |
| OR        |    81 |
| XNOR      |    11 |
| XOR       |    13 |


These are generic Yosys logic cells and are not technology-specific standard cells.

Tools Used -

SystemVerilog
Icarus Verilog
GTKWave
Yosys
Linux
Project Structure

8-bit-ALU/
├── rtl/
│   └── alu_8bit.sv
├── tb/
│   └── alu_8bit_tb.sv
├── sim/
│   └── alu.vcd
├── synth/
│   └── alu_8bit_netlist.v
├── docs/
├── .gitignore
└── README.md

Future Work:

a.Technology-mapped synthesis
b.Gate-level simulation
c.Static timing analysis
d.Area estimation
e.FPGA implementation
f.Formal verification
g.Pipelined ALU design
h.Integration into a simple CPU/RISC-V datapath

Author
Abhik Bhunia

Electronics and Communication Engineering
