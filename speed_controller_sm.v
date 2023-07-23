module speed_controller_sm(
	input wire rst,
	input wire step,
	input wire [2:0] speed_sel,
	output reg [20:0] count_to
);



// all the values must be *4 but in reality we got the right speed values by dividing by 4


// REAL VALUES 
parameter full_10rpm =21'd375000;	// 1500000
parameter full_20rpm =21'd187500;	// 750000
parameter full_30rpm =21'd125000;	// 500000
parameter full_40rpm =21'd93750;	// 375000
parameter full_50rpm =21'd75000;	// 300000
parameter full_60rpm =21'd62500;	// 250000
parameter half_10rpm =21'd187500;	// 750000
parameter half_20rpm =21'd93750;	// 375000
parameter half_30rpm =21'd62500;	// 250000
parameter half_40rpm =21'd46750;	//	187500
parameter half_50rpm =21'd37500;	//	150000
parameter half_60rpm =21'd31250;	// 125000


// VALUES FOR WAVEFORM TEST
//parameter full_10rpm =21'd1;	
//parameter full_20rpm =21'd2;	
//parameter full_30rpm =21'd3;	
//parameter full_40rpm =21'd4;	
//parameter full_50rpm =21'd5;	
//parameter full_60rpm =21'd6;	
//parameter half_10rpm =21'd7;	
//parameter half_20rpm =21'd8;	
//parameter half_30rpm =21'd9;	
//parameter half_40rpm =21'd10;	
//parameter half_50rpm =21'd11;	
//parameter half_60rpm =21'd12;	

// logic 
always @(*)
begin 	
			if (~rst)
				count_to <= full_10rpm;
			if ((speed_sel == 3'b001) && (step))
				count_to <= full_10rpm;
				
			else if ((speed_sel == 3'b001) && (~step))
				count_to <= half_10rpm;
				
			else if ((speed_sel == 3'b010) && (step))
				count_to <= full_20rpm;
				
			else if ((speed_sel == 3'b010) && (~step))
				count_to <= half_20rpm;
				
			else if ((speed_sel == 3'b011) && (step))
				count_to <= full_30rpm;
				
			else if ((speed_sel == 3'b011) && (~step))
				count_to <= half_30rpm;
				
			else if ((speed_sel == 3'b100) && (step))
				count_to <= full_40rpm;
				
			else if ((speed_sel == 3'b100) && (~step))
				count_to <= half_40rpm;
				
			else if ((speed_sel == 3'b101) && (step))
				count_to <= full_50rpm;
				
			else if ((speed_sel == 3'b101) && (~step))
				count_to <= half_50rpm;
				
			else if ((speed_sel == 3'b110) && (step))
				count_to <= full_60rpm;
				
			else if ((speed_sel == 3'b110) && (~step))
				count_to <= half_60rpm;
			else
				count_to <= full_10rpm;
end 


endmodule


