module RTL(input clk ,rst, d , output reg Q);

   always_ff @(posedge clk) begin
	   if(rst)
		   Q <= 0;
	   else
		   Q<=d;
   end
   endmodule

