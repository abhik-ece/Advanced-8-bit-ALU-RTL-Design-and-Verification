module alu_8bit_tb;

    logic [7:0] A;
    logic [7:0] B;
    logic [2:0] OP;

    logic [7:0] RESULT;
    logic       CARRY;
    logic       ZERO;
    logic       OVERFLOW;

    integer errors;

    alu_8bit DUT (
        .A(A),
        .B(B),
        .OP(OP),
        .RESULT(RESULT),
        .CARRY(CARRY),
        .ZERO(ZERO),
        .OVERFLOW(OVERFLOW)
    );

    task automatic check_result(
        input [7:0] expected_result,
        input       expected_carry,
        input       expected_overflow
    );

        begin

            #1;

            if (RESULT !== expected_result) begin
                $display(
                    "ERROR: OP=%b A=%d B=%d RESULT=%d EXPECTED=%d",
                    OP, A, B, RESULT, expected_result
                );
                errors = errors + 1;
            end

            if (CARRY !== expected_carry) begin
                $display(
                    "ERROR: OP=%b A=%d B=%d CARRY=%b EXPECTED=%b",
                    OP, A, B, CARRY, expected_carry
                );
                errors = errors + 1;
            end

            if (ZERO !== (expected_result == 8'b0)) begin
                $display("ERROR: ZERO flag incorrect");
                errors = errors + 1;
            end

            if (OVERFLOW !== expected_overflow) begin
                $display("ERROR: OVERFLOW flag incorrect");
                errors = errors + 1;
            end

        end

    endtask

    initial begin

        errors = 0;

        $dumpfile("sim/alu.vcd");
        $dumpvars(0, alu_8bit_tb);

        $display("--------------------------------");
        $display("       8-BIT ALU TEST");
        $display("--------------------------------");

        // ADD
        OP = 3'b000;
        A = 8'd5;
        B = 8'd3;
        check_result(8'd8, 1'b0, 1'b0);

        A = 8'd255;
        B = 8'd1;
        check_result(8'd0, 1'b1, 1'b0);

        // SUB
        OP = 3'b001;
        A = 8'd10;
        B = 8'd3;
        check_result(8'd7, 1'b1, 1'b0);

        A = 8'd3;
        B = 8'd10;
        check_result(8'd249, 1'b0, 1'b0);

        // AND
        OP = 3'b010;
        A = 8'b10101010;
        B = 8'b11001100;
        check_result(8'b10001000, 1'b0, 1'b0);

        // OR
        OP = 3'b011;
        A = 8'b10101010;
        B = 8'b11001100;
        check_result(8'b11101110, 1'b0, 1'b0);

        // XOR
        OP = 3'b100;
        A = 8'b10101010;
        B = 8'b11001100;
        check_result(8'b01100110, 1'b0, 1'b0);

        // NOT
        OP = 3'b101;
        A = 8'b10101010;
        B = 8'b00000000;
        check_result(8'b01010101, 1'b0, 1'b0);

        // SHIFT LEFT
        OP = 3'b110;
        A = 8'b10000001;
        B = 8'b00000000;
        check_result(8'b00000010, 1'b1, 1'b0);

        // SHIFT RIGHT
        OP = 3'b111;
        A = 8'b10000001;
        B = 8'b00000000;
        check_result(8'b01000000, 1'b1, 1'b0);

        // SIGNED OVERFLOW: 127 + 1
        OP = 3'b000;
        A = 8'd127;
        B = 8'd1;
        check_result(8'b10000000, 1'b0, 1'b1);

        // SIGNED OVERFLOW: -128 - 1
        OP = 3'b001;
        A = 8'b10000000;
        B = 8'd1;
        check_result(8'b01111111, 1'b1, 1'b1);

        $display("--------------------------------");

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);

        $display("--------------------------------");

        $finish;

    end

endmodule
