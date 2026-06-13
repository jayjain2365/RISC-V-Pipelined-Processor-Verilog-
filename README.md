# RISC-V Pipelined Processor in Verilog HDL

## Overview

This project implements a 5-Stage RISC-V Pipelined Processor using Verilog HDL. The processor follows the classic RISC pipeline architecture consisting of Instruction Fetch (IF), Instruction Decode (ID), Execute (EX), Memory Access (MEM), and Write Back (WB) stages.

The design demonstrates fundamental concepts of Computer Architecture, Digital Design, RTL Design, and Processor Implementation. Additional modules such as Hazard Detection and Forwarding Units are incorporated to improve pipeline efficiency and resolve data hazards.

---

## Features

* 5-Stage RISC-V Pipeline Architecture
* Modular Verilog HDL Design
* Instruction Fetch (IF) Stage
* Instruction Decode (ID) Stage
* Execute (EX) Stage
* Memory Access (MEM) Stage
* Write Back (WB) Stage
* Hazard Detection Unit
* Forwarding Unit
* RTL Simulation and Verification
* Waveform Analysis
* Architectural Block Diagrams

---

## Processor Architecture

The processor is organized into five pipeline stages:

### 1. Instruction Fetch (IF)

Responsibilities:

* Program Counter (PC) Management
* Instruction Fetch from Instruction Memory
* PC Increment Logic

### 2. Instruction Decode (ID)

Responsibilities:

* Instruction Decoding
* Register Operand Extraction
* Control Signal Generation

### 3. Execute (EX)

Responsibilities:

* Arithmetic Operations
* Logical Operations
* ALU Processing
* Branch Computation

### 4. Memory Access (MEM)

Responsibilities:

* Data Memory Read
* Data Memory Write
* Memory Interface Operations

### 5. Write Back (WB)

Responsibilities:

* Writing Computed Results Back to Register File

---

## Pipeline Hazard Management

### Hazard Detection Unit

The Hazard Detection Unit identifies situations where instruction execution may produce incorrect results due to data dependencies.

Functions:

* Detects data hazards
* Generates stall conditions
* Maintains pipeline correctness

### Forwarding Unit

The Forwarding Unit reduces pipeline stalls by forwarding results from later pipeline stages to earlier stages.

Functions:

* Resolves Read-After-Write (RAW) hazards
* Improves pipeline performance
* Minimizes unnecessary stalls

---

## Project Structure

```text
RISC-V-Pipelined-Processor
│
├── src
│   ├── if_stage.v
│   ├── id_stage.v
│   ├── ex_stage.v
│   ├── mem_stage.v
│   ├── wb_stage.v
│   ├── hazard_unit.v
│   ├── forwarding_unit.v
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
└── RISC.docx
```

---

## Source Modules

| Module            | Description                     |
| ----------------- | ------------------------------- |
| if_stage.v        | Instruction Fetch Stage         |
| id_stage.v        | Instruction Decode Stage        |
| ex_stage.v        | Execute Stage                   |
| mem_stage.v       | Memory Access Stage             |
| wb_stage.v        | Write Back Stage                |
| forwarding_unit.v | Data Forwarding Logic           |
| hazard_unit.v     | Hazard Detection Logic          |
| top_riscv.v       | Top-Level Processor Integration |

---

## Simulation

The processor was verified using a dedicated testbench:

```text
tb_top_riscv.v
```

Simulation verifies:

* Instruction Flow
* Pipeline Operation
* Hazard Handling
* Forwarding Logic
* Correct Data Propagation

Waveform screenshots are provided in the repository.

---

## Tools Used

* Verilog HDL
* Xilinx Vivado
* RTL Simulation
* Waveform Analysis
* Git & GitHub

---

## Learning Outcomes

This project provided practical experience in:

* RTL Design Methodology
* Computer Architecture
* Pipeline Processor Design
* Hazard Detection Techniques
* Forwarding Mechanisms
* Hardware Verification
* FPGA Design Flow
* GitHub Project Management

---

## Future Improvements

Potential future enhancements include:

* Full RV32I Instruction Set Support
* Branch Prediction Unit
* Cache Memory Integration
* Pipeline Performance Analysis
* FPGA Deployment
* Advanced Hazard Resolution Techniques

---

## Author

Jay Jain

Electronics and Communication Engineering

Focus Areas:

* VLSI Design
* Digital Design
* RTL Design
* FPGA Development
* Computer Architecture
* Processor Design
