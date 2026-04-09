`include "uvm_macros.svh"
import uvm_pkg::*;

class JK_sequencer extends uvm_sequencer #(seq_item);
	`uvm_component_utils(JK_sequencer)

	function new(string name = "JK_sequencer" , uvm_component parent );
	    super.new(name , parent);
    endfunction
endclass

