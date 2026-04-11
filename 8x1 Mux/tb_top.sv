//package tb_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "RTL.sv"

`include "interface.sv"   //should not inlcuded in package otherwise error encounters

`include "transaction.sv"
`include "sequence1.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "score.sv"
`include "agent.sv"
`include "env.sv"
`include "test.sv"

//endpackage

module tb_top;
  
 mux_inf vif();

   RTL dut( .in(vif.in) , .sel(vif.sel) , .y(vif.y) );

  
   initial begin
	   //set virtual interface in config db
	   uvm_config_db #(virtual mux_inf)::set(null , "*" , "vif" , vif);
  
   end
   initial begin
   	   run_test("mux_test");
   end

   endmodule


