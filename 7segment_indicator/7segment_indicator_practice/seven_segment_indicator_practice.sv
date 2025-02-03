module seven_segment_indicator_practice #(parameter clk_div = 16,
                                          parameter q_of_7segment_ind = 4)
                                        (input CLK, 
                                        input RESET, 
                                        input logic[3:0] KEY_SW, 
                                        output logic[7:0] SEG,
                                        output logic[3:0] DIG);
	logic[3:0] key;
	assign key = ~KEY_SW;
  logic[7:0] seg;
  assign SEG = ~seg;
  logic[3:0] dig;
  assign DIG = ~dig;
					

	logic[clk_div-1:0] counter;
	always_ff @(posedge CLK or negedge RESET) begin
		if (~RESET) begin
			counter <= '0;
		end
		else begin
			counter <= counter + 1'b1;
		end
	end


  function logic [7:0] dig_to_seg (input logic [3:0] dig);
    case (dig)
      'h0: dig_to_seg = 'b11111100;  // a b c d e f g h
      'h1: dig_to_seg = 'b01100000;
      'h2: dig_to_seg = 'b11011010;  //   --a--
      'h3: dig_to_seg = 'b11110010;  //  |     |
      'h4: dig_to_seg = 'b01100110;  //  f     b
      'h5: dig_to_seg = 'b10110110;  //  |     |
      'h6: dig_to_seg = 'b10111110;  //   --g--
      'h7: dig_to_seg = 'b11100000;  //  |     |
      'h8: dig_to_seg = 'b11111110;  //  e     c
      'h9: dig_to_seg = 'b11100110;  //  |     |
      'ha: dig_to_seg = 'b11101110;  //   --d--  h
      'hb: dig_to_seg = 'b00111110;
      'hc: dig_to_seg = 'b10011100;
      'hd: dig_to_seg = 'b01111010;
      'he: dig_to_seg = 'b10011110;
      'hf: dig_to_seg = 'b10001110;
    endcase
  endfunction


  logic[q_of_7segment_ind*4-1 : 0] num;
  always_ff @(posedge CLK or negedge RESET) begin
    if (~RESET) begin
      num <= 1'b0;
    end
    else  if (counter == '0) begin
      if (add_flag) begin
        num <= num + 1'b1;
      end
      else if (sub_flag) begin
        num <= num - 1'b1;
      end
    end
  end


  logic[1:0] prev_keys;
  always_ff @(posedge CLK or negedge RESET) begin
    if (~RESET) begin
      prev_keys <= '0;
    end
    else if (counter == '0) begin
      prev_keys <= key[1:0];
    end
  end

  assign sub_flag = prev_keys[1] & ~key[1];
  assign add_flag = prev_keys[0] & ~key[0];


  logic[$clog2(q_of_7segment_ind)-1 : 0] index;
  always_ff @(posedge CLK or negedge RESET) begin
    if (~RESET) begin
      index <= 1'b0;
    end
    else if (counter == '0) begin
      index <= index + 1'b1;
    end
  end

  assign seg = dig_to_seg(num[(index * 4)+3 -: 4]);
  assign dig = q_of_7segment_ind' (1'b1) << index;
endmodule