`include "uvm_macros.svh"
import uvm_pkg::*;
//`include "sequence.sv"

class dff_monitor extends uvm_monitor;
	`uvm_component_utils(dff_monitor)
         
        seq_item txn;

	virtual intf vif;
	uvm_analysis_port #(seq_item) mon_ap;

	function new(string name = "dff_monitor" , uvm_component parent);
		super.new(name , parent);
		mon_ap = new("mon_ap" , this);
	endfunction

       function void build_phase(uvm_phase phase);
	       super.build_phase(phase);
	       if(!(uvm_config_db #(virtual intf)::get(this , "" , "vif" , vif)))
		       `uvm_fatal(get_type_name() , "not retreiving virtual interface from config_db")
       endfunction

       task run_phase(uvm_phase phase);
	      

	       forever begin
		       @(posedge vif.clk);
		       txn = seq_item::type_id::create("txn" , this);
		       txn.d = vif.d;
		       txn.rst = vif.rst;
		       txn.Q = vif.Q;


		       mon_ap.write(txn);
		       `uvm_info(get_type_name() , $sformatf("monitor received data D = %d rst = %d , Q = %d" , txn.d ,txn.rst, txn.Q) , UVM_LOW)
	       end
       endtask
 endclass



