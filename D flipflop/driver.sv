`include "uvm_macros.svh"

import uvm_pkg::*;

class dff_driver extends uvm_driver #(seq_item);
	`uvm_component_utils(dff_driver)
	virtual intf vif;

	function new(string name = "dff_driver" , uvm_component parent );
	    super.new(name , parent);
    endfunction

    function void build_phase(uvm_phase phase);
	    if( !(uvm_config_db #(virtual intf)::get(this , "" , "vif" , vif)))
		    `uvm_fatal( get_type_name() , "virtual interface is not recieved")
	    super.build_phase(phase);
    endfunction

              task run_phase(uvm_phase phase);

		      seq_item txn;
		      forever begin
			      seq_item_port.get_next_item(txn);
			      vif.d <= txn.d;  //drive DUT using virtual interface 
			      vif.rst <= txn.rst;
			      seq_item_port.item_done();

			      `uvm_info(get_type_name() , $sformatf("driver driven D = %d rst = %d" , txn.d , txn.rst) , UVM_LOW)
		      end
	      endtask

endclass

