`timescale 1ns / 1ps

module AC (

	input [15:0] data_in,
	input [15:0] ir_in,
	input load,
	input clk,  
	input increm,
	input comp,
	input sr,
	input sleft,
	input zero,
	input ldimm,
	output logic [15:0] data_out,
	output zeroflag //used for PC counter for JEZ instruction
	);
	
wire signed [15:0] s_data_out = data_out;
wire signed [15:0] s_ir_in = ir_in;
		
	
	always @(posedge clk) begin 
		if(load) data_out <= data_in; // load accumulator 
		else if(increm) data_out <= data_out + 16'b0000_0000_0000_0001; // increment accumulator by 1
		else if (comp) data_out <= ~data_out; //complement accumulator
		else if (sr) data_out <= s_data_out >> 1; //shift right accumulator
		else if (sleft) data_out <= data_out << 1; //shit left accumulator
		else if (zero) data_out <= 16'b0; // zero accumulator
		else if (ldimm) data_out <= s_ir_in; // load accumulator immediate, sign extend
	end
	
	
assign zeroflag = (data_out == 16'b0) ? 1'b1 : 1'bz; // if accumulator equals 0, let controller know for direct jump when accumulator equals to 0 

endmodule 