module alu_8bit (
    input  logic [7:0] A,
    input  logic [7:0] B,
    input  logic [2:0] OP,

    output logic [7:0] RESULT,
    output logic       CARRY,
    output logic       ZERO,
    output logic       OVERFLOW
);

    logic [8:0] TEMP;

    always_comb begin

        // Default values
        RESULT   = 8'b0;
        CARRY    = 1'b0;
        OVERFLOW = 1'b0;
        TEMP     = 9'b0;

        case (OP)

            // ADD
            3'b000: begin
                TEMP   = {1'b0, A} + {1'b0, B};
                RESULT = TEMP[7:0];
                CARRY  = TEMP[8];

                // Signed overflow
                OVERFLOW = (~(A[7] ^ B[7])) &
                           (RESULT[7] ^ A[7]);
            end

            // SUB
            3'b001: begin
                TEMP   = {1'b0, A} - {1'b0, B};
                RESULT = TEMP[7:0];

                // CARRY = 1 means no borrow
                CARRY = (A >= B);

                // Signed overflow
                OVERFLOW = (A[7] ^ B[7]) &
                           (RESULT[7] ^ A[7]);
            end

            // AND
            3'b010: begin
                RESULT = A & B;
            end

            // OR
            3'b011: begin
                RESULT = A | B;
            end

            // XOR
            3'b100: begin
                RESULT = A ^ B;
            end

            // NOT
            3'b101: begin
                RESULT = ~A;
            end

            // Shift Left
            3'b110: begin
                RESULT = A << 1;
                CARRY  = A[7];
            end

            // Shift Right
            3'b111: begin
                RESULT = A >> 1;
                CARRY  = A[0];
            end

            default: begin
                RESULT   = 8'b0;
                CARRY    = 1'b0;
                OVERFLOW = 1'b0;
            end

        endcase

        // Zero flag
        ZERO = (RESULT == 8'b0);

    end

endmodule
