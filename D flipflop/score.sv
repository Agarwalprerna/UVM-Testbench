`include "uvm_macros.svh"
import uvm_pkg::*;

class dff_scoreboard extends uvm_scoreboard;

	`uvm_component_utils(dff_scoreboard)
	int Total_txn;
        bit expected_Q;
	int pass_count , fail_count;
	bit prev_d;

	uvm_analysis_imp #(seq_item , dff_scoreboard) sbd_ap;

	function new(string name = "dff_scoreboard" , uvm_component parent);
		super.new(name , parent);
		sbd_ap = new("sbd_ap" , this);
		Total_txn = 0;
		pass_count = 0;
		fail_count = 0;
		prev_d =0;
	endfunction

	function void write(seq_item txn);
		Total_txn ++;
 
		if(txn.rst) begin
			expected_Q = 0;
		        prev_d =0;

		end else begin
			//expected_Q = txn.d;
		          expected_Q = prev_d;
		  end
			
		if (txn.Q == expected_Q) begin
			pass_count ++;
			`uvm_info(get_type_name() , $sformatf("Pass data rst = %d , D = %d , Q = %d " ,txn.rst , txn.d , txn.Q) , UVM_LOW )
		end
		else begin
			fail_count ++;
			`uvm_error(get_type_name() , $sformatf("failed data D = %d , Q = %d expected_Q = %d" , txn.d, txn.Q  , expected_Q))
		end

		prev_d = txn.d;
	endfunction

	function void report_phase(uvm_phase phase);
		`uvm_info(get_type_name() , $sformatf("total transaction = %d , pass_count = %d , fail_count = %d" , Total_txn , pass_count , fail_count) , UVM_LOW)
	endfunction

endclass


