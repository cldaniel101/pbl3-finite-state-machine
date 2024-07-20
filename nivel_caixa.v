module nivel_caixa (
    output [2:0] count,
	 output Valve_E,

    input upper,
    input clock,
    input reset
);
	
	not (resetN,reset);
	
	
    reg [2:0] state, next_state;
	 reg ve;
	
    always @(posedge clock, posedge resetN)
    if (resetN) begin
	 state <= 4'b000;
	 
	 end
    else state <= next_state;


    always @(*)
    case (state)
       
		 4'b000:begin;
				ve <= 1;
            if (!upper & ve) next_state <= state + 1;
            else next_state <= state;
			end
        
		  4'b111:begin
				ve<=0;
            if (upper) next_state <= state - 1;
				else next_state <= state ;
         end
			
			4'b001:begin
			if (!upper & !ve)begin 
				ve <= 1;
				next_state <= state + 1;
			 end 
			 else if (!upper & ve) next_state <= state + 1;
			 else if (upper & !ve) next_state <= state - 1;

			end
      
		default:begin
            if (!upper & ve) next_state <= state + 1;
				else if (upper & !ve) next_state <= state - 1;
				else next_state <= state ;
        
				end
    endcase

    assign count = state;
	 assign Valve_E = ve;

endmodule