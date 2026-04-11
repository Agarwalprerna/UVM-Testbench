`include "uvm_macros.svh"
import uvm_pkg::*;
//`include "transaction.sv"

class scoreboard extends uvm_scoreboard;

	uvm_analysis_imp #(transaction , scoreboard) sbd_ap;
	`uvm_component_utils(scoreboard)

	int pass_count , fail_count;
	bit expectedOut;

	function new(string name = "scoreboard" , uvm_component parent);
		super.new(name , parent);
		sbd_ap= new("sbd_ap" , this);
	endfunction

	function void write(transaction tr);

		//expected logic
		expectedOut = tr.in[tr.sel];

		//comapre
		if(tr.y === expectedOut)begin
			pass_count++;
			`uvm_info("SCOREBOARD" , $sformatf("PASS: sel = %0b in= %0d y = %0b" , tr.sel , tr.in , tr.y), UVM_LOW)
		end else begin
			fail_count ++;
			`uvm_error(get_type_name() , $sformatf("FAIL: sel = %0b in= %0d actual = %0b expected = %0b" , tr.sel , tr.in , tr.y , expectedOut))
		end
	endfunction

 endclass






