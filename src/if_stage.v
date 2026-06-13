module if_stage(
    input clk, reset, pc_write,
    input branch_taken,
    input [31:0] branch_target,
    input if_id_write,
    output reg [31:0] instr_out,
    output reg [31:0] pc4_out
);

    reg [31:0] PC;
    reg [31:0] imem [0:255];

    wire [31:0] next_pc = branch_taken ? branch_target : PC + 4;
    initial begin
    imem[0] = 32'h00500093;
    imem[1] = 32'h00A00113;
    imem[2] = 32'h002081B3;
    imem[3] = 32'h40110233;
    imem[4] = 32'h0020F2B3;
    imem[5] = 32'h0020E333;
    imem[6] = 32'h00000013;
end
    always @(posedge clk or posedge reset) begin
        if (reset) PC <= 0;
        else if (pc_write) PC <= next_pc;
    end

    always @(posedge clk) begin
        if (if_id_write) begin
            instr_out <= imem[PC[31:2]];
            pc4_out <= PC + 4;
        end
    end
endmodule