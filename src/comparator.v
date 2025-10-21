// Parameterized comparator 
module cmp #(parameter W=12)(
    input  wire [W-1:0] a,
    input  wire [W-1:0] b,
    output wire         gt,
    output wire         le
);
    assign gt = (a > b);
    assign le = (a <= b);
endmodule