// cla64_flat.v
// Flat 64-bit Carry-Lookahead Adder with explicit #2 gate delays.

module cla64_flat(
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

  wire [63:0] p, g;
  wire [64:0] c;

  // Bitwise Propagate and Generate signals
  genvar i;
  generate
    for (i = 0; i < 64; i = i + 1) begin : gen_pg
      xor #(2) (p[i], a[i], b[i]);
      and #(2) (g[i], a[i], b[i]);
    end
  endgenerate

  // Base carry input
  assign c[0] = cin;

  // Carry evaluation chain
  generate
    for (i = 0; i < 64; i = i + 1) begin : gen_carries
      wire [i:0] terms;
      
      // term[j] = g[j] & p[j+1] & ... & p[i]
      genvar j;
      for (j = 0; j <= i; j = j + 1) begin : gen_terms
        if (j == i) begin : gen_g
          assign terms[j] = g[i];
        end else if (j == 0) begin : gen_cin
          // p[i] & ... & p[0] & cin
          wire p_prod;
          assign p_prod = &p[i:0];
          and #(2) (terms[0], p_prod, cin);
        end else begin : gen_internal
          // g[j-1] & p[i] & ... & p[j]
          wire p_prod;
          assign p_prod = &p[i:j];
          and #(2) (terms[j], g[j-1], p_prod);
        end
      end

      // OR all generating terms together
      assign c[i+1] = |terms;
    end
  endgenerate

  // Calculate sum outputs
  generate
    for (i = 0; i < 64; i = i + 1) begin : gen_sum
      xor #(2) (sum[i], p[i], c[i]);
    end
  endgenerate

  assign cout = c[64];

endmodule