`include "uvm_macros.svh"
import uvm_pkg::*;
//`include "driver.sv"
//`include "monitor.sv"
//`include "sequencer.sv"

class dff_agent extends uvm_agent;
	`uvm_component_utils(dff_agent)

	dff_driver drv;
	dff_monitor mon;
	dff_sequencer sqr;
	virtual intf vif;

	function new(string name = "dff_agent",  uvm_component parent);
		 super.new(name , parent);
	 endfunction

	 function void build_phase(uvm_phase phase);
		 super.build_phase(phase);
	   if (!(uvm_config_db #(virtual intf):: get(this , "" , "vif" , vif)))
		`uvm_error(get_type_name() , "not getting virtual interface")
	  drv = dff_driver::type_id::create("drv" , this);
          mon = dff_monitor::type_id::create("mon" , this);
          sqr = dff_sequencer::type_id::create("sqr" , this);

         endfunction

	 function void connect_phase (uvm_phase phase);
		 //connecting sequencer an ddriver
		 super.connect_phase(phase);
		 drv.seq_item_port.connect(sqr.seq_item_export);
		 //drv.vif = vif;
		 //mon.vif = vif;
	 endfunction

 endclass





