module d(input clk, input rst, input d, output logic q, output nq);

always_ff @(posedge clk) begin
  if (rst) begin
    q <= 1'b0;
  end  
  else begin
    q <= d;
  end
end

assign nq = ~q;

endmodule