module Booth_multiplier_pipeline#(
	parameter DATAWIDTH = 8
)
(
	input                            CLK,
	input                            RSTn,
	input [ DATAWIDTH - 1 : 0 ]      A,
	input [ DATAWIDTH - 1 : 0 ]      B,
	
	output [ DATAWIDTH * 2 - 1 : 0 ] RESULT
);


wire [ DATAWIDTH * 2 : 0 ] P = { 8'b0, B, 1'b0 };
wire [ DATAWIDTH * 2 - 1 : 0] M = { ~A+1'b1, A};

wire [ DATAWIDTH * 2 : 0 ]    P1;
wire [ DATAWIDTH * 2 - 1 : 0] M1;
wire [ DATAWIDTH * 2 : 0 ]    P2;
wire [ DATAWIDTH * 2 - 1 : 0] M2;
wire [ DATAWIDTH * 2 : 0 ]    P3;
wire [ DATAWIDTH * 2 - 1 : 0] M3;
wire [ DATAWIDTH * 2 : 0 ]    P4;
wire [ DATAWIDTH * 2 - 1 : 0] M4;
wire [ DATAWIDTH * 2 : 0 ]    P5;
wire [ DATAWIDTH * 2 - 1 : 0] M5;
wire [ DATAWIDTH * 2 : 0 ]    P6;
wire [ DATAWIDTH * 2 - 1 : 0] M6;
wire [ DATAWIDTH * 2 : 0 ]    P7;
wire [ DATAWIDTH * 2 - 1 : 0] M7;
wire [ DATAWIDTH * 2 : 0 ]    P8;
wire [ DATAWIDTH * 2 - 1 : 0] M8;

operate I1(.CLK(CLK),
		   .RSTn(RSTn),
		   .P(P),
		   .M(M),
		   .P_out(P1),
		   .M_out(M1));
operate I2(.CLK(CLK),
		   .RSTn(RSTn),
		   .P(P1),
		   .M(M1),
		   .P_out(P2),
		   .M_out(M2));
operate I3(.CLK(CLK),
		   .RSTn(RSTn),
		   .P(P2),
		   .M(M2),
		   .P_out(P3),
		   .M_out(M3));
operate I4(.CLK(CLK),
		   .RSTn(RSTn),
		   .P(P3),
		   .M(M3),
		   .P_out(P4),
		   .M_out(M4));
operate I5(.CLK(CLK),
		   .RSTn(RSTn),
		   .P(P4),
		   .M(M4),
		   .P_out(P5),
		   .M_out(M5));
operate I6(.CLK(CLK),
		   .RSTn(RSTn),
		   .P(P5),
		   .M(M5),
		   .P_out(P6),
		   .M_out(M6));
operate I7(.CLK(CLK),
		   .RSTn(RSTn),
		   .P(P6),
		   .M(M6),
		   .P_out(P7),
		   .M_out(M7));
operate I8(.CLK(CLK),
		   .RSTn(RSTn),
		   .P(P7),
		   .M(M7),
		   .P_out(P8),
		   .M_out(M8));

assign RESULT = P8[16:1];

endmodule		   