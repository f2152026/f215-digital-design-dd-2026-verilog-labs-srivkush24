// tb.v
module tb;

  reg  [1:0] t_a, t_b;
  wire       t_gt, t_lt, t_eq;

  integer i, j;
  integer errors = 0;

  // Instantiate the DUT
  comp2 DUT (
    .A(t_a),
    .B(t_b),
    .GT(t_gt),
    .LT(t_lt),
    .EQ(t_eq)
  );

  initial begin
    $display("Starting comp2 exhaustive test...");

    // Test all 16 combinations
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i[1:0];
        t_b = j[1:0];
        #5; // Allow combinational logic to settle

        // Check 1: One-hot mutual exclusivity constraint
        if ((t_gt + t_lt + t_eq) !== 1) begin
          $display("ERROR: Mutex violation at A=%0d, B=%0d | GT=%b LT=%b EQ=%b",
                   t_a, t_b, t_gt, t_lt, t_eq);
          errors = errors + 1;
        end

        // Check 2: Functional correctness
        if ((t_a > t_b)  && !t_gt) errors = errors + 1;
        if ((t_a < t_b)  && !t_lt) errors = errors + 1;
        if ((t_a == t_b) && !t_eq) errors = errors + 1;
      end
    end

    if (errors == 0)
      $display("SUCCESS: All 16 combinations passed perfectly!");
    else
      $display("FAILURE: Found %0d error(s).", errors);

    $finish;
  end

endmodule