`include "uvm_macros.svh"
import uvm_pkg::*;


class sequence1 extends uvm_sequence #(transaction);

	//create randomized stimulus and drives them to driver via sequencer

	transaction tr;
      `uvm_object_utils(sequence1)

      function new(string name = "sequence1" );
	      super.new(name);
      endfunction

      task body();
	      `uvm_info(get_type_name() , "inside sequence body task ", UVM_LOW)
	      tr = transaction::type_id::create("tr");
	      repeat(6) begin
		      wait_for_grant();
		      assert(tr.randomize());
		      send_request(tr);
		      wait_for_item_done();
		      tr.print();
	      end
      endtask
endclass





