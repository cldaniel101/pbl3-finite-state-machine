module MEF1(output [1:0] cout, input c, input ve, input rega, input reset, input clock);
	
	parameter VZ = 2'b00;
	parameter EN = 2'b01;
	parameter ERRO = 2'b10;
	parameter REGA = 2'b11;
	
	
	reg [1:0] state, nextstate;
	
	not (resetN,reset);
	
	always @(posedge clock, posedge resetN)
	if (resetN) state <= VZ;
	else state <= nextstate;
	
	
	
	always @(*)
	case (state)
		VZ: if (!c & ve & !rega) nextstate = EN;
		else if (rega) nextstate = ERRO;
		else nextstate = VZ;
		
		EN: if (c & !ve) nextstate = REGA;
		else if (ve & rega) nextstate = ERRO;
		else nextstate = EN;
		
		REGA: if (c & ve & !rega) nextstate = EN;
		else if (!c & !rega) nextstate = VZ;
		else nextstate = REGA;
		
		ERRO: if (!c & !ve & !rega) nextstate = VZ;
		else if (ve & !rega) nextstate = EN;
		else if (c & !ve & !rega) nextstate = REGA;
		else nextstate = ERRO;
		
		default: nextstate = VZ;
	endcase
	assign cout = state;
	
	
	endmodule 