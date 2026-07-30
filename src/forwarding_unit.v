module forwarding_unit(
    input ex_mem_regwrite, mem_wb_regwrite,
    input [4:0] ex_mem_rd, mem_wb_rd, id_ex_rs1, id_ex_rs2,
    output reg [1:0] forwardA, forwardB);

    always @(*) begin
        forwardA=0; forwardB=0;

        if(ex_mem_regwrite && ex_mem_rd!=0 && ex_mem_rd==id_ex_rs1)
            forwardA=2'b10;
        else if(mem_wb_regwrite && mem_wb_rd!=0 && mem_wb_rd==id_ex_rs1)
            forwardA=2'b01;

        if(ex_mem_regwrite && ex_mem_rd!=0 && ex_mem_rd==id_ex_rs2)
            forwardB=2'b10;
        else if(mem_wb_regwrite && mem_wb_rd!=0 && mem_wb_rd==id_ex_rs2)
            forwardB=2'b01;
    end
endmodule