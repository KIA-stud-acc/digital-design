module testbench;
logic clk, rst;
logic[3:0] i;
logic o, no;

initial begin
  clk = 1'b1;
  forever begin
    #5; clk = ~clk;
  end
end

initial begin
  rst = 1'b1;
  repeat(3) begin
    @(posedge clk);
  end
  rst = 1'b0;
end




initial begin
  $dumpfile("test.vcd");
  $dumpvars;
  @(negedge rst);
  for (i = 4'b0; i<4'b1111; i++) begin
    #4;
  end
  $finish;
end


d dut(.clk(clk), .rst(rst), .d(i[1]), .q(o), .nq(no));

endmodule