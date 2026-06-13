module wb_stage(input [31:0] alu, mem, input sel, output [31:0] out);
    assign out = sel ? mem : alu;
endmodule