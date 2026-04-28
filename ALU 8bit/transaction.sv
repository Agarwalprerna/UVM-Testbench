
`include "uvm_macros.svh"
import uvm_pkg::*;


class transaction extends uvm_sequence_item;
	//contains necessary stimulus generation data members
	
	rand bit [3:0] A , B;
	rand bit [2:0] sel;
	rand bit rst;
	bit [7:0] result;

	function new(string name = "transaction" );
		super.new(name);
	endfunction

	`uvm_object_utils_begin(transaction)
	`uvm_field_int(A , UVM_ALL_ON)
	`uvm_field_int(B , UVM_ALL_ON)
	`uvm_field_int(sel , UVM_ALL_ON)
	`uvm_field_int(rst , UVM_ALL_ON)
        `uvm_field_int(result , UVM_ALL_ON)
        `uvm_object_utils_end


endclass

        

