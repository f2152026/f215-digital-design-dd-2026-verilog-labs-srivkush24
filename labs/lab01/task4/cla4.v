// cla4.v
// Gate-level 4-bit carry-lookahead adder using explicit #2 gate delays.

module cla4(
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  wire p0, p1, p2, p3;
  wire g0, g1, g2, g3;
  wire c1, c2, c3;

  // Intermediate term wires for carry lookahead logic
  wire t_c1_1;
  wire t_c2_1, t_c2_2;
  wire t_c3_1, t_c3_2, t_c3_3;
  wire t_c4_1, t_c4_2, t_c4_3, t_c4_4;

  //----------------------------------------------------------------------------
  // Step 1: Bitwise Propagate (P) and Generate (G) signals
  // p[i] = a[i] ^ b[i]
  // g[i] = a[i] & b[i]
  //----------------------------------------------------------------------------
  xor #(2) (p0, a[0], b[0]);
  xor #(2) (p1, a[1], b[1]);
  xor #(2) (p2, a[2], b[2]);
  xor #(2) (p3, a[3], b[3]);

  and #(2) (g0, a[0], b[0]);
  and #(2) (g1, a[1], b[1]);
  and #(2) (g2, a[2], b[2]);
  and #(2) (g3, a[3], b[3]);

  //----------------------------------------------------------------------------
  // Step 2: Direct carry equations using multi-input AND/OR primitives
  // c1 = g0 + p0*cin
  // c2 = g1 + p1*g0 + p1*p0*cin
  // c3 = g2 + p2*g1 + p2*p1*g0 + p2*p1*p0*cin
  // c4 = g3 + p3*g2 + p3*p2*g1 + p3*p2*p1*g0 + p3*p2*p1*p0*cin
  //----------------------------------------------------------------------------
  // Carry c1
  and #(2) (t_c1_1, p0, cin);
  or  #(2) (c1, g0, t_c1_1);

  // Carry c2
  and #(2) (t_c2_1, p1, g0);
  and #(2) (t_c2_2, p1, p0, cin);
  or  #(2) (c2, g1, t_c2_1, t_c2_2);

  // Carry c3
  and #(2) (t_c3_1, p2, g1);
  and #(2) (t_c3_2, p2, p1, g0);
  and #(2) (t_c3_3, p2, p1, p0, cin);
  or  #(2) (c3, g2, t_c3_1, t_c3_2, t_c3_3);

  // Carry c4 (cout)
  and #(2) (t_c4_1, p3, g2);
  and #(2) (t_c4_2, p3, p2, g1);
  and #(2) (t_c4_3, p3, p2, p1, g0);
  and #(2) (t_c4_4, p3, p2, p1, p0, cin);
  or  #(2) (cout, g3, t_c4_1, t_c4_2, t_c4_3, t_c4_4);

  //----------------------------------------------------------------------------
  // Step 3: Sum bit generation
  // sum[i] = p[i] ^ c[i]  (where c0 = cin)
  //----------------------------------------------------------------------------
  xor #(2) (sum[0], p0, cin);
  xor #(2) (sum[1], p1, c1);
  xor #(2) (sum[2], p2, c2);
  xor #(2) (sum[3], p3, c3);

endmodule