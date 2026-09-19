// alu.v
// Fixed 1-bit-opcode ALU module

module alu (
  input      [3:0] a,
  input      [3:0] b,
  input            op,      // 0 = add, 1 = sub
  output reg [3:0] result
);

  reg [3:0] b_inv;
  reg [3:0] b_twos;

  // FIX 1: Use @(*) so all input signals (a, b, op) are in the sensitivity list
  always @(*) begin
    case (op)
      1'b0: begin
        result = a + b;                 // add
      end
      1'b1: begin
        // FIX 2: Use blocking assignments (=) instead of non-blocking (<=)
        // so that intermediate values update immediately within the same step
        b_inv  = ~b;                    // one's complement
        b_twos = b_inv + 4'b0001;       // two's complement
        result = a + b_twos;
      end
    endcase
  end

endmodule