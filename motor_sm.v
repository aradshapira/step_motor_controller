module motor_sm (clk,
					  nrst,
					  input_bit,
					  direction, 
					  step,
					  out);
					  
	// IO definition
	input wire clk;
	input wire nrst;
	input wire input_bit;
	input wire direction;
	input wire step;	// full step=1, half step=0
	output wire [3:0] out;
	
	// inner variables
	reg [3:0] cs;
	reg [3:0] ns;
	
	// parameters
	parameter A = 4'b1000,
				 AB = 4'b1010,
				 B = 4'b0010,
				 BC = 4'b0110,
				 C = 4'b0100,
				 CD = 4'b0101,
				 D = 4'b0001, 
				 DA = 4'b1001;

	// state machine 
	always @(posedge clk or negedge nrst)
	begin 
		if (~nrst)
			begin
			cs <= cs;
			end 
		else if (input_bit == 1'b1)
			begin 
				cs <= ns;
				
				case (cs)
					A: 
						if (direction == 1'b1 && step == 1'b1)
							ns = B;
						else if (direction == 1'b0 && step == 1'b1)
							ns = D;
						else if (direction == 1'b1 && step == 1'b0)
							ns = AB;
						else if (direction == 1'b0 && step == 1'b0)
							ns = DA;
					AB:
						if (direction == 1'b1 && step == 1'b0)
							ns = B;
						else if (direction == 1'b0 && step == 1'b0)
							ns = A;
					
					B:
						if (direction == 1'b1 && step == 1'b1)
							ns = C;
						else if (direction == 1'b0 && step == 1'b1)
							ns = A;
						else if (direction == 1'b1 && step == 1'b0)
							ns = BC;
						else if (direction == 1'b0 && step == 1'b0)
							ns = AB;
					
					BC:
						if (direction == 1'b1 && step == 1'b0)
							ns = C;
						else if (direction == 1'b0 && step == 1'b0)
							ns = B;
					
					C:
						if (direction == 1'b1 && step == 1'b1)
							ns = D;
						else if (direction == 1'b0 && step == 1'b1)
							ns = B;
						else if (direction == 1'b1 && step == 1'b0)
							ns = CD;
						else if (direction == 1'b0 && step == 1'b0)
							ns = BC;
					
					CD:
						if (direction == 1'b1 && step == 1'b0)
							ns = D;
						else if (direction == 1'b0 && step == 1'b0)
							ns = C;
					
					D:
						if (direction == 1'b1 && step == 1'b1)
							ns = A;
						else if (direction == 1'b0 && step == 1'b1)
							ns = C;
						else if (direction == 1'b1 && step == 1'b0)
							ns = DA;
						else if (direction == 1'b0 && step == 1'b0)
							ns = CD;
					
					DA:
						if (direction == 1'b1 && step == 1'b0)
							ns = A;
						else if (direction == 1'b0 && step == 1'b0)
							ns = D;
					default:
						ns = A;
				endcase
			end 
		end
 
	
assign out = cs;
	
endmodule