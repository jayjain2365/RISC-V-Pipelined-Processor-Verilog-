module ex_stage(
    input clk, reset,

    input [31:0] rs1_data, rs2_data, imm, pc4,
    input [4:0] rd,
    input [2:0] funct3,
    input [6:0] funct7,

    input alusrc, branch, memread, memwrite, regwrite, memtoreg,
    input [1:0] forwardA, forwardB,
    input [31:0] ex_mem_alu_fwd, wb_data,

    output reg [31:0] alu_out, rs2_out, branch_target,
    output reg branch_taken,
    output reg [4:0] rd_out,

    output reg memread_out, memwrite_out,
    output reg regwrite_out, memtoreg_out
);

    wire [31:0] A =
        (forwardA==2'b10)? ex_mem_alu_fwd :
        (forwardA==2'b01)? wb_data : rs1_data;

    wire [31:0] Bsrc =
        (forwardB==2'b10)? ex_mem_alu_fwd :
        (forwardB==2'b01)? wb_data : rs2_data;

    wire [31:0] B = alusrc ? imm : Bsrc;

    reg [31:0] alu_res;

    always @(*) begin
        case(funct3)
            3'b000: alu_res = (funct7==7'b0100000)? A-B : A+B;
            3'b111: alu_res = A & B;
            3'b110: alu_res = A | B;
            default: alu_res = 0;
        endcase
    end

    wire zero = (alu_res == 0);

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            alu_out <= 0;
            branch_taken <= 0;
        end else begin
            alu_out <= alu_res;
            rs2_out <= Bsrc;
            branch_target <= pc4 + imm;
            branch_taken <= branch & zero;
            rd_out <= rd;

            memread_out <= memread;
            memwrite_out <= memwrite;
            regwrite_out <= regwrite;
            memtoreg_out <= memtoreg;
        end
    end
endmodule