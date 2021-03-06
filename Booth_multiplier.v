module Boost_multiplier#(
	parameter DATAWIDTH = 8
)
(
	input                            CLK,
	input                            RSTn,
	input                            START,
	input  [ DATAWIDTH - 1 : 0 ]     A,
	input  [ DATAWIDTH - 1 : 0 ]     B,
	
	output [ DATAWIDTH * 2 - 1 : 0 ] RESULT,
	output                           Done
);

reg [ DATAWIDTH - 1 : 0 ] i;
reg [ DATAWIDTH * 2 : 0 ] P;
reg [ DATAWIDTH - 1 : 0 ] A_reg;
reg [ DATAWIDTH - 1 : 0 ] A_bm;
reg [ DATAWIDTH - 1 : 0 ] N;
reg                       isDone;

always @ ( posedge CLK or negedge RSTn )
begin
	if (!RSTn)
	begin
		i <= 0;
		P <= 0;
		A_reg <= 0;
		A_bm <= 0;
		N <=0;
		isDone <= 0;
	end
	else if (START)
	begin
		case (i)
		
			0:
				begin
					A_reg <= A;
					A_bm <= ~A + 1'b1;
					P <= { 8'd0, B, 1'b0 };
					i <= i + 1'b1;
					N <= 0;
				end
			1:
				begin
					if (N == 8)
						begin
							N <= 0;
							i <= i + 2'b10;
						end
					else if (P[1:0] == 2'b00 | P[1:0] == 2'b11)
						begin
							P <= P;
							i <= i + 1'b1;
						end
					else if (P[1:0] == 2'b01)
						begin
							P <= {P[16:9] + A_reg,P[8:0]};
							i <= i + 1'b1;
						end
					else if (P[1:0] == 2'b10)
						begin
							P <= {P[16:9] + A_bm,P[8:0]};
							i <= i + 1'b1;
						end

				end
			2:
				begin
					P <= {P[16],P[16:1]};
					N <= N + 1'b1;
					i <= i - 1'b1;
				end
			3:
				begin
					isDone <= 1;
					i <= i + 1'b1;
				end
			4:
				begin
					isDone <= 0;
					i <= 0;
				end
		
		endcase
	end
end

assign Done = isDone;
assign RESULT = P[16:1];

endmodule