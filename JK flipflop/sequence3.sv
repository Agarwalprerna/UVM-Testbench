`include "uvm_macros.svh"
import uvm_pkg::*;

//now J,K , rst all are randomizing

class random_check extends uvm_sequence #(seq_item);
	`uvm_object_utils(random_check)

	function new(string name = "random_check");
		super.new(name);
	endfunction

	task body();
		seq_item txn;
		repeat(10)begin
			txn= seq_item::type_id::create("txn");
			start_item(txn);
			if(!txn.randomize()) begin
				`uvm_fatal(get_type_name() , "trans not randomized")
			end
			finish_item(txn);
			txn.print();
		end
	endtask
endclass

