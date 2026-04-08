`include "uvm_macros.svh"

import uvm_pkg::*;

class dff_sequencer extends uvm_sequencer #(seq_item);
	`uvm_component_utils(dff_sequencer)

	function new(string name = "dff_sequencer" , uvm_component parent );
	    super.new(name , parent);
    endfunction
endclass

