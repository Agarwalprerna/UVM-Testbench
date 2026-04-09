`include "uvm_macros.svh"
import uvm_pkg::*;

class JK_scoreboard extends uvm_scoreboard;

	`uvm_component_utils(JK_scoreboard)
         bit expected_Q;
	uvm_analysis_imp #(seq_item , JK_scoreboard) sbd_ap;

	function new(string name = "JK_scoreboard" , uvm_component parent);
		super.new(name , parent);
		sbd_ap = new("sbd_ap" , this);
	endfunction


	function void write( seq_item txn);
		if(txn.rst == 1'b0)begin  //active low 
			expected_Q = 0;
			`uvm_info(get_type_name() , "reset check passed" , UVM_LOW)
		end
		else if (txn.rst == 1'b1) begin
			case( {txn.J , txn.K})
				2'b00: expected_Q = expected_Q;
				2'b01 :expected_Q = 0;
			        2'b10: expected_Q = 1;
			        2'b11 : expected_Q = ~expected_Q;
			endcase
		
			if(txn.Q == expected_Q) begin
			   `uvm_info(get_type_name() , $sformatf("PASS : Q=%0b when J = %0d K = %0d" ,txn.Q , txn.J , txn.K ) , UVM_LOW)
		       end
	       end
       endfunction
endclass


		
