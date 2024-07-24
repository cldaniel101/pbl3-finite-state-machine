module MEF2 (
    output [1:0] cout,
    input CLK,
    input reset,
    input [1:0] rega
);

    parameter NADA = 2'b00;
    parameter ASP = 2'b10;
    parameter GOT = 2'b01;

    wire asp, got;
    wire resetN;

    assign asp = rega[1];
    assign got = rega[0];
    assign resetN = !reset;

    reg [1:0] state, nextstate;

    // Lógica de Estado
    always @(posedge CLK or posedge resetN) begin
        if (resetN)
            state <= NADA;
        else
            state <= nextstate;
    end

    // Lógica Combinacional
    always @(*) begin
        case (state)
            NADA: 
                if (asp & ~got)
                    nextstate <= ASP;
                else if (~asp & got)
                    nextstate <= GOT;
                else
                    nextstate <= NADA;
            
            ASP: 
                if (~asp & ~got)
                    nextstate <= NADA;
                else if (~asp & got)
                    nextstate <= GOT;
                else
                    nextstate <= ASP;

            GOT: 
                if (~asp & ~got)
                    nextstate <= NADA;
                else if (asp & ~got)
                    nextstate <= ASP;
                else
                    nextstate <= GOT;

            default: 
                nextstate <= NADA;
        endcase
    end

    // Saída
    assign cout = state;

endmodule