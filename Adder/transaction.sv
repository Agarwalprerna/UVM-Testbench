
`include "uvm_macros.svh"
import uvm_pkg::*;


class transaction extends uvm_sequence_item;
	//contains necessary stimulus generation data members
	
	rand bit [3:0] a ,b;
	//rand bit c;
	bit [4:0] sum;

//	constraint c1{  a < 100 ; b <50;}

         //object itself is a parent class so dont use parent argument only
	 //1argument
	function new(string name = "transaction");
		super.new(name);
	endfunction

           //use field macros so that when we call print method then all
	   //variables get displayed 
	`uvm_object_utils_begin(transaction)
	`uvm_field_int(a , UVM_ALL_ON)
	`uvm_field_int(b, UVM_ALL_ON)
	//`uvm_field_int(c, UVM_DEFAULT)
        `uvm_field_int(sum, UVM_ALL_ON)
        `uvm_object_utils_end

endclass

        

