module jk(input clk, input rst, input j, input k, output logic q, output nq);

always_ff @(posedge clk) begin
  if (rst) begin
    q <= 1'b0;
  end  
  else begin
    case ({j,k})
      2'b10: begin
        q <= 1'b1;
      end
      2'b01: begin
        q <= 1'b0;
      end
      2'b11: begin
        q <= ~q;
      end
    endcase
  end
end

assign nq = ~q;

endmodule