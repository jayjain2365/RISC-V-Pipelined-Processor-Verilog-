`timescale 1ns / 1ps

module tb_top_riscv;

    reg clk;
    reg reset;

    // ✅ Correct named instantiation
    top_riscv DUT (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        // ---------------------------------------
        // Wait before loading memory (important)
        // ---------------------------------------
        #1;

        // ---------------------------------------
        // Load instructions into instruction memory
        // ---------------------------------------
        DUT.IF.imem[0] = 32'h00500093; // ADDI x1, x0, 5
        DUT.IF.imem[1] = 32'h00A00113; // ADDI x2, x0, 10
        DUT.IF.imem[2] = 32'h002081B3; // ADD x3, x1, x2
        DUT.IF.imem[3] = 32'h40110233; // SUB x4, x2, x1
        DUT.IF.imem[4] = 32'h0020F2B3; // AND x5, x1, x2
        DUT.IF.imem[5] = 32'h0020E333; // OR  x6, x1, x2
        DUT.IF.imem[6] = 32'h002183B3; // ADD x7, x3, x2 (forwarding)
        DUT.IF.imem[7] = 32'h00000013; // NOP
        DUT.IF.imem[8] = 32'h00000013; // NOP

        // ---------------------------------------
        // Hold reset for few cycles
        // ---------------------------------------
        #20;
        reset = 0;

        // ---------------------------------------
        // Run simulation
        // ---------------------------------------
        #300;

        // ---------------------------------------
        // Display results
        // ---------------------------------------
        $display("===== FINAL REGISTER VALUES =====");
        $display("x1 = %0d", DUT.ID.regfile[1]);
        $display("x2 = %0d", DUT.ID.regfile[2]);
        $display("x3 = %0d", DUT.ID.regfile[3]);
        $display("x4 = %0d", DUT.ID.regfile[4]);
        $display("x5 = %0d", DUT.ID.regfile[5]);
        $display("x6 = %0d", DUT.ID.regfile[6]);
        $display("x7 = %0d", DUT.ID.regfile[7]);
        $display("x1 = %d", DUT.ID.regfile[1]);
        $stop;
    end

endmodule