`include "uvm_macros.svh"
import uvm_pkg::*;



class monitor extends uvm_monitor;
	virtual alu_inf vif;
	transaction tr;
	uvm_analysis_port #(transaction) mon_ap;

	`uvm_component_utils(monitor)

	function new(string name = "monitor" , uvm_component parent);
		super.new(name , parent);
		mon_ap = new("mon_ap" , this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(virtual alu_inf):: get(this , " " , "vif" , vif))
			`uvm_fatal(get_type_name() , "not set at top level");
	endfunction


	task run_phase(uvm_phase phase);
		forever begin
			@(posedge vif.clk);  //wait then afterwards do sampling
			tr= transaction::type_id::create("tr");
			tr.A = vif.A;
			tr.B = vif.B;
			tr.sel = vif.sel;
			@(posedge vif.clk);
			tr.result = vif.result;
			mon_ap.write(tr);
			`uvm_info(get_type_name() , $sformatf("A =%0b B=%0b sel=%0b rst=%0b-> result = %0b", tr.A , tr.B ,tr.sel , tr.rst , tr.result) , UVM_LOW)
		end
	endtask
	

endclass


