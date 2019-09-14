module operate#(
	parameter DATAWIDTH = 8
)
(
	input                            CLK,
	input                            RSTn,
	input  [ DATAWIDTH * 2 : 0 ]     P,
	input  [ DATAWIDTH * 2 - 1 : 0 ] M,
	
	output [ DATAWIDTH * 2 : 0 ]     P_out,
	output [ DATAWIDTH * 2 - 1 : 0 ] M_out
);


reg [ DATAWIDTH * 2 : 0 ] P_reg;
reg [ DATAWIDTH * 2 - 1 : 0 ] M_reg;
reg [ DATAWIDTH - 1 : 0 ] Pco1;
reg [ DATAWIDTH - 1 : 0 ] Pco2;

always @ ( posedge CLK or negedge RSTn )
begin
	if (!RSTn)
	begin
		P_reg <= 0;
		M_reg <= 0;
		Pco1 <= 0;
		Pco2 <= 0;
	end
	else 
	begin
		Pco1 = P[16:9] + M[7:0];
		Pco2 = P[16:9] + M[15:8];
					
		if (P[1:0] == 2'b01)
			begin
				P_reg <= {Pco1[7],Pco1,P[8:1]};
			end
		else if (P[1:0] == 2'b10)
			begin
				P_reg <= {Pco2[7],Pco2,P[8:1]};
			end
		else 
			begin
				P_reg <= {P[16],P[16:1]};
			end
		M_reg <= M;
	end
end

assign P_out = P_reg;
assign M_out = M_reg;
endmodule