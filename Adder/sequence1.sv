`include "uvm_macros.svh"
import uvm_pkg::*;


class sequence1 extends uvm_sequence #(transaction);

	//create randomized stimulus and drives them to driver via sequencer

	transaction tr;  

	`uvm_object_utils(sequence1)

	function new(string name ="sequence1");
		super.new(name);
	endfunction

	//stimulus generation process
	task body();
		`uvm_info(get_type_name() , "inside sequence task body" , UVM_LOW)
	//	tr = transaction::type_id::create("tr");
	     repeat(10) begin
		     `uvm_do(tr);
		     tr.print();
	     end
     endtask
 endclass



