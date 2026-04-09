`include "uvm_macros.svh"
import uvm_pkg::*;



class JK_seq extends uvm_sequence #(seq_item);

	`uvm_object_utils(JK_seq)

	function new(string name = "JK_seq");
		super.new(name);
	endfunction


	task body();

		seq_item txn;
		`uvm_info( get_type_name() , "starting JK fliflop sequence" , UVM_LOW)
		repeat(10) begin

	        	txn = seq_item::type_id::create("txn" );

                	start_item(txn);
			if( !txn.randomize() with {rst == 1;}) begin
				`uvm_fatal( get_type_name() , "transaction not randomized")
			end

	          	finish_item(txn);
		
		        txn.print() ; //print all field macros in seq_item
		//`uvm_info(get_type_name() , $sformatf("generate txn %s" , txn.sprint() ) , UVM_LOW)
          	end
	endtask
endclass

