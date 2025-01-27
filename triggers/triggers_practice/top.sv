module top 	 #(clk_div = 26)
				  (input CLK, 
					input RESET, 
					input logic[3:0] KEY_SW, 
					output logic[3:0] LED);
	//`define D_latch
	//`define D_flip_flop_1
	//`define D_flip_flop_2
	`define RS
	//`define JK
	//`define T
	logic[3:0] key;
	assign key = ~KEY_SW;
	logic[3:0] led;
	assign LED = ~led;
					
	logic[clk_div:0] counter;
	always_ff @(posedge CLK) begin
		if (~RESET) begin
			counter <= '0;
		end
		else begin
			counter <= counter + 1'b1;
		end
	end
	
	
	
	`ifdef D_latch
	always_latch begin
		if (counter[clk_div] == '1) begin
			led[3:1] = key[3:1];
		end
	end
	`endif
	
	
	
	`ifdef D_flip_flop_1
	always_ff @(posedge CLK) begin
		if (~RESET) begin
			led[3:1] <= '0;
		end
		else if (counter == '1) begin
			led[3:1] <= key[3:1];
		end
	end
	`endif
	
	
	
	`ifdef D_flip_flop_2
	logic[2:0] q;
	always_latch begin
		if (counter[clk_div] == '0) begin
			q = key[3:1];
		end
	end
	
	always_latch begin
		if (counter[clk_div] == '1) begin
			led[3:1] = q;
		end
	end
	`endif
	
	
	
	`ifdef RS
	always_comb begin
		led[3] = ~(led[2] | key[2]);
		led[2] = ~(led[3] | key[3]);
	end
	assign led[1] = '0;
	`endif
	
	
	
	`ifdef JK
	logic[1:0] q;
	
	always_ff @(posedge CLK) begin
		if (~RESET) begin
			led[3:2] <= '0;
		end
		else if (counter == '1) begin
			led[3:2] <= q;
		end
	end
	
	always_comb begin
		case(key[3:2])
			2'b00: q = led[3:2];
			2'b01: q = 2'b01;
			2'b10: q = 2'b10;
			2'b11: q = ~led[3:2];
		endcase
	end
	
	assign led[1] = '0;
	`endif
	
	
	
	`ifdef T
	always_ff @(posedge CLK) begin
		if (~RESET) begin
			led[3:1] <= '0;
		end
		else if (counter == '1) begin
			led[3:1] <= ~led[3:1];
		end
	end
	`endif

assign led[0] = ~counter[clk_div];


endmodule