module Random_Forest_accelerator(
    input  wire        sysclk,
    input  wire        rstn,         // active-low reset
    input  wire [35:0] data_input,   // {bytes[35:24], sbytes[23:12], dur[11:0]}
    output wire [1:0]  class_out
);
    wire [11:0] bytes  = data_input[35:24];
    wire [11:0] sbytes = data_input[23:12];
    wire [11:0] dur    = data_input[11:0];

`include "forest_base_addrs.vh"

    wire [1:0] r0, r1, r2, r3, r4, r5;
    wire d0, d1, d2, d3, d4, d5;

    DT #(.BASE(BASE0)) u_dt0(.clk(sysclk), .rstn(rstn), .bytes(bytes), .sbytes(sbytes), .dur(dur), .class_out(r0), .done(d0));
    DT #(.BASE(BASE1)) u_dt1(.clk(sysclk), .rstn(rstn), .bytes(bytes), .sbytes(sbytes), .dur(dur), .class_out(r1), .done(d1));
    DT #(.BASE(BASE2)) u_dt2(.clk(sysclk), .rstn(rstn), .bytes(bytes), .sbytes(sbytes), .dur(dur), .class_out(r2), .done(d2));
    DT #(.BASE(BASE3)) u_dt3(.clk(sysclk), .rstn(rstn), .bytes(bytes), .sbytes(sbytes), .dur(dur), .class_out(r3), .done(d3));
    DT #(.BASE(BASE4)) u_dt4(.clk(sysclk), .rstn(rstn), .bytes(bytes), .sbytes(sbytes), .dur(dur), .class_out(r4), .done(d4));
    DT #(.BASE(BASE5)) u_dt5(.clk(sysclk), .rstn(rstn), .bytes(bytes), .sbytes(sbytes), .dur(dur), .class_out(r5), .done(d5));

    wire all_done = d0 & d1 & d2 & d3 & d4 & d5;

    majorityVote u_mv(
  .a(r0), .b(r1), .c(r2), .d(r3), .e(r4), .f(r5),
  .class_out(class_out)
);

                      
                   
   
   
endmodule