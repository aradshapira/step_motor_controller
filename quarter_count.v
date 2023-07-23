module quarter_count(
	// IO declaration 
	input wire clk,	//clk_for_motor
	input wire rst,
	input wire step,
	input wire en_edge,
	output reg quarter_out);
	
	// parameters: according to step size 
	parameter HS_COUNT = 8'd200;
	parameter FS_COUNT = 8'd100;
	
	// PARAMETERS FOR TEST
//	parameter HS_COUNT = 8'd4;
//	parameter FS_COUNT = 8'd8;
	
	// inner regs 
	reg [7:0] count;
	reg start_count;
	
	// counter logic 
	always @(posedge clk or negedge rst)
	begin 
		if (~rst) 
			begin 
				count <= 8'd0;
				quarter_out <= 1'b0;
			end
		else if (en_edge) // if enabled 
			begin 
				start_count <= en_edge;
			end 
		else if (start_count)
			begin 
				if (step == 1'b1)	// if in full step 
					begin 
						if (count >= FS_COUNT)
							begin 
								quarter_out <= 1'b0;
								start_count <= 1'b0;
								count <= 8'b0;
							end
						else
							begin 
								count <= count + 8'b1;
								quarter_out <= 1'b1;
							end
					end 
				else if (step == 1'b0)	// the same logic but if in half step
					begin 
						if (count >= HS_COUNT)
							begin 
								quarter_out <= 1'b0;
								start_count <= 1'b0;
								count <= 8'b0;
							end
						else
							begin 
								count <= count + 8'b1;
								quarter_out <= 1'b1;
							end 
					end 
			end
	end 

endmodule