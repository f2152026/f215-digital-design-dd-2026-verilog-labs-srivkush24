// comp2.v 
// 2-bit unsigned magnitude comparator. 

module comp2 (
    input  [1:0] A,
    input  [1:0] B,
    output       GT,
    output       LT,
    output       EQ
);

    // FIX: Changed >= to > so exactly one output is high when A == B
    assign EQ = (A == B);
    assign GT = (A > B);  
    assign LT = (A < B);

endmodule
