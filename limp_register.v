module limp_register(
    output [1:0] cout,
    input rega,
    input adb,
    input low,
    input ve,
    input reset,
    input clock
);

    parameter NADA = 2'b00;
    parameter ADB = 2'b01;
    parameter LIMP = 2'b10;

    reg [1:0] state, nextstate;
    wire resetN, adbn;

    // Inversores
    not (resetN, reset);
    not (adbn, adb);

    // Logica de Estado
    always @(posedge clock or posedge resetN) begin
        if (resetN)
            state <= NADA;
        else
            state <= nextstate;
    end

    // Logica Combinacional
    always @(*) begin
        case (state)
            NADA: 
                if (!ve & adbn & low)
                    nextstate = ADB;
                else
                    nextstate = NADA;
            
            ADB: 
                if (!ve & !low)
                    nextstate = LIMP;
                else
                    nextstate = ADB;
            
            LIMP: 
                if (ve & !adbn & !low)
                    nextstate = NADA;
                else if (!ve & !adbn & !low)
                    nextstate = LIMP;
            
            default: 
                nextstate = NADA;
        endcase
    end

    // Saida
    assign cout = state;

endmodule