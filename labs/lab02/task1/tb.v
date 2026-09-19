module tb;

  // TODO: declare the three DUT inputs as the appropriate variable type.
  // Use exactly these names: t_i0, t_i1, t_s (needed by $monitor below).
  reg t_i0, t_i1, t_s;

  // TODO: declare the DUT output as the appropriate net type.
  // Use exactly this name: t_y (needed by $monitor below).
  wire t_y;

  // TODO: instantiate DUT here, connecting t_i0, t_i1, t_s, t_y to its ports
  // (Assuming standard positional mapping or explicit named mapping. Adjust names if needed)
  DUT uut (
    .I0(t_i0), 
    .I1(t_i1), 
    .S(t_s), 
    .Y(t_y)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb); // Changed DUT to tb to dump the testbench scope safely
    end
  end

  initial begin
    // TODO: apply all 8 combinations of t_i0, t_i1, t_s, 5 time units apart,
    // then $finish. (Same pattern you used in Lab 1's tb.v.)
    
    // Combination 0 (000)
    t_i0 = 0; t_i1 = 0; t_s = 0;
    
    // Combination 1 (001)
    #5; t_i0 = 0; t_i1 = 0; t_s = 1;
    
    // Combination 2 (010)
    #5; t_i0 = 0; t_i1 = 1; t_s = 0;
    
    // Combination 3 (011)
    #5; t_i0 = 0; t_i1 = 1; t_s = 1;
    
    // Combination 4 (100)
    #5; t_i0 = 1; t_i1 = 0; t_s = 0;
    
    // Combination 5 (101)
    #5; t_i0 = 1; t_i1 = 0; t_s = 1;
    
    // Combination 6 (110)
    #5; t_i0 = 1; t_i1 = 1; t_s = 0;
    
    // Combination 7 (111)
    #5; t_i0 = 1; t_i1 = 1; t_s = 1;
    
    // Wait for the final state to be monitored before exiting
    #5; 
    $finish;
  end

  initial $monitor($time, " I0=%b I1=%b S=%b | Y=%b", t_i0, t_i1, t_s, t_y);

endmodule