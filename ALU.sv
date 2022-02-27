`timescale 1ns / 1ps

module ALU(
	input [15:0] A, 
	input [15:0] B,
	input pass,
	input add,
	input mult,
	input stcrry,
	input clrcrry,
	output logic [15:0] alu_out,
	output carryflg 
	);
	
	always @(A or B or pass or add or mult) begin 
		if(pass) alu_out = A;
		else if (add) alu_out = A + B;
		else if (mult) alu_out = A[7:0] * B[7:0]; //multiply using right hand side bits
	end
	
	



endmodule 