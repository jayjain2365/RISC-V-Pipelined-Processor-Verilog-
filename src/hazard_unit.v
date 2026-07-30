module hazard_unit(
    input wire        id_ex_memread,   // from EX stage
    input wire [4:0]  id_ex_rd,        // destination reg in EX
    input wire [4:0]  if_id_rs1,       // source reg in ID
    input wire [4:0]  if_id_rs2,

    output reg        pc_write,
    output reg        if_id_write,
    output reg        id_ex_flush
);

    always @(*) begin
      if (id_ex_memread &&
    (id_ex_rd != 5'd0) &&
   ((id_ex_rd == if_id_rs1) ||
    (id_ex_rd == if_id_rs2))) begin

            // Stall pipeline
            pc_write   = 0;
            if_id_write= 0;
            id_ex_flush= 1;

        end else begin
            // Normal operation
            pc_write   = 1;
            if_id_write= 1;
            id_ex_flush= 0;
        end
    end

endmodule