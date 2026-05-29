`include "uvm_macros.svh"
import uvm_pkg::*;

class seq_item extends uvm_sequence_item;
	`uvm_object_utils(seq_item)

	rand int data1;
	rand int data2;

	function new(string name = "seq_item");
		super.new(name);
	endfunction

endclass

class sequence1 extends uvm_sequence #(seq_item);
	`uvm_object_utils(sequence1)
	seq_item req;

	function new(string name = "sequence1");
		super.new(name);
	endfunction

	task body();
		`uvm_info(get_type_name() , "inside body task of sequence1", UVM_LOW)
		req = seq_item::type_id::create("req");
		start_item(req);
		assert(req.randomize());
		finish_item(req);
	endtask
endclass


class sequence2 extends uvm_sequence #(seq_item);
	`uvm_object_utils(sequence2)
	seq_item req;

	function new(string name = "sequence2");
		super.new(name);
	endfunction

	task body();
		`uvm_info(get_type_name() , "inside body task of sequence2", UVM_LOW)
		req = seq_item::type_id::create("req");
		start_item(req);
		assert(req.randomize());
		finish_item(req);
	endtask
endclass



class sequencer1 extends uvm_sequencer #(seq_item);
	`uvm_component_utils(sequencer1)

	function new(string name , uvm_component parent);
		super.new(name , parent);
	endfunction
endclass

class sequencer2 extends uvm_sequencer #(seq_item);
	`uvm_component_utils(sequencer2)

	function new(string name , uvm_component parent);
		super.new(name , parent);
	endfunction
endclass

class virtual_sequencer extends uvm_sequencer;
	`uvm_component_utils(virtual_sequencer)

	sequencer1 sqr1;
	sequencer2 sqr2;

	function new(string name , uvm_component parent);
		super.new(name , parent);
	endfunction

endclass

class virtual_sequence extends uvm_sequence ;
	`uvm_object_utils(virtual_sequence)
	`uvm_declare_p_sequencer(virtual_sequencer)

	//sequencer1 sqr1;
	//sequencer2 sqr2;
        
	sequence1 seq1;
	sequence2 seq2;

	function new(string name ="virtual_sequence");
		super.new(name);
	endfunction

	task body();
		seq1 = sequence1::type_id::create("seq1");
		seq2 = sequence2::type_id::create("seq2");
		fork
			seq1.start(p_sequencer.sqr1);
                        seq2.start(p_sequencer.sqr2);
		join
	endtask
endclass



class base_driver extends uvm_driver #(seq_item);
	`uvm_component_utils(base_driver)
	seq_item req;

	function new(string name = "base_driver" , uvm_component parent);
		super.new(name , parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);
			drive(req);
			seq_item_port.item_done();
		end
	endtask

	virtual task drive(seq_item req);
	endtask
endclass


class driver1 extends base_driver;
	`uvm_component_utils(driver1)
	seq_item req;

	function new(string name = "driver1" , uvm_component parent);
		super.new(name , parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	virtual task drive(seq_item req);
		`uvm_info(get_type_name() , "driving from driver 1" , UVM_LOW)
		#50;
	endtask
endclass

class driver2 extends base_driver;
	`uvm_component_utils(driver2)
	seq_item req;

	function new(string name = "driver2" , uvm_component parent);
		super.new(name , parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	virtual task drive(seq_item req);
		`uvm_info(get_type_name() , "driving from driver 2" , UVM_LOW)
		#50;
	endtask
endclass

class agent1 extends uvm_agent;
	`uvm_component_utils(agent1)

	driver1 drv1;
	sequencer1 sqr1;

	function new(string name = "agent1" , uvm_component parent);
		super.new(name , parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		drv1 = driver1::type_id::create("drv1",this);
		sqr1 = sequencer1::type_id::create("sqr1",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv1.seq_item_port.connect(sqr1.seq_item_export);
	endfunction

endclass


class agent2 extends uvm_agent;
	`uvm_component_utils(agent2)

	driver2 drv2;
	sequencer2 sqr2;

	function new(string name = "agent2" , uvm_component parent);
		super.new(name , parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
         	drv2 = driver2::type_id::create("drv2",this);
		sqr2 = sequencer2::type_id::create("sqr2",this);

	endfunction

        function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv2.seq_item_port.connect(sqr2.seq_item_export);
	endfunction



endclass

class env extends uvm_env;
	`uvm_component_utils(env)
	agent1 agt1;
	agent2 agt2;
     
	//virtual sequencer 
	virtual_sequencer vsqr;

	function new( string name = "env" , uvm_component parent);
		super.new(name , parent);
	endfunction

	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		agt1 = agent1::type_id::create("agt1" , this);
                agt2 = agent2::type_id::create("agt2" , this);
                vsqr = virtual_sequencer::type_id::create("vsqr" , this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vsqr.sqr1 = agt1.sqr1;
		vsqr.sqr2 = agt2.sqr2;
	endfunction

endclass


class test extends uvm_test;
       `uvm_component_utils(test)

  env e1;
  virtual_sequence vseq;

  function new(string name = "test" , uvm_component parent);
	super.new(name , parent);
endfunction


   function void build_phase(uvm_phase phase);
	   super.build_phase(phase);
	   e1 = env::type_id::create("e1" , this);
   endfunction

    task run_phase (uvm_phase phase);
	    super.run_phase(phase);
	    phase.raise_objection(this);
	    vseq = virtual_sequence::type_id::create("vseq" );
	    vseq.start(e1.vsqr);
	    phase.drop_objection(this);
    endtask
 endclass

module tb;
   initial begin
	   run_test("test");
   end
endmodule





  




