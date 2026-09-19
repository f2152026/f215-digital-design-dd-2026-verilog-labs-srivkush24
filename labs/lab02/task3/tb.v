module tb;

  reg  [1:0] t_a, t_b;
  wire       t_gt, t_lt, t_eq;

  integer i, j;
  integer errors = 0;

  comp2 DUT (
    .A(t_a),
    .B(t_b),
    .GT(t_gt),
    .LT(t_lt),
    .EQ(t_eq)
  );

  initial begin
    $display("--- Starting Exhaustive Test for comp2 ---");

    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i[1:0];
        t_b = j[1:0];
        #5; // Allow combinational logic to evaluate

        // 1. One-hot / Mutual exclusivity check
        if ((t_gt + t_lt + t_eq) !== 1) begin
          $display("ERROR: Mutex violation at A=%0d, B=%0d | GT=%b LT=%b EQ=%b",
                   t_a, t_b, t_gt, t_lt, t_eq);
          errors = errors + 1;
        end

        // 2. Functional checks
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