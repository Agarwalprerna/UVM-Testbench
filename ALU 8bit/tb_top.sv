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

   logic clk;
   //logic rst;

   initial begin
	     clk=0;
             forever #5 clk =~clk;
     end
  
 alu_inf vif(clk );

   RTL dut(  .clk(vif.clk) , .rst(vif.rst) , .A(vif.A) , .B(vif.B) , .sel(vif.sel) , .result(vif.result));

  
   initial begin
	   //set virtual interface in config db
	   uvm_config_db #(virtual alu_inf)::set(null , "*" , "vif" , vif);
  
   end
  // initial begin
//	   rst =1;
//	   #10;
//	   rst =0;
  // end

   initial begin

   	   run_test("alu_test");
   end

   endmodule


