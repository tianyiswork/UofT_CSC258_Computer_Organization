module part6(
//    Clock Input
  input CLOCK_50,    //    50 MHz
  input CLOCK_27,     //      27 MHz
//    Push Button
  input [3:0] KEY,      //    Pushbutton[3:0]
//    DPDT Switch
  input [17:0] SW,        //    Toggle Switch[17:0]
//    7-SEG Display
  output [6:0]    HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7,  // Seven Segment Digits
//    LED
  output [8:0]    LEDG,  //    LED Green[8:0]
  output [17:0] LEDR,  //    LED Red[17:0]
//    GPIO
 inout [35:0] GPIO_0,GPIO_1,    //    GPIO Connections
//    TV Decoder
//TD_DATA,        //    TV Decoder Data bus 8 bits
//TD_HS,        //    TV Decoder H_SYNC
//TD_VS,        //    TV Decoder V_SYNC
  output TD_RESET,    //    TV Decoder Reset
// VGA
  output VGA_CLK,                           //    VGA Clock
  output VGA_HS,                            //    VGA H_SYNC
  output VGA_VS,                            //    VGA V_SYNC
  output VGA_BLANK,                        //    VGA BLANK
  output VGA_SYNC,                        //    VGA SYNC
  output [9:0] VGA_R,                           //    VGA Red[9:0]
  output [9:0] VGA_G,                             //    VGA Green[9:0]
  output [9:0] VGA_B                           //    VGA Blue[9:0]
);

	//    All inout port turn to tri-state
	assign    GPIO_0        =    36'hzzzzzzzzz;
	assign    GPIO_1        =    36'hzzzzzzzzz;

	// reset delay gives some time for peripherals to initialize
	wire DLY_RST;
	Reset_Delay r0(    .iCLK(CLOCK_50),.oRESET(DLY_RST) );
	wire RST_N = DLY_RST&KEY[0];

	// Send switches to red leds 
	assign LEDR = SW;

	// Turn off green leds
	assign LEDG = 8'h00;

	wire [6:0] blank = 7'b111_1111;

	// blank unused 7-segment digits
	assign HEX0 = blank;
	assign HEX1 = blank;
	assign HEX2 = blank;
	assign HEX3 = blank;
	assign HEX4 = blank;
	assign HEX5 = blank;
	assign HEX6 = blank;
	assign HEX7 = blank;

	wire        VGA_CTRL_CLK;
	wire        AUD_CTRL_CLK;
	wire [29:0]    mVGA_RGB;
	wire [9:0]    mCoord_X;
	wire [9:0]    mCoord_Y;

	assign    TD_RESET = 1'b1; // Enable 27 MHz

	VGA_Audio_PLL     p1 (    
		 .areset(~DLY_RST),
		 .inclk0(CLOCK_27),
		 .c0(VGA_CTRL_CLK),
		 .c1(AUD_CTRL_CLK),
		 .c2(VGA_CLK)
	);

	wire [29:0] rgb1, rgb2;

	bars c1(mCoord_X, mCoord_Y, rgb1);
	grayscale c2(mCoord_X, mCoord_Y, rgb2);
		 
	wire s = SW[0];
	assign mVGA_RGB = (s? rgb2: rgb1);

	vga_sync u1(
		.iCLK(VGA_CTRL_CLK),
		.iRST_N(RST_N),    
		.iRGB(mVGA_RGB),
		// pixel coordinates
		.px(mCoord_X),
		.py(mCoord_Y),
		// VGA Side
		.VGA_R(VGA_R),
		.VGA_G(VGA_G),
		.VGA_B(VGA_B),
		.VGA_H_SYNC(VGA_HS),
		.VGA_V_SYNC(VGA_VS),
		.VGA_SYNC(VGA_SYNC),
		.VGA_BLANK(VGA_BLANK)
	);
	endmodule

	module    Reset_Delay(iCLK,oRESET);
		input        iCLK;
		output reg    oRESET;
		reg    [19:0]    Cont;

		always@(posedge iCLK)
		begin
			 if(Cont!=20'hFFFFF)
			 begin
				  Cont    <=    Cont+1'b1;
				  oRESET    <=    1'b0;
			 end
			 else
			 oRESET    <=    1'b1;
		end

	endmodule

	// megafunction wizard: %ALTPLL%
	// GENERATION: STANDARD
	// VERSION: WM1.0
	// MODULE: altpll 

	// ============================================================
	// File Name: VGA_Audio_PLL.v
	// Megafunction Name(s):
	//             altpll
	//
	// Simulation Library Files(s):
	//             altera_mf
	// ============================================================
	// ************************************************************
	// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
	//
	// 7.2 Build 175 11/20/2007 SP 1 SJ Web Edition
	// ************************************************************


	//Copyright (C) 1991-2007 Altera Corporation
	//Your use of Altera Corporation's design tools, logic functions 
	//and other software and tools, and its AMPP partner logic 
	//functions, and any output files from any of the foregoing 
	//(including device programming or simulation files), and any 
	//associated documentation or information are expressly subject 
	//to the terms and conditions of the Altera Program License 
	//Subscription Agreement, Altera MegaCore Function License 
	//Agreement, or other applicable license agreement, including, 
	//without limitation, that your use is for the sole purpose of 
	//programming logic devices manufactured by Altera and sold by 
	//Altera or its authorized distributors.  Please refer to the 
	//applicable agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module VGA_Audio_PLL (
    areset,
    inclk0,
    c0,
    c1,
    c2);

    input      areset;
    input      inclk0;
    output      c0;
    output      c1;
    output      c2;

    wire [5:0] sub_wire0;
    wire [0:0] sub_wire6 = 1'h0;
    wire [2:2] sub_wire3 = sub_wire0[2:2];
    wire [1:1] sub_wire2 = sub_wire0[1:1];
    wire [0:0] sub_wire1 = sub_wire0[0:0];
    wire  c0 = sub_wire1;
    wire  c1 = sub_wire2;
    wire  c2 = sub_wire3;
    wire  sub_wire4 = inclk0;
    wire [1:0] sub_wire5 = {sub_wire6, sub_wire4};

    altpll    altpll_component (
                .inclk (sub_wire5),
                .areset (areset),
                .clk (sub_wire0),
                .activeclock (),
                .clkbad (),
                .clkena ({6{1'b1}}),
                .clkloss (),
                .clkswitch (1'b0),
                .configupdate (1'b0),
                .enable0 (),
                .enable1 (),
                .extclk (),
                .extclkena ({4{1'b1}}),
                .fbin (1'b1),
                .fbmimicbidir (),
                .fbout (),
                .locked (),
                .pfdena (1'b1),
                .phasecounterselect ({4{1'b1}}),
                .phasedone (),
                .phasestep (1'b1),
                .phaseupdown (1'b1),
                .pllena (1'b1),
                .scanaclr (1'b0),
                .scanclk (1'b0),
                .scanclkena (1'b1),
                .scandata (1'b0),
                .scandataout (),
                .scandone (),
                .scanread (1'b0),
                .scanwrite (1'b0),
                .sclkout0 (),
                .sclkout1 (),
                .vcooverrange (),
                .vcounderrange ());
    defparam
        altpll_component.clk0_divide_by = 15,
        altpll_component.clk0_duty_cycle = 50,
        altpll_component.clk0_multiply_by = 14,
        altpll_component.clk0_phase_shift = "0",
        altpll_component.clk1_divide_by = 3,
        altpll_component.clk1_duty_cycle = 50,
        altpll_component.clk1_multiply_by = 2,
        altpll_component.clk1_phase_shift = "0",
        altpll_component.clk2_divide_by = 15,
        altpll_component.clk2_duty_cycle = 50,
        altpll_component.clk2_multiply_by = 14,
        altpll_component.clk2_phase_shift = "-9921",
        altpll_component.compensate_clock = "CLK0",
        altpll_component.inclk0_input_frequency = 37037,
        altpll_component.intended_device_family = "Cyclone II",
        altpll_component.lpm_type = "altpll",
        altpll_component.operation_mode = "NORMAL",
        altpll_component.port_activeclock = "PORT_UNUSED",
        altpll_component.port_areset = "PORT_USED",
        altpll_component.port_clkbad0 = "PORT_UNUSED",
        altpll_component.port_clkbad1 = "PORT_UNUSED",
        altpll_component.port_clkloss = "PORT_UNUSED",
        altpll_component.port_clkswitch = "PORT_UNUSED",
        altpll_component.port_configupdate = "PORT_UNUSED",
        altpll_component.port_fbin = "PORT_UNUSED",
        altpll_component.port_inclk0 = "PORT_USED",
        altpll_component.port_inclk1 = "PORT_UNUSED",
        altpll_component.port_locked = "PORT_UNUSED",
        altpll_component.port_pfdena = "PORT_UNUSED",
        altpll_component.port_phasecounterselect = "PORT_UNUSED",
        altpll_component.port_phasedone = "PORT_UNUSED",
        altpll_component.port_phasestep = "PORT_UNUSED",
        altpll_component.port_phaseupdown = "PORT_UNUSED",
        altpll_component.port_pllena = "PORT_UNUSED",
        altpll_component.port_scanaclr = "PORT_UNUSED",
        altpll_component.port_scanclk = "PORT_UNUSED",
        altpll_component.port_scanclkena = "PORT_UNUSED",
        altpll_component.port_scandata = "PORT_UNUSED",
        altpll_component.port_scandataout = "PORT_UNUSED",
        altpll_component.port_scandone = "PORT_UNUSED",
        altpll_component.port_scanread = "PORT_UNUSED",
        altpll_component.port_scanwrite = "PORT_UNUSED",
        altpll_component.port_clk0 = "PORT_USED",
        altpll_component.port_clk1 = "PORT_USED",
        altpll_component.port_clk2 = "PORT_USED",
        altpll_component.port_clk3 = "PORT_UNUSED",
        altpll_component.port_clk4 = "PORT_UNUSED",
        altpll_component.port_clk5 = "PORT_UNUSED",
        altpll_component.port_clkena0 = "PORT_UNUSED",
        altpll_component.port_clkena1 = "PORT_UNUSED",
        altpll_component.port_clkena2 = "PORT_UNUSED",
        altpll_component.port_clkena3 = "PORT_UNUSED",
        altpll_component.port_clkena4 = "PORT_UNUSED",
        altpll_component.port_clkena5 = "PORT_UNUSED",
        altpll_component.port_extclk0 = "PORT_UNUSED",
        altpll_component.port_extclk1 = "PORT_UNUSED",
        altpll_component.port_extclk2 = "PORT_UNUSED",
        altpll_component.port_extclk3 = "PORT_UNUSED";


endmodule

module vga_sync(
   input iCLK, // 25 MHz clock
   input iRST_N,
   input [29:0] iRGB,
   // pixel coordinates
   output [9:0] px,
   output [9:0] py,
   // VGA Side
   output  [9:0] VGA_R,
   output  [9:0] VGA_G,
   output  [9:0] VGA_B,
   output reg VGA_H_SYNC,
   output reg VGA_V_SYNC,
   output VGA_SYNC,
   output VGA_BLANK
);

	assign    VGA_BLANK    =    VGA_H_SYNC & VGA_V_SYNC;
	assign    VGA_SYNC    =    1'b0;

	reg [9:0] h_count, v_count;
	assign px = h_count;
	assign py = v_count;

	// iRed = iRGB[29:20]; iGreen = iRGB[19:10]; iBlue = iRGB[9:0]


	// Horizontal sync

	/* Generate Horizontal and Vertical Timing Signals for Video Signal
	* h_count counts pixels (640 + extra time for sync signals)
	* 
	*  horiz_sync  ------------------------------------__________--------
	*  h_count       0                640             659       755    799
	*/
	parameter H_SYNC_TOTAL = 800;
	parameter H_PIXELS =     640;
	parameter H_SYNC_START = 659;
	parameter H_SYNC_WIDTH =  96;

	always@(posedge iCLK or negedge iRST_N)
	begin
		if(!iRST_N)
		begin
			h_count <= 10'h000;
			VGA_H_SYNC <= 1'b0;
		end
		else
		begin
			// H_Sync Counter
			if (h_count < H_SYNC_TOTAL-1) h_count <= h_count + 1'b1;
			else h_count <= 10'h0000;

			if (h_count >= H_SYNC_START && 
		 h_count < H_SYNC_START+H_SYNC_WIDTH) VGA_H_SYNC = 1'b0;
			else VGA_H_SYNC <= 1'b1;
		end
	end
	/*  
	*  vertical_sync      -----------------------------------------------_______------------
	*  v_count             0                                      480    493-494          524
	*/
	parameter V_SYNC_TOTAL = 525;
	parameter V_PIXELS     = 480;
	parameter V_SYNC_START = 493;
	parameter V_SYNC_WIDTH =   2;
	parameter H_START = 699;

	always @(posedge iCLK or negedge iRST_N)
	begin
		if (!iRST_N)
		begin
			v_count <= 10'h0000;
			VGA_V_SYNC <= 1'b0;
		end
		else if (h_count == H_START)
		begin
			// V_Sync Counter
			if (v_count < V_SYNC_TOTAL-1) v_count <= v_count + 1'b1;
			else v_count <= 10'h0000;

			if (v_count >= V_SYNC_START && 
			  v_count < V_SYNC_START+V_SYNC_WIDTH) VGA_V_SYNC = 1'b0;
			else VGA_V_SYNC <= 1'b1;
		end
	end
		

	wire video_h_on = (h_count<H_PIXELS);
	wire video_v_on = (v_count<V_PIXELS);
	wire video_on = video_h_on & video_v_on;

	assign VGA_R = (video_on? iRGB[29:20]: 10'h000);
	assign VGA_G = (video_on? iRGB[19:10]: 10'h000);
	assign VGA_B = (video_on? iRGB[9:0]: 10'h000);
   
endmodule

module grayscale(input [9:0] px, input [9:0] py, output [29:0] rgb);

	wire [9:0] gray = (px<80 || px>560? 10'h000:
		 (py/15)<<5 | (px-80)/15);
	assign rgb = {gray, gray, gray};

endmodule

module bars(input [9:0] x, input [9:0] y, output [29:0] rgb);
	reg [2:0] idx; 
	always @(x)
	begin
//		 if ((x < 260) & (y > 360)) idx <= 3'd1;
//		 else if ((y < 260) & (x> 360)) idx <= 3'd5;
//		 else if ((y < 260) & (x< 360)) idx <= 3'd5;
//		 else if ((y > 260) & (x> 360)) idx <= 3'd5;
		 if ((x < 80)&((y < 160)|(y > 260))) idx <= 3'd0;
		 else if ((x < 160)&~((y < 160)|(y > 260))) idx <= 3'd1;
		 else if ((x < 240)&~((y < 160)|(y > 260))) idx <= 3'd1;
		 else if ((x < 320)&~((y < 160)|(y > 260))) idx <= 3'd1;
		 else if ((x < 400)&~((y < 160)|(y > 260))) idx <= 3'd1;
		 else if ((x < 480)&~((y < 160)|(y > 260))) idx <= 3'd1;
		 else if ((x < 560)&~((y < 160)|(y > 260))) idx <= 3'd1;
		 else idx <= 3'd0;

	end
	assign rgb[29:20] = (idx[0]? 10'h3ff: 10'h000);
	assign rgb[19:10] = (idx[1]? 10'h3ff: 10'h000);
	assign rgb[9:0] = (idx[2]? 10'h3ff: 10'h000);

endmodule
