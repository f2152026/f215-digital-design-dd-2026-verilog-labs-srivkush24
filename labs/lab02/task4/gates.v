// 1. Dataflow implementation using continuous assignment delay
module and_df (
    input  wire a,
    input  wire b,
    output wire y
);
    // Inertial Delay: Filters out any input pulse shorter than 5 time units.
    assign #5 y = a & b;
endmodule


// 2. Behavioral implementation with delay BEFORE evaluation (inter-assignment delay)
module and_beh_before (
    input  wire a,
    input  wire b,
    output reg  y
);
    always @(a or b) begin
        // Waits 5 time units FIRST, then evaluates the CURRENT values of 'a' and 'b'.
        #5 y = a & b;
    end
endmodule


// 3. Behavioral implementation with INTRA-assignment delay
module and_beh_intra (
    input  wire a,
    input  wire b,
    output reg  y
);
    always @(a or b) begin
        // Evaluates 'a & b' IMMEDIATELY when an input changes,
        // but delays assigning that sampled result to 'y' by 5 time units.
        y = #5 (a & b);
    end
endmodule