`include "uvm_macros.svh"
import uvm_pkg::*;


class mux_test extends uvm_test;
	env e1;
	sequence1 seq;
	`uvm_component_utils(mux_test)

	function new(string name = "mux_test" , uvm_component parent );
		super.new(name , parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		e1 = env::type_id::create("e1" , this);
		seq = sequence1 ::type_id::create("seq" , this);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		seq.start(e1.agt.sqr);
		#10;//monitor samples signals after 10 unit so that's why 
		phase.drop_objection(this);
		phase.phase_done.set_drain_time(this,20);
		`uvm_info(get_type_name() , "end of testcase" , UVM_LOW);
	endtask
endclass



