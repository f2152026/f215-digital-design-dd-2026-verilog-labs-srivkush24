// tb.v
// Completed testbench template

module tb;

  // 1. Declare inputs as regs (to drive them) and outputs as wires
  reg  t_i0;
  reg  t_i1;
  reg  t_s;
  wire t_y;

  // 2. Instantiate the DUT (Assuming a 2-to-1 MUX named 'mux21')
  mux21 DUT (
    .I0(t_i0),
    .I1(t_i1),
    .S(t_s),
    .Y(t_y)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // 3. Apply different input combinations
  initial begin
    // Initialize inputs at time 0
    t_i0 = 0; t_i1 = 0; t_s = 0;
    #10; // Wait 10 time units
    
    // Test Select = 0 (Should pass I0 to Y)
    t_i0 = 1; t_i1 = 0; t_s = 0; #10;
    t_i0 = 0; t_i1 = 1; t_s = 0; #10;
    
    // Test Select = 1 (Should pass I1 to Y)
    t_s = 1; #10;
    t_i0 = 1; t_i1 = 1; t_s = 1; #10;
    t_i0 = 1; t_i1 = 0; t_s = 1; #10;
    
    // End the simulation safely
    $finish;
  end

  // Monitor updates automatically when variables change
  initial
    $monitor($time, " I0=%b I1=%b S=%b | Y=%b", t_i0, t_i1, t_s, t_y);

endmodule
