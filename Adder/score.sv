`include "uvm_macros.svh"
import uvm_pkg::*;
//`include "transaction.sv"

class scoreboard extends uvm_scoreboard;

	uvm_analysis_imp #(transaction , scoreboard) sbd_ap;
	`uvm_component_utils(scoreboard)

	function new(string name = "scoreboard" , uvm_component parent);
		super.new(name , parent);
		sbd_ap= new("sbd_ap" , this);
	endfunction

	function void write( transaction tr);
		if(tr.sum == (tr.a + tr.b)) begin
			`uvm_info(get_type_name() , "PASS" , UVM_LOW)
		end
		else begin
                         `uvm_info(get_type_name() , "FAIL" , UVM_LOW)
		 end
	 endfunction
 endclass






