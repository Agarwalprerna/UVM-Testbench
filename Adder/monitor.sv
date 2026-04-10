`include "uvm_macros.svh"
import uvm_pkg::*;



class monitor extends uvm_monitor;
	virtual adder_inf vif;
	transaction tr;
	uvm_analysis_port #(transaction) mon_ap;

	`uvm_component_utils(monitor)

	function new(string name = "monitor" , uvm_component parent);
		super.new(name , parent);
		mon_ap = new("mon_ap" , this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(virtual adder_inf):: get(this , " " , "vif" , vif))
			`uvm_fatal(get_type_name() , "not set at top level");
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			#10;
			tr = transaction::type_id::create("tr");
			tr.a = vif.a;
			tr.b = vif.b;
			tr.sum = vif.sum;
			mon_ap.write(tr);
		end
	endtask
endclass


