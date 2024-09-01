`timescale 1ns/1ps
`include "uvm_macros.svh"
`include "mchdp_driver.sv"
`include "mchdp_interface.sv"
import uvm_pkg::*;
module harness;
logic clk;
logic rst_n;
logic [7:0] sop;
logic [7:0] eop;
logic [7:0] vld;
logic [95:0] in_chan_data;
MCHDP_IF mif[8] (clk,rst_n);
virtual MCHDP_IF vif[8];
generate 
    genvar i;
	for(i=0;i<8;i=i+1)begin
		assign sop[i] = mif[i].sop;
		assign eop[i] = mif[i].eop;
		assign vld[i] = mif[i].vld;
		assign in_chan_data[i*12+:12]=mif[i].in_chan_data;
	end
endgenerate
MCHDP dut(
	.*
);
initial begin
    vif = mif;
    for(int i=0;i<8;i=i+1)begin
        string str;
        $sformat(str, "mif_%0d", i);
	    uvm_config_db#(virtual MCHDP_IF )::set(null,"uvm_test_top",str,vif[i]);
    end
	run_test("mchdp_driver");
end
initial begin
	clk = 0;
	forever begin
		#5 clk=~clk;
	end
end

initial begin
	rst_n = 1'b0;
	#200
	rst_n = 1'b1;
end
endmodule