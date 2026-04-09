`include "uvm_macros.svh"
import uvm_pkg::*;

class JK_env extends uvm_env;
	`uvm_component_utils(JK_env)

	JK_agent agt;
	JK_scoreboard sbd;
	config_jk cfg;

	function new(string name = "JK_env" , uvm_component parent);
	  super.new(name , parent);
  endfunction

       
        function void build_phase(uvm_phase phase);
		super.build_phase(phase);
                cfg= config_jk::type_id::create("cfg");
		uvm_config_db #(config_jk) :: set(this , "*" , "cfg" , cfg);

		agt = JK_agent::type_id::create("agt" , this);
		sbd = JK_scoreboard::type_id::create("sbd" , this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		agt.mon.mon_ap.connect(sbd.sbd_ap);  //monitor and scoreboard connected
	endfunction
endclass

		
