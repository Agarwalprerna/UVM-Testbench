`include "uvm_macros.svh"
import uvm_pkg::*;



class dff_seq extends uvm_sequence #(seq_item);

	`uvm_object_utils(dff_seq)

	function new(string name = "dff_seq");
		super.new(name);
	endfunction


	task body();

		seq_item txn;
		`uvm_info( get_type_name() , "starting D fliflop sequence" , UVM_LOW)
		repeat(15) begin

	        	txn = seq_item::type_id::create("txn" );

                	start_item(txn);

	        	assert(txn.randomize());

	          	finish_item(txn);
		end
		
		`uvm_info(get_type_name() , $sformatf("generate txn %s" , txn.sprint() ) , UVM_LOW)
	endtask
endclass

