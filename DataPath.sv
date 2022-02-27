`timescale 1ns / 1ps
`timescale 1ns / 1ps
`define OVL_ASSERT_ON
`define OVL_INIT_MSG
`include "assert_always.vlib"
module DataPath (
		input clk,increm, comp, sr, sleft, zero, ldimm, inc, clr_pc, load_ac, load_pc, load_ir, add, mult, stcrry, clrcrry, pass,
		input ir_on_adr, pc_on_adr, dbus_on_data, data_on_dbus, alu_on_dbus, 
		output zeroflagac, //output from AC indicating a zeroflag
		output [15:0] adr_bus,
		output [2:0] op_code,
		inout [15:0] data_bus);

wire [15:0] dbus, ir_out, a_side, alu_out;
logic [15:0] pc_out;
wire [15:0] pc_out_mod = {3'b000, pc_out[12:0]}; //3 bit padding for instruction register output

AC ac (.clk(clk), .data_in(dbus), .data_out(a_side), .load(load_ac), .increm(increm), .sr(sr), .sleft(sleft), .zero(zero), .ldimm(ldimm), .zeroflag(zeroflagac));

PC pc (.clk(clk), .data_in(ir_out[12:0]), .data_out(pc_out), .inc(inc), .clr(clr_pc), .load(load_pc)); 

IR ir (.clk(clk), .data_in(dbus), .data_out(ir_out), .load(load_ir));

ALU alu (.A(a_side), .B(ir_out[12:0]), .alu_out(alu_out), .add(add), .mult(mult), .stcrry(stcrry), .clrcrry(clrcrry) ,.pass(pass)); //not sure if the other side of the ALU should be IR_out or
																																							  //directly from the bus


assign adr_bus = ir_on_adr ? ir_out[12:0] : 16'bz;

assign adr_bus = pc_on_adr ? pc_out_mod : 16'bz;

assign dbus = alu_on_dbus ? alu_out : 16'bz;

assign dbus = data_on_dbus ? data_bus : 16'bz;

assign data_bus = dbus_on_data ? dbus : 16'bz;

assign op_code = ir_out[15:13];

//datapath assertions 


//make sure data_on_bus and dbus_on_data are not active at the same time
Checkdatabus: assert property (@(posedge clk) $onehot({ dbus_on_data, data_on_dbus}));

Checkaddr: assert property (@(posedge clk) $onehot({ir_on_adr, pc_on_adr})); 






endmodule   