module rs(input r, input s, output logic q, output logic nq);


assign q   = ~(nq | r);
assign nq  = ~( q | s);


endmodule