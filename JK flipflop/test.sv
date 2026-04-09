`include "uvm_macros.svh"
import uvm_pkg::*;

class JK_test extends uvm_test;
	`uvm_component_utils(JK_test)

	JK_env e1;
	JK_seq seq1;
	rst_check seq2;
	random_check seq3;


	function new(string name = "JK_test" , uvm_component parent);
		super.new(name , parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		e1 =  JK_env::type_id::create("env" , this);
		seq1 = JK_seq ::type_id::create("seq1");
         	seq2 = rst_check ::type_id::create("seq2");
	        seq3 = random_check ::type_id::create("seq3");

	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		seq1.start(e1.agt.sqr);  //sequence calls start method to pass seq item to sequencer 
               seq2.start(e1.agt.sqr);
		seq3.start(e1.agt.sqr);
	
		phase.drop_objection(this);
	endtask
endclass

