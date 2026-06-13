module id_stage(
    input clk, reset,
    input [31:0] if_id_instr, if_id_pc4,

    input wb_regwrite,
    input [4:0] wb_rd,
    input [31:0] wb_writedata,

    input id_ex_flush,

    output reg [31:0] rs1_data, rs2_data, imm, pc4,
    output reg [4:0] rs1, rs2, rd,
    output reg [2:0] funct3,
    output reg [6:0] funct7,

    output reg alusrc,
    output reg [1:0] aluop,
    output reg branch,
    output reg memread, memwrite,
    output reg regwrite, memtoreg
);
reg [31:0] regfile [0:31];
integer i;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        for(i=0; i<32; i=i+1)
            regfile[i] <= 0;
    end
    else if (wb_regwrite && wb_rd != 0)
        regfile[wb_rd] <= wb_writedata;
end
    wire [6:0] opcode = if_id_instr[6:0];

    always @(posedge clk)
        if (wb_regwrite && wb_rd != 0)
            regfile[wb_rd] <= wb_writedata;

    always @(*) begin
        rs1 = if_id_instr[19:15];
        rs2 = if_id_instr[24:20];
        rd  = if_id_instr[11:7];
        funct3 = if_id_instr[14:12];
        funct7 = if_id_instr[31:25];

        rs1_data = regfile[rs1];
        rs2_data = regfile[rs2];

        imm = {{20{if_id_instr[31]}}, if_id_instr[31:20]};
        pc4 = if_id_pc4;

        alusrc=0; aluop=0; branch=0;
        memread=0; memwrite=0; regwrite=0; memtoreg=0;

        case (opcode)
            7'b0110011: begin aluop=2'b10; regwrite=1; end
            7'b0000011: begin alusrc=1; memread=1; regwrite=1; memtoreg=1; end
            7'b0100011: begin alusrc=1; memwrite=1; end
            7'b1100011: begin branch=1; aluop=2'b01; end
        endcase

        if (id_ex_flush) begin
            alusrc=0; aluop=0; branch=0;
            memread=0; memwrite=0; regwrite=0; memtoreg=0;
        end
    end
endmodule