module seven_segment(number_in, hex_out);

	// in/out declaration 
	input wire [2:0] number_in;
	output wire [6:0] hex_out;
	
	// inner reg declaration 
	reg [6:0] hex;
	
	// logic 
	always @(*)
		begin
			case(number_in)			
					3'b000: hex = 7'b1000000;	// number = 0
					3'b001: hex = 7'b1111001;	// number = 1
					3'b010: hex = 7'b0100100;	// number = 2
					3'b011: hex = 7'b0110000;	// number = 3
					3'b100: hex = 7'b0011001;	// number = 4
					3'b101: hex = 7'b0010010;	// number = 5
					3'b110: hex = 7'b0000010;	// number = 6
			
			endcase
		end
	
	assign hex_out = hex;

endmodule