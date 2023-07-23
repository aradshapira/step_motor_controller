module speed_selector(
	// IO declaration 
	input wire clk,
	input wire rst,
	input wire en,
	output wire [2:0] speed_out);

// inner regs 
reg [2:0] cs;
reg [2:0] ns;
reg flag;

// parameters: states that are passed to motor 
parameter state10 = 3'b001;
parameter state20 = 3'b010;
parameter state30 = 3'b011;
parameter state40 = 3'b100;
parameter state50 = 3'b101;
parameter state60 = 3'b110;


// update current state to the next state logic 
always @(posedge clk or negedge rst)
begin 
	if (~rst)
		begin 
			cs <= state10;
			flag <= 1'b0;
		end 
	else if (en)
		begin 
			cs <= ns;
			if ((cs == state10) | (cs == state60))
				flag <= (~flag);	// change the flag when at 10/60 rpm to go to the opposite side 
		end 
end 

// state machine 
always @(*)
	begin
		case (cs)
			state10: ns = state20;
			state20: ns = (flag) ? state30 : state10;
			state30:	ns = (flag) ? state40 : state20;
			state40:	ns = (flag) ? state50 : state30;
			state50:	ns = (flag) ? state60 : state40;
			state60:	ns = state50;
			default: ns = state10;
		endcase
	end 
	
assign speed_out = cs;

endmodule