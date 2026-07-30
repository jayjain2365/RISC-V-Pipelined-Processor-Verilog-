# 32-bit 5-Stage Pipelined RISC-V Processor in Verilog HDL

## Overview

This project implements a **32-bit 5-stage pipelined RISC-V processor** supporting a **subset of the RV32I instruction set** using **Verilog HDL**. The processor follows the classic RISC pipeline architecture consisting of Instruction Fetch (IF), Instruction Decode (ID), Execute (EX), Memory Access (MEM), and Write Back (WB) stages.

The design demonstrates fundamental concepts of **Computer Architecture, RTL Design, Digital Logic, and Processor Design**. It also incorporates **Hazard Detection** and **Data Forwarding** units to improve pipeline efficiency by handling data hazards during instruction execution.

> **Note:** This is an educational implementation intended to demonstrate pipelined processor design, hazard detection, forwarding mechanisms, and RTL development using a subset of the RV32I instruction set.

---

# Project Specifications

| Specification | Details |
|--------------|---------|
| Processor | 32-bit RISC-V |
| ISA | RV32I (Subset) |
| Pipeline | 5-Stage |
| HDL | Verilog HDL |
| Hazard Detection | Yes |
| Data Forwarding | Yes |
| Simulation Tool | Xilinx Vivado |

---

# Features

- 32-bit 5-Stage Pipelined Processor
- RV32I Subset Implementation
- Modular Verilog RTL Design
- Instruction Fetch (IF)
- Instruction Decode (ID)
- Execute (EX)
- Memory Access (MEM)
- Write Back (WB)
- Hazard Detection Unit
- Data Forwarding Unit
- RTL Simulation and Verification

---

# Supported Instructions

The current implementation supports a subset of the RV32I instruction set, including:

- ADD
- SUB
- ADDI
- AND
- OR
- LW
- SW
- BEQ
- NOP

---

# Processor Architecture

The processor is organized into five pipeline stages.

## 1. Instruction Fetch (IF)

Responsibilities:

- Program Counter (PC) Management
- Instruction Fetch from Instruction Memory
- PC Increment Logic

## 2. Instruction Decode (ID)

Responsibilities:

- Instruction Decoding
- Register Operand Extraction
- Control Signal Generation

## 3. Execute (EX)

Responsibilities:

- ALU Arithmetic Operations
- Logical Operations
- Branch Address Computation
- Operand Selection

## 4. Memory Access (MEM)

Responsibilities:

- Data Memory Read
- Data Memory Write
- Memory Interface Operations

## 5. Write Back (WB)

Responsibilities:

- Write Computed Results Back to Register File

---

# Pipeline Hazard Management

## Hazard Detection Unit

The Hazard Detection Unit detects data dependencies that could lead to incorrect execution.

Functions:

- Detects load-use hazards
- Generates pipeline stall signals
- Maintains correct instruction execution

## Forwarding Unit

The Forwarding Unit minimizes stalls by forwarding data from later pipeline stages to earlier stages.

Functions:

- Resolves Read-After-Write (RAW) hazards
- Reduces unnecessary pipeline stalls
- Improves overall pipeline performance

---

# Project Structure

```text
RISC-V-Pipelined-Processor
│
├── src
│   ├── if_stage.v
│   ├── id_stage.v
│   ├── ex_stage.v
│   ├── mem_stage.v
│   ├── wb_stage.v
│   ├── forwarding_unit.v
│   ├── hazard_unit.v
│   └── top_riscv.v
│
├── tb
│   └── tb_top_riscv.v
│
├── schematics and waveforms
│   ├── overview.png
│   ├── fetchstage.png
│   ├── decodestage.png
│   ├── executestage.png
│   ├── memstage.png
│   ├── writebackstage.png
│   ├── forwardingunit.png
│   ├── hazardunit.png
│   ├── waveform1.png
│   └── waveform2.png
│
└── README.md
```

---

# Source Modules

| Module | Description |
|---------|-------------|
| if_stage.v | Instruction Fetch Stage |
| id_stage.v | Instruction Decode Stage |
| ex_stage.v | Execute Stage |
| mem_stage.v | Memory Access Stage |
| wb_stage.v | Write Back Stage |
| forwarding_unit.v | Data Forwarding Logic |
| hazard_unit.v | Hazard Detection Logic |
| top_riscv.v | Top-Level Processor Integration |

---

# Simulation

The processor was functionally verified using a dedicated Verilog testbench:

```text
tb_top_riscv.v
```

The simulation validates:

- Instruction execution
- Pipeline operation
- Register write-back
- Data forwarding
- Hazard detection
- Correct data propagation through all pipeline stages

Simulation waveforms are included in the repository.

---

# Tools Used

- Verilog HDL
- Xilinx Vivado
- RTL Simulation
- Waveform Analysis

---

# Learning Outcomes

This project provided practical experience in:

- RTL Design Methodology
- Computer Architecture
- Pipeline Processor Design
- Hazard Detection Techniques
- Data Forwarding Mechanisms
- Hardware Verification
- FPGA Design Flow
- Git Version Control

---

# Future Improvements

Potential future enhancements include:

- Complete RV32I Instruction Set Support
- Branch Prediction Unit
- Cache Memory Integration
- Performance Analysis
- FPGA Implementation
- Advanced Hazard Resolution Techniques

---

# Author

**Jay Jain**

Electronics and Communication Engineering

### Areas of Interest

- VLSI Design
- RTL Design
- Digital Design
- FPGA Development
- Computer Architecture
- Processor Design
