module step_motor_top(clk, resetb, direction, speed_sel, on, quarter, step_size, seven_seg_o, seven_seg_t, pulses_out);
	
	// IO declaration
	input wire clk;
	input wire resetb; 
	input wire direction;
	input wire step_size;
	input wire speed_sel;
	input wire quarter;
	input wire on;
	output wire [6:0] seven_seg_o;	// for 7 seg
	output wire [6:0] seven_seg_t;	// for 7 seg
	output wire [3:0] pulses_out; 	// signal for the driver 
	
	
	// inner regs
	wire clk_for_motor;
	wire [2:0] speed;
	wire [20:0] count_to;
	wire speed_enable;
	wire en_edge;
	wire quarter_out;
	wire motor_input_bit;
	
	// parameters
	parameter ZERO = 3'b000;
	
	
	//posedge detector for velocity changes 
	negedge_detector negedge_detector_inst1(.clk(clk), .rst(resetb), .sig(speed_sel), .out(speed_enable));
	
	//speed selector
	speed_selector speed_selector_inst(.clk(clk), .rst(resetb), .en(speed_enable), .speed_out(speed));
	
	//speed controller state machine 
	speed_controller_sm speed_controller_sm_inst(.rst(resetb), .step(step_size), .speed_sel(speed), .count_to(count_to));
	
	//clock divider 
	clk_divider clk_divider_inst(.clk(clk), .rst(resetb), .clk_out(clk_for_motor), .count_to(count_to));
	
	// negedge detector for quarter 
	negedge_detector negedge_detector_inst2(.clk(clk_for_motor), .rst(resetb), .sig(quarter), .out(en_edge));
	
	//quarter counter
	quarter_count quarter_count_inst(.clk(clk_for_motor), .rst(resetb), .step(step_size), .en_edge(en_edge), .quarter_out(quarter_out));
	 
	// OR gate to define whether the motor is in quarter state or in ON state 
	assign motor_input_bit = (on || quarter_out);
	
	//motor controller
	motor_sm motor_sm_inst(.clk(clk_for_motor), .nrst(resetb), .input_bit(motor_input_bit), .direction(direction), .step(step_size), .out(pulses_out));	
	
	//seven segment display output for ones 
	seven_segment seven_segment_inst_ones(.number_in(ZERO), .hex_out(seven_seg_o));
	
	//seven segment display output for tens 
	seven_segment seven_segment_inst_tens(.number_in(speed), .hex_out(seven_seg_t));
	
endmodule