module RTL ( input logic clk , logic rst , input logic [3:0] A , B ,input logic [2:0] sel, output logic [7:0] result);

  // logic [7:0] result;  //for synchronous 

   always_ff @(posedge clk) begin
	   if(rst) 
		   result <= 8'h0;
	   else begin
		   case(sel)
			   3'b000: result = A + B; 
		           3'b001: result = A-B;
			   3'b010: result = A *B;
                           3'b011: result = A & B;
                           3'b100: result = A | B;
                           3'b101: result = A ^ B;
                           3'b110: result = ~(A |B);
                           3'b111: result = (A > B)? 8'd1:8'd0;
			   default: result = 8'b0;
		   endcase
		   //result <= result;
		   	 
	   end
   end
  endmodule

                          




