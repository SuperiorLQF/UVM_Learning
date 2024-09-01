#################create work directory#######
vlib work

#################set env vairable############
set UVM_DPI_HOME D:/Modelsim/uvm-1.1d/win64
set UVM_HOME D:/Modelsim/verilog_src/uvm-1.1d

#################cmp#########################
vlog +incdir+$UVM_HOME/src -L mtiAvm -L mtiOvm -L mtiUvm -L mtiUPF $UVM_HOME/src/uvm_pkg.sv -F flist.f 

vsim -c -novopt -sv_lib $UVM_DPI_HOME/uvm_dpi work.top_tb

log -r /*

run -all
