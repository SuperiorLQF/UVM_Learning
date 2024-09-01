`ifndef MCHDP_INTERFACE 
`define MCHDP_INTERFACE
interface MCHDP_IF(input clk,input rst_n);
	logic sop;
	logic eop;
	logic vld;
	logic [11:0] in_chan_data;
	clocking cb@(posedge clk);
		output sop;
		output eop;
		output vld;
		output in_chan_data;
	endclocking
	modport mp(clocking cb);
endinterface
`endif
