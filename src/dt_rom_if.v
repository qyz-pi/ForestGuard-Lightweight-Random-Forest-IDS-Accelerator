// Wrapper around Xilinx Block Memory Generator (single-port ROM).
// 36-bit wide ROM named 'blk_mem_gen_0' 
// The ROM is initialized via a .coe file. This module adds a BASE offset and
// registers the address to match the 1-cycle synchronous read latency.
module dt_rom_if #(
    parameter integer BASE = 0
)(
    input  wire        clk,
    input  wire [8:0]  node_idx,
    output reg  [35:0] all_info
);
    reg  [10:0] addra_r;
    wire [35:0] douta;

    always @(posedge clk) addra_r <= BASE + node_idx;

    blk_mem_gen_0 u_rom (
        .clka (clk),
        .ena  (1'b1),
        .addra(addra_r),
        .douta(douta)
    );

    always @(posedge clk) all_info <= douta;
endmodule