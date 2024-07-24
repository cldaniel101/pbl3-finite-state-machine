module limp_register(output [1:0]cout, input rega,input adb, input low, input ve, input reset, input clock, input critico);
	
	
	parameter NADA = 2'b00;
	parameter ADB = 2'b01;
	parameter LIMP = 2'b10;
	
	
	
	reg [1:0] state, nextstate;
	
	not (resetN,reset);
	not (adbn,adb);
	
	always @(posedge clock, posedge resetN)begin
	if (resetN) state <= NADA;
	else state <= nextstate;
	end
	
	

	always @(*)
	case (state)
		NADA: 
		if (!ve & adbn & low) nextstate = ADB;
		else nextstate = state;
		
		ADB: if (!ve & !low ) nextstate = LIMP;
		else nextstate = state;
		
		LIMP: if (!adbn & !critico) nextstate = NADA;
		else if (!ve & !adbn & !low) nextstate = state;
		
		
		
		default: nextstate = NADA;
	endcase
	assign cout = state;
	
	
	endmodule 