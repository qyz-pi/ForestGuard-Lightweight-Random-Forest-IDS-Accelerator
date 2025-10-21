module DT #(
    parameter integer BASE = 0
)(
    input               clk,
    input               rstn,          // active-low reset
    input      [11:0]   dur,
    input      [11:0]   sbytes,
    input      [11:0]   bytes,
    output reg  [1:0]   class_out,
    output reg          done
);
    reg [11:0] dur_q, sbytes_q, bytes_q;
    reg  [8:0]  node_idx;
    wire [35:0] all_info;

    dt_rom_if #(.BASE(BASE)) u_mem (.clk(clk), .node_idx(node_idx), .all_info(all_info));

    function automatic [11:0] getFeature(input [3:0] fid);
        case (fid)
            4'd0: getFeature = bytes_q;
            4'd1: getFeature = sbytes_q;
            4'd2: getFeature = dur_q;
            default: getFeature = 12'd0;
        endcase
    endfunction

    wire [11:0] th  = all_info[35:24];
    wire [3:0]  fid = all_info[23:20];
    wire [8:0]  lc  = all_info[19:11];
    wire [8:0]  rc  = all_info[10:2];
    wire [1:0]  cls = all_info[1:0];

    wire gt, le;
    cmp #(.W(12)) u_cmp(.a(getFeature(fid)), .b(th), .gt(gt), .le(le));

    typedef enum logic [1:0] {S_INIT, S_READ, S_DECIDE, S_DONE} state_t;
    state_t state;

    initial begin
        state     = S_INIT;
        node_idx  = 9'd0;
        class_out = 2'd0;
        done      = 1'b0;
        dur_q     = 12'd0;
        sbytes_q  = 12'd0;
        bytes_q   = 12'd0;
    end

    always @(posedge clk) begin
        if (!rstn) begin
            state     <= S_INIT;
            node_idx  <= 9'd0;
            class_out <= 2'd0;
            done      <= 1'b0;
        end else begin
            done <= 1'b0; // default
            case (state)
                S_INIT: begin
                    bytes_q  <= bytes;
                    sbytes_q <= sbytes;
                    dur_q    <= dur;
                    node_idx <= 9'd0;
                    state    <= S_READ;
                end
                S_READ:    state <= S_DECIDE; // ROM 1-cycle latency
                S_DECIDE: begin
                    if (fid == 4'hF) begin
                        class_out <= cls;
                        done      <= 1'b1;  // one-cycle pulse
                        state     <= S_DONE;
                    end else begin
                        node_idx  <= (le ? lc : rc);
                        state     <= S_READ;
                    end
                end
                S_DONE:    state <= S_INIT;   // continuous evaluations
                default:   state <= S_INIT;
            endcase
        end
    end
endmodule