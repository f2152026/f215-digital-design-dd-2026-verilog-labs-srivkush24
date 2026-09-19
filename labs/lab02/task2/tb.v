// mux21.v
// 2-to-1 Multiplexer Implementation
// Y = I0 when S = 0, Y = I1 when S = 1

module mux21 (
  input  wire I0,
  input  wire I1,
  input  wire S,
  output wire Y
);

  // Continuous assignment modeling 2:1 multiplexer logic
  assign Y = S ? I1 : I0;

endmodule