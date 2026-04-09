module RTL(input logic clk ,rst , J , K , output reg Q );

  always @(posedge clk or negedge rst) begin
	  if(!rst)
		  Q <=0;
	  else begin
		  case( {J,K})
			  2'b00 : Q<= Q;//hold
			  2'b01: Q<= 0;
			  2'b10: Q <=1;
			  2'b11: Q<= ~Q;
		  endcase
	  end
  end

 endmodule

