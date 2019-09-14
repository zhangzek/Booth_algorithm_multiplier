module Boost_multiplier_tb();

	parameter DATAWIDTH = 8;
	
	reg                           CLK;
	reg                           RSTn;
	reg                           START;
	reg  [ DATAWIDTH - 1 : 0 ]    A;
	reg  [ DATAWIDTH - 1 : 0 ]    B;
	wire [ DATAWIDTH * 2 - 1 : 0 ]RESULT;
	wire                          Done;
	
	
initial 
begin
	CLK = 0;
	forever #10 CLK = ~CLK;
end

initial
begin
	RSTn = 0;
	START = 0;
	#10 RSTn = 1;START = 1;
	A = 2;
	B = 4;
	#400
	A = 3;
	B = 5;
	#400
	A = 4;
	B = 6;
	#400
	A = 10;
	B = 19;
	#400
	A = 32;
	B = 45;
	#400
	A = 23;
	B = 45;
	#400
	A = 32;
	B = 12;
	#400
	A = 32;
	B = 15;
	#400
	$stop;
end

Boost_multiplier BM(.CLK(CLK),
                    .RSTn(RSTn),
					.START(START),
					.A(A),
					.B(B),
					.RESULT(RESULT),
					.Done(Done));
endmodule