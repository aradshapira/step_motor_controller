module negedge_detector(
	// Io declaration 
	input wire clk,
	input wire rst,
	input wire sig,
	output wire out);
	
	// inner reg 
	reg [1:0] sig_del; 
	
	// logic as in posedge detector 
	always @(posedge clk or negedge rst)
	begin 
		if (~rst) begin 
			sig_del <= 2'b11;
		end else begin 
			sig_del <= {sig_del[0], sig};
		end
	end 

assign out = ((~sig_del[0]) & (sig_del[1]));	
	
endmodule


