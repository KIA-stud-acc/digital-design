module testbench;
logic[3:0] i;
logic o, no;


initial begin
  $dumpfile("test.vcd");
  $dumpvars;

  for (i = 4'b0; i<4'b1111; i++) begin
    #5;
  end
  //i = '0;
  $finish;
end


rs dut(.r(i[3]), .s(i[2]), .q(o), .nq(no));

endmodule