`timescale 1ns / 1ps

module  Top(input reset, clk,
	output [15:0] adr_bus,
	output rd_mem, wr_mem,
	inout [15:0] data_bus
	);

	
logic increm, comp, sr, sleft, zero, ldimm, jump, inc, 
	clr_pc, load_ac, load_pc, load_ir, zeroflagtop, add, mult, 
	stcrry, clrcrry, pass,ir_on_adr, pc_on_adr, 
	dbus_on_data, data_on_dbus, alu_on_dbus;
logic [15:10] op_code;


Controller co(.reset(reset), .clk(clk), .op_code(op_code),
				.increm(increm), .comp(comp), .sr(sr), .sleft(sleft), .ldimm(ldimm),  
				.inc(inc), .clr_pc(clr_pc), .load_ac(load_ac), .load_pc(load_pc), .load_ir(load_ir), 
				.zeroflag(zeroflagtop), .add(add), .mult(mult), .stcrry(stcrry), .clrcrry(clrcrry), 
				.rd_mem(rd_mem), .wr_mem(wr_mem), .pass(pass), .ir_on_adr(ir_on_adr), .pc_on_adr(pc_on_adr), 
				.dbus_on_data(dbus_on_data), .data_on_dbus(data_on_dbus), .alu_on_dbus(alu_on_dbus));
			

DataPath db(.clk(clk), .op_code(op_code),
				.increm(increm), .comp(comp), .sr(sr), .sleft(sleft), .ldimm(ldimm), 
				.inc(inc), .clr_pc(clr_pc), .load_ac(load_ac), .load_pc(load_pc), .load_ir(load_ir), 
				.zeroflagac(zeroflagtop), .add(add), .mult(mult), .stcrry(stcrry), .clrcrry(clrcrry), 
				.pass(pass), .ir_on_adr(ir_on_adr), .pc_on_adr(pc_on_adr), 
				.dbus_on_data(dbus_on_data), .data_on_dbus(data_on_dbus), .alu_on_dbus(alu_on_dbus), .data_bus(data_bus), .adr_bus(adr_bus));

endmodule 