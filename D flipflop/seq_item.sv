`include "uvm_macros.svh"
import uvm_pkg::*;

class seq_item extends uvm_sequence_item;
	rand bit d;
	rand bit rst;
	bit Q;

	constraint c1{
		d dist { 1:/60 , 0:/ 40};
		rst dist {1:/30 , 0:/70};
		}

	`uvm_object_utils_begin(seq_item)
	`uvm_field_int(d , UVM_ALL_ON)
        `uvm_field_int(rst , UVM_ALL_ON)
         `uvm_field_int(Q , UVM_ALL_ON)
	 `uvm_object_utils_end



	function new(string name = "seq_item");
		super.new(name);
	endfunction

endclass

