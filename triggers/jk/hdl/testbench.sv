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
    @(posedge clk);
  end
  $finish;
end


jk dut(.clk(clk), .rst(rst), .j(i[3]), .k(i[2]), .q(o), .nq(no));

endmodule