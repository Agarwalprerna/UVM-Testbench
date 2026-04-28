`include "uvm_macros.svh"
import uvm_pkg::*;

class scoreboard extends uvm_scoreboard;

	uvm_analysis_imp #(transaction , scoreboard) sbd_ap;
	`uvm_component_utils(scoreboard)

	int pass_count , fail_count;
	bit [7:0] expectedOut;

	function new(string name = "scoreboard" , uvm_component parent);
		super.new(name , parent);
		sbd_ap= new("sbd_ap" , this);
	endfunction

	function void write(transaction tr);
		if(tr.rst==1)begin
			expectedOut = 8'h0;
		end else begin
		     case(tr.sel)
			3'b000: expectedOut = tr.A + tr.B;
                        3'b001: expectedOut = tr.A - tr.B;
                        3'b010: expectedOut = tr.A * tr.B;
                        3'b011: expectedOut = tr.A & tr.B;
                        3'b100: expectedOut = tr.A | tr.B;
                        3'b101: expectedOut = tr.A ^ tr.B;
                        3'b110: expectedOut = ~(tr.A | tr.B);
                        3'b111: expectedOut = (tr.A > tr.B)? 8'h1:8'h0; 
			default: expectedOut = 8'h0;
	        	endcase
		end

		//comparison
		if(expectedOut == tr.result)begin
			pass_count++;
			`uvm_info(get_type_name() , $sformatf("Pass opcode = %b A =%b B=%b ->ecpected = %0d actual result=%0d" , tr.sel , tr.A , tr.B ,expectedOut ,  tr.result) , UVM_LOW)
		end else begin
			fail_count ++ ;
			`uvm_error(get_type_name() , $sformatf("Fail opcode = %b A =%b B=%b ->actual result=%0d expected = %0d" , tr.sel , tr.A , tr.B , tr.result , expectedOut))
		end
	endfunction

	function void report_phase(uvm_phase phase);
		`uvm_info(get_type_name() , $sformatf("final report -> PASS = %0d FAIL=%0d" , pass_count , fail_count),UVM_NONE)
	endfunction

 endclass






