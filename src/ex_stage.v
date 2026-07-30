module ex_stage(
    input clk,
    input reset,

    input [31:0] rs1_data,
    input [31:0] rs2_data,
    input [31:0] imm,
    input [31:0] pc4,

    input [4:0] rd,
    input [2:0] funct3,
    input [6:0] funct7,

    input alusrc,
    input branch,
    input memread,
    input memwrite,
    input regwrite,
    input memtoreg,

    input [1:0] forwardA,
    input [1:0] forwardB,

    input [31:0] ex_mem_alu_fwd,
    input [31:0] wb_data,

    output reg [31:0] alu_out,
    output reg [31:0] rs2_out,
    output reg [31:0] branch_target,

    output reg branch_taken,
    output reg [4:0] rd_out,

    output reg memread_out,
    output reg memwrite_out,
    output reg regwrite_out,
    output reg memtoreg_out
);

    // Forwarding MUX A
    wire [31:0] A =
        (forwardA == 2'b10) ? ex_mem_alu_fwd :
        (forwardA == 2'b01) ? wb_data :
                              rs1_data;

    // Forwarding MUX B
    wire [31:0] Bsrc =
        (forwardB == 2'b10) ? ex_mem_alu_fwd :
        (forwardB == 2'b01) ? wb_data :
                              rs2_data;

    // ALU operand selection
    wire [31:0] B = (alusrc) ? imm : Bsrc;

    reg [31:0] alu_res;

    // ALU
    always @(*) begin
        case (funct3)

            // ADD / SUB
            3'b000: begin
                if (funct7 == 7'b0100000)
                    alu_res = A - B;
                else
                    alu_res = A + B;
            end

            // AND
            3'b111:
                alu_res = A & B;

            // OR
            3'b110:
                alu_res = A | B;

            default:
                alu_res = 32'd0;

        endcase
    end

    wire zero = (alu_res == 32'd0);

    // EX/MEM Pipeline Register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            alu_out       <= 0;
            rs2_out       <= 0;
            branch_target <= 0;
            branch_taken  <= 0;
            rd_out        <= 0;

            memread_out   <= 0;
            memwrite_out  <= 0;
            regwrite_out  <= 0;
            memtoreg_out  <= 0;
        end
        else begin
            alu_out       <= alu_res;
            rs2_out       <= Bsrc;
            branch_target <= pc4 + imm;
            branch_taken  <= branch & zero;
            rd_out        <= rd;

            memread_out   <= memread;
            memwrite_out  <= memwrite;
            regwrite_out  <= regwrite;
            memtoreg_out  <= memtoreg;
        end
    end

endmodule