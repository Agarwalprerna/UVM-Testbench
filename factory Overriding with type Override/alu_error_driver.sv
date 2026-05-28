
class alu_error_driver extends driver;   //extends from alu driver
	`uvm_component_utils(alu_error_driver)

	function new(string name = "alu_error_driver" , uvm_component parent);
		super.new(name , parent);
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);

			//intentional error
			vif.A <= req.A + 1;
			vif.B <= req.B;
			vif.sel <= req.sel;
			vif.rst <= req.rst;
			
			`uvm_info("ERR_DRV" , $sformatf("error driver A = %0d B =%0d Sel=%0d" , req.A , req.B , req.sel) , UVM_NONE)

			seq_item_port.item_done();
		end
	endtask
endclass


