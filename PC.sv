`timescale 1ns / 1ps

module PC (
	input [12:0] data_in,// I've decided to not use indirect addressing in this design
	input inc, clr, clk,
	output logic [12:0] data_out,
	input load
	);
	
	
	always @(posedge clk) begin
		if (clr) data_out <= 13'b0;
		else if (load) data_out <= data_in;
		else if (inc) data_out <= data_out + 13'b0000_0000_0000_1;
	end	
	
endmodule 