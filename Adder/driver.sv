
`include "uvm_macros.svh"
import uvm_pkg::*;


class driver extends uvm_driver #(transaction);
	transaction req;

	virtual adder_inf vif;
	 
	`uvm_component_utils(driver)

	function new(string name = "driver" , uvm_component parent);
	  super.new(name , parent);
  endfunction

  function void build_phase(uvm_phase phase);
	  super.build_phase(phase);
	  if (!uvm_config_db #(virtual adder_inf)::get(this, "" , "vif" ,vif))begin
		  `uvm_fatal( get_type_name(), "not getting virtual interface" )
	  end
  endfunction

  task run_phase(uvm_phase phase);
	  forever begin
		  //driver to DUT
		  seq_item_port.get_next_item(req);//driver is looking for data 
		  send_to_dut(req);
		  seq_item_port.item_done();  //indicates driver has sent to data interface 
	  end
  endtask

  task send_to_dut( transaction req);
          vif.a <= req.a;
	  vif.b <= req.b;
	  #10;   // Adder doesn't have clock so adding some delay 
	  `uvm_info(get_type_name() , $sformatf("a = %0d , b= %0d " , req.a , req.b ) , UVM_LOW);
  endtask



  endclass

	  
