module top_riscv(input clk, input reset,
 output [31:0] debug_x1,
    output [31:0] debug_x2,
    output [31:0] debug_x3,
    output [31:0] debug_wb);

    wire [31:0] if_id_instr, if_id_pc4;

    wire [31:0] rs1_data, rs2_data, imm, pc4;
    wire [4:0] rs1, rs2, rd;
    wire [2:0] funct3;
    wire [6:0] funct7;

    wire alusrc, branch, memread, memwrite, regwrite, memtoreg;
    wire [1:0] aluop;

    wire [31:0] ex_alu, ex_rs2, ex_bt;
    wire ex_btaken;
    wire [4:0] ex_rd;
    wire ex_memread, ex_memwrite, ex_regwrite, ex_memtoreg;

    wire [31:0] mem_data, mem_alu;
    wire [4:0] mem_rd;
    wire mem_regwrite, mem_memtoreg;

    wire [31:0] wb_data;

    wire pc_write, if_id_write, id_ex_flush;
    wire [1:0] fwdA, fwdB;
//==================================================
// Hazard Detection Unit
//==================================================
hazard_unit HZ (
    .id_ex_memread(ex_memread),
    .id_ex_rd(ex_rd),

    .if_id_rs1(if_id_instr[19:15]),
    .if_id_rs2(if_id_instr[24:20]),

    .pc_write(pc_write),
    .if_id_write(if_id_write),
    .id_ex_flush(id_ex_flush)
);

    // IF
    if_stage IF(clk, reset, pc_write, ex_btaken, ex_bt, if_id_write, if_id_instr, if_id_pc4);

    // ID
    id_stage ID(
        .clk(clk), .reset(reset),
        .if_id_instr(if_id_instr), .if_id_pc4(if_id_pc4),
        .wb_regwrite(mem_regwrite), .wb_rd(mem_rd), .wb_writedata(wb_data),
        .id_ex_flush(id_ex_flush),

        .rs1_data(rs1_data), .rs2_data(rs2_data),
        .imm(imm), .pc4(pc4),
        .rs1(rs1), .rs2(rs2), .rd(rd),

        .funct3(funct3), .funct7(funct7),

        .alusrc(alusrc), .aluop(aluop), .branch(branch),
        .memread(memread), .memwrite(memwrite),
        .regwrite(regwrite), .memtoreg(memtoreg)
    );

    // EX
    ex_stage EX(
        clk, reset,
        rs1_data, rs2_data, imm, pc4, rd,
        funct3, funct7,
        alusrc, branch, memread, memwrite, regwrite, memtoreg,
        fwdA, fwdB, ex_alu, wb_data,

        ex_alu, ex_rs2, ex_bt, ex_btaken, ex_rd,
        ex_memread, ex_memwrite, ex_regwrite, ex_memtoreg
    );

    // MEM
    mem_stage MEM(
        clk, ex_alu, ex_rs2, ex_rd,
        ex_memread, ex_memwrite, ex_regwrite, ex_memtoreg,
        mem_data, mem_alu, mem_rd, mem_regwrite, mem_memtoreg
    );

    // WB
    wb_stage WB(mem_alu, mem_data, mem_memtoreg, wb_data);

    // Forwarding
    forwarding_unit FW(
        ex_regwrite, mem_regwrite, ex_rd, mem_rd,
        rs1, rs2, fwdA, fwdB
    );
// Debug outputs to prevent optimization

assign debug_x1 = ID.regfile[1];
assign debug_x2 = ID.regfile[2];
assign debug_x3 = ID.regfile[3];

assign debug_wb = wb_data;
endmodule