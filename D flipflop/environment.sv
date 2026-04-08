`include "uvm_macros.svh"
import uvm_pkg::*;

class dff_env extends uvm_env;
	`uvm_component_utils(dff_env)

	dff_agent agt;
	dff_scoreboard sbd;

	function new(string name = "dff_env" , uvm_component parent);
	  super.new(name , parent);
  endfunction

       
        function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		agt = dff_agent::type_id::create("agt" , this);
		sbd = dff_scoreboard::type_id::create("sbd" , this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		agt.mon.mon_ap.connect(sbd.sbd_ap);
	endfunction
endclass

		
