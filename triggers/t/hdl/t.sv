module t(input clk, input rst, output logic q, output nq);

always_ff @(posedge clk) begin
  if (rst) begin
    q <= 1'b0;
  end  
  else begin
    q <= ~q;
  end
end

assign nq = ~q;

endmodule