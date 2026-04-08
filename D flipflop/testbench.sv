`include "uvm_macros.svh"
import uvm_pkg::*;

`include "interface.sv"
`include "seq_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "score.sv"
`include "environment.sv"
`include "test.sv"
`include "RTL.sv"


module tb_top;

   logic clk;

   intf vif(clk);
   RTL dut(.clk(clk) , .rst(vif.rst) , .d(vif.d) , .Q(vif.Q) );

   initial begin
	   clk = 0;
	   forever #5 clk = ~clk;
   end

  // initial begin
//	   vif.rst = 1'b1;
//	   #20 vif.rst = 1'b0;
  // end

   initial begin
	   uvm_config_db #(virtual intf)::set(null , "*" , "vif" , vif);
	   run_test("dff_test");
   end
   endmodule

