`timescale 1ns/1ps
`include "uvm_macros.svh"
`include "my_driver.sv"
import uvm_pkg::*;
module top_tb;
logic clk;
logic rst_n;
my_if input_if(.*);
my_if output_if(.*);
dut my_dut(.*,
    .rxd    (input_if.data),
    .rx_dv  (input_if.valid),
    .txd    (output_if.data),
    .tx_en  (output_if.valid)
    );
initial begin
    uvm_config_db#(virtual my_if)::set(null,"uvm_test_top","vif",input_if);
    run_test("my_driver");
end

initial begin
    clk =0;
    forever begin
        #100 clk = ~clk;
    end
end
initial begin
    rst_n = 1'b0;
    #1000;
    rst_n = 1'b1;
end
endmodule