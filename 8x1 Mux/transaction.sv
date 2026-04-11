
`include "uvm_macros.svh"
import uvm_pkg::*;


class transaction extends uvm_sequence_item;
	//contains necessary stimulus generation data members
	
	rand bit [7:0] in;
	rand bit [2:0] sel;
	bit y;

	function new(string name = "transaction" );
		super.new(name);
	endfunction

	`uvm_object_utils_begin(transaction)
	`uvm_field_int(in , UVM_ALL_ON)
	`uvm_field_int(sel , UVM_ALL_ON)
        `uvm_field_int(y , UVM_ALL_ON)
        `uvm_object_utils_end


endclass

        

