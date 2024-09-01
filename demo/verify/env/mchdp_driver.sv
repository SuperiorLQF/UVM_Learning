`ifndef MCHDP_DRV
`define MCHDP_DRV
`include "uvm_macros.svh"
import uvm_pkg::*;
class mchdp_driver extends uvm_driver;
    `uvm_component_utils(mchdp_driver)
    virtual MCHDP_IF vif[8];
    function new(string name = "mchdp_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction 
    extern function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
endclass 
function void mchdp_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    for(int i=0;i<8;i=i+1)begin
        string str;
        $sformat(str, "mif_%0d", i);        
        uvm_config_db#(virtual MCHDP_IF)::get(this,"",str,vif[i]);
    end
endfunction
task mchdp_driver::main_phase(uvm_phase phase);
    phase.raise_objection(this);
    for(int i =0;i<8;i++)begin
        vif[i].mp.sop = 1'b0;
    end    
    while(!vif[0].rst_n)
        @(vif[0].clk);
    for(int i =0;i<8;i++)begin
        vif[i].mp.sop = 1'b1;
        @(vif[i].cb);        
        vif[i].mp.sop = 1'b0;
        repeat(10)begin
            @(vif[i].cb);
        end
    end
    phase.drop_objection(this);
    `uvm_info("driver","sim over!",UVM_LOW);
endtask
`endif
