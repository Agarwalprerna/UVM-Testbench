`include "uvm_macros.svh"

import uvm_pkg::*;

class JK_driver extends uvm_driver #(seq_item);
	`uvm_component_utils(JK_driver)
	virtual intf vif;
          seq_item req;

	function new(string name = "JK_driver" , uvm_component parent );
	    super.new(name , parent);
    endfunction

    function void build_phase(uvm_phase phase);
	    if( !uvm_config_db #(virtual intf)::get(this , "" , "vif" , vif))begin
		    `uvm_fatal( get_type_name() , "virtual interface is not recieved")
	    end
	    super.build_phase(phase);
    endfunction

              task run_phase(uvm_phase phase);
		      forever begin
			      seq_item_port.get_next_item(req);
			      //recieved transaction convert into interface
			      //signals
			      send_to_dut(req);
			      seq_item_port.item_done();
		      end
	      endtask

	      task send_to_dut( seq_item req);
		      vif.J <= req.J;//sampling
		      vif.K <= req.K;
		      vif.rst <= req.rst;
		      @(posedge vif.clk);
	      endtask
      
		      
endclass

