`include "uvm_macros.svh"
import uvm_pkg::*;
//`include "driver.sv"
//`include "monitor.sv"
//`include "sequencer.sv"

class config_jk extends uvm_object;
	`uvm_object_utils(config_jk)
	uvm_active_passive_enum is_active = UVM_ACTIVE;

	function new(string name = "config_jk");
		super.new(name);
	endfunction
endclass 



class JK_agent extends uvm_agent;
	`uvm_component_utils(JK_agent)

	config_jk cfg;
	JK_driver drv;
	JK_monitor mon;
	JK_sequencer sqr;
	virtual intf vif;

	function new(string name = "JK_agent",  uvm_component parent);
		 super.new(name , parent);
	 endfunction

	 function void build_phase(uvm_phase phase);
		 super.build_phase(phase);
             mon = JK_monitor::type_id::create("mon" , this);

	     if (!uvm_config_db #(config_jk):: get(this , "" , "cfg" , cfg))begin
		     `uvm_fatal(get_type_name() , "not recieved Config") 
	     end
	     if(cfg.is_active == UVM_ACTIVE) begin
	         drv = JK_driver::type_id::create("drv" , this);
                 sqr = JK_sequencer::type_id::create("sqr" , this);
	    end

         endfunction

	 function void connect_phase (uvm_phase phase);
		 //connecting sequencer and driver
		 super.connect_phase(phase);
		 drv.seq_item_port.connect(sqr.seq_item_export);
		 //drv.vif = vif;
		 //mon.vif = vif;
	 endfunction

 endclass





