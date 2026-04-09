`include "uvm_macros.svh"
import uvm_pkg::*;

`include "interface.sv"
`include "seq_item.sv"
`include "sequence.sv"
`include "sequence2.sv"
`include "sequence3.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "score.sv"
`include "environment.sv"
`include "test.sv"
`include "RTL.sv"




module tb_top;

   bit clk;

  // intf i_i(clk);
 intf vif(clk);

   //RTL dut(.clk(i_i.clk) , .rst(i_i.rst) , .J(i_i.J) ,.K(i_i.K) ,  .Q(i_i.Q) );

 RTL dut(.clk(vif.clk) , .rst(vif.rst) , .J(vif.J) ,.K(vif.K) ,  .Q(vif.Q) );

   initial begin
	   clk = 0;
	   forever #5 clk = ~clk;
   end

  
   initial begin
	   //uvm_config_db #(virtual intf)::set(null , "*" , "i_i" , i_i);
           uvm_config_db #(virtual intf)::set(null , "*" , "vif" , vif);

   end

   initial begin
	   run_test("JK_test");
   end

   endmodule

