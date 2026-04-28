interface alu_inf(input logic clk );
	logic [2:0] sel;
	logic [3:0] A;
	logic [3:0] B;
	logic [7:0] result;
	logic rst;

	clocking drv_cb @(posedge clk);
		default input #1step output #0;
		input result;
		output sel , A ,B ,rst ;
	endclocking 

        clocking mon_cb @(posedge clk);
		default input #1step output #0;
		input result;
		input sel , A ,B ,rst ;
	endclocking 




endinterface

