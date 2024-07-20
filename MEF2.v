module MEF2 ( output [1:0]cout, input CLK, input reset, input [1:0] rega);

	parameter NADA = 2'b00;
	parameter ASP = 2'b01;
	parameter GOT = 2'b10;
	
	assign asp = rega[1];
	assign got = rega[0];
	
	reg [1:0] state, nextstate;
	assign resetN = !reset;
	
	always @(posedge CLK, posedge resetN)
	if (resetN) state <= NADA;
	else state <= nextstate;
	
	always @(*)
	case (state)
		NADA: if (asp & ~got) nextstate <= ASP;
		else if (~asp & got) nextstate <= GOT;
		else nextstate <= NADA;
		ASP: if (~asp & ~got) nextstate <= NADA;
		else if (~asp & got) nextstate <= GOT;
		else nextstate <= ASP;
		GOT: if (~asp & ~got) nextstate <= NADA;
		else if (asp & ~got) nextstate <= ASP;
		else nextstate <= GOT;
		default: nextstate <= NADA;
	endcase
	
	assign cout = state;
	
	
endmodule  