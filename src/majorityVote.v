// majorityVote.v - ??‡C‘½”?(•½èæ?†¬)
module majorityVote(
   input  [1:0] a, b, c, d, e, f,
   output [1:0] class_out
);
   reg [2:0] c0,c1,c2,c3;
   reg [2:0] best;
   reg [1:0] idx;

   always @* begin
      c0=0; c1=0; c2=0; c3=0;
      case (a) 2'd0:c0=c0+1; 2'd1:c1=c1+1; 2'd2:c2=c2+1; default:c3=c3+1; endcase
      case (b) 2'd0:c0=c0+1; 2'd1:c1=c1+1; 2'd2:c2=c2+1; default:c3=c3+1; endcase
      case (c) 2'd0:c0=c0+1; 2'd1:c1=c1+1; 2'd2:c2=c2+1; default:c3=c3+1; endcase
      case (d) 2'd0:c0=c0+1; 2'd1:c1=c1+1; 2'd2:c2=c2+1; default:c3=c3+1; endcase
      case (e) 2'd0:c0=c0+1; 2'd1:c1=c1+1; 2'd2:c2=c2+1; default:c3=c3+1; endcase
      case (f) 2'd0:c0=c0+1; 2'd1:c1=c1+1; 2'd2:c2=c2+1; default:c3=c3+1; endcase
      best=c0; idx=2'd0;
      if (c1>best) begin best=c1; idx=2'd1; end
      if (c2>best) begin best=c2; idx=2'd2; end
      if (c3>best) begin best=c3; idx=2'd3; end
   end
   assign class_out = idx;
endmodule
