module tb_comp2;

  reg  [1:0] A, B;
  wire       GT, LT, EQ;

  integer i, j;
  integer errors = 0;

  // Instantiate the DUT
  comp2 DUT (
    .A(A),
    .B(B),
    .GT(GT),
    .LT(LT),
    .EQ(EQ)
  );

  initial begin
    $display("Starting comp2 exhaustive test...");

    // Exhaustive test of all 16 combinations
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        A = i[1:0];
        B = j[1:0];
        #5; // Wait for combinational logic to settle

        // Check expected conditions
        if ((A > B)  !== (GT === 1'b1 && LT === 1'b0 && EQ === 1'b0)) begin
          $display("ERROR at A=%0d, B=%0d | GT=%b LT=%b EQ=%b", A, B, GT, LT, EQ);
          errors = errors + 1;
        end
        if ((A < B)  !== (LT === 1'b1 && GT === 1'b0 && EQ === 1'b0)) begin
          $display("ERROR at A=%0d, B=%0d | GT=%b LT=%b EQ=%b", A, B, GT, LT, EQ);
          errors = errors + 1;
        end
        if ((A == B) !== (EQ === 1'b1 && GT === 1'b0 && LT === 1'b0)) begin
          $display("ERROR at A=%0d, B=%0d | GT=%b LT=%b EQ=%b", A, B, GT, LT, EQ);
          errors = errors + 1;
        end
      end
    end

    if (errors == 0)
      $display("SUCCESS: All 16 combinations passed perfectly!");
    else
      $display("FAILURE: Found %0d error(s).", errors);

    $finish;
  end

endmodule