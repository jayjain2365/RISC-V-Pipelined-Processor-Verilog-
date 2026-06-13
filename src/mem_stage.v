module mem_stage(
    input clk,
    input [31:0] alu, rs2,
    input [4:0] rd,
    input memread, memwrite, regwrite, memtoreg,

    output reg [31:0] mem_data, alu_out,
    output reg [4:0] rd_out,
    output reg regwrite_out, memtoreg_out
);

    reg [31:0] dmem [0:255];

    always @(posedge clk) begin
        if (memwrite)
            dmem[alu[31:2]] <= rs2;

        if (memread)
            mem_data <= dmem[alu[31:2]];
        else
            mem_data <= 0;

        alu_out <= alu;
        rd_out <= rd;
        regwrite_out <= regwrite;
        memtoreg_out <= memtoreg;
    end
endmodule