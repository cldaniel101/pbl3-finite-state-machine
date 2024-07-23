module nivel_caixa (
    output reg [2:0] count,
    output reg Valve_E,


    input upper,
    input clock,
    input reset,
    input erro
);
    
    wire resetN;
    not (resetN, reset);


    reg [2:0] state, next_state;
    reg ve;


    always @(posedge clock or posedge resetN) begin
        if (resetN) begin
            state <= 3'b000;
        end else begin
            state <= next_state;
        end
    end


    always @(*) begin
        next_state = state; // Default assignment
        ve = Valve_E;       // Keep current state of Valve_E


        case (state)
            3'b000: begin
                if (erro) begin
                    next_state = state;
                end else if (!upper && !erro) begin
                    ve = 1; // Ativa a válvula de entrada
                    next_state = state + 1;
                end
					 else next_state = state;
            end
            
            3'b111: begin
                if (erro) begin
                    next_state = state;
						  
                end 
					 else if (!ve && upper && !erro) next_state = state - 1;
					 else  begin
                    ve = 0; 
                end
            end
            
            3'b001: begin
                if (erro) begin
                    next_state = state;
                end else if (!upper && !ve && !erro) begin
                    ve = 1; // Ativa a válvula de entrada
                    next_state = state + 1;
                end else if (!upper && ve && !erro) begin
                    next_state = state + 1;
                end else if (upper && !ve && !erro) begin
                    next_state = state - 1;
                end
            end


            default: begin
                if (erro) begin
                    next_state = state;
                end else if (!upper && ve && !erro) begin
                    next_state = state + 1;
                end else if (upper && !ve && !erro) begin
                    next_state = state - 1;
                end
            end
        endcase
    end


    always @(posedge clock or posedge resetN) begin
        if (resetN) begin
            count <= 3'b000;
            Valve_E <= 1'b0;
        end else begin
            count <= state;
            Valve_E <= ve;
        end
    end


endmodule





