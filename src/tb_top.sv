`timescale 1ns/1ps
module tb_top;
    reg clk=0;
    always #5 clk = ~clk;
    reg rstn=0;
    reg  [35:0] din;
    wire [1:0]  dout;

    Random_Forest_accelerator dut(.sysclk(clk), .rstn(rstn), .data_input(din), .class_out(dout));

    initial begin
        din  =  36'b010000100111000111111001000000000000;
        rstn = 0;
        repeat (5) @(posedge clk);
        rstn = 1;
        repeat (50) @(posedge clk);
        $finish;
    end
endmodule