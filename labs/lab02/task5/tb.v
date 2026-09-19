// tb.v
// Testbench for ALU verification

module tb;

  reg  [3:0] t_a, t_b;
  reg        t_op;
  wire [3:0] t_result;

  integer errors = 0;

  // Instantiate the ALU
  alu DUT (
    .a(t_a),
    .b(t_b),
    .op(t_op),
    .result(t_result)
  );

  initial begin
    $display("--- Starting ALU Verification ---");

    // Initialize inputs
    t_a = 4'd8; t_b = 4'd3; t_op = 1'b0;
    #5;
    if (t_result !== 4'd11) begin
      $display("ERROR: Addition failed! Expected 11, got %0d", t_result);
      errors = errors + 1;
    end

    // Test Bug 1: Sensitivity list check (toggle op while holding a & b constant)
    t_op = 1'b1; // Change op from ADD to SUB
    #5;
    if (t_result !== 4'd5) begin
      $display("ERROR: Op change failed! Expected 5 (8-3), got %0d (Sensitivity bug)", t_result);
      errors = errors + 1;
    end

    // Test Bug 2: Single-step subtract calculation check
    t_a = 4'd10; t_b = 4'd4; t_op = 1'b1;
    #5;
    if (t_result !== 4'd6) begin
      $display("ERROR: Subtraction failed! Expected 6 (10-4), got %0d (Non-blocking bug)", t_result);
      errors = errors + 1;
    end

    // Summary
    if (errors == 0)
      $display("SUCCESS: All ALU tests passed perfectly!");
    else
      $display("FAILURE: Found %0d error(s).", errors);

    $finish;
  end

endmodule