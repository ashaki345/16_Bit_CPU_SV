`timescale 1ns / 1ps

module IR (input [15:0] data_in,
			  input clk,
			  input load,
			  output logic [15:0] data_out
			  );
			  
			  
	always @(posedge clk) begin 
		if (load) data_out <= data_in;
		end
			  
endmodule 