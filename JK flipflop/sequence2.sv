`include "uvm_macros.svh"
import uvm_pkg::*;


//this class is used for reset randomization (should be rst = 0) J,K is not
//aimed to randomize
class rst_check extends uvm_sequence #(seq_item);
	`uvm_object_utils(rst_check)

	function new(string name = "rst_check");
		super.new(name);
	endfunction

	task body();
		seq_item txn;
		repeat(10)begin
			txn= seq_item::type_id::create("txn");
			start_item(txn);
			if(!(txn.randomize() with {rst ==0;} )) begin
				`uvm_fatal(get_type_name() , "trans not randomized")
			end
			finish_item(txn);
			txn.print();
		end
	endtask
endclass

