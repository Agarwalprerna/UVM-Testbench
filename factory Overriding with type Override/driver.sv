
`include "uvm_macros.svh"
import uvm_pkg::*;


class driver extends uvm_driver #(transaction);
	transaction req;

	virtual alu_inf vif;
	 
	`uvm_component_utils(driver)

	function new(string name = "driver" , uvm_component parent);
	  super.new(name , parent);
  endfunction

  function void build_phase(uvm_phase phase);
	  super.build_phase(phase);
	  if (!uvm_config_db #(virtual alu_inf)::get(this, "" , "vif" ,vif))begin
		  `uvm_fatal( get_type_name(), "not getting virtual interface" )
	  end
  endfunction

  task run_phase(uvm_phase phase);
	  forever begin
	
		  seq_item_port.get_next_item(req);
                 // @(posedge vif.clk);
                  vif.A <= req.A;
		  vif.B <= req.B;
		  vif.sel <= req.sel;
		  vif.rst <= req.rst;
		  @(posedge vif.clk);
		 // #10;
		  `uvm_info(get_type_name() , $sformatf("DRIVER driving A= %0d ,B=%0d ,sel =%0b rst=%0b" , req.A ,req.B , req.sel ,req.rst), UVM_LOW);
		  seq_item_port.item_done();
	  end
  endtask

  endclass

	  
