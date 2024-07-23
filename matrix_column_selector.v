module matrix_column_selector (
    output [6:0] coluna_selecionada,
    output [4:0] contador_ring,

    input [6:0] col_4,
    input [6:0] col_3,
    input [6:0] col_2,
    input [6:0] col_1,
    input [6:0] col_0,

    input clock,
    input reset
);

    column_selector(contador_ring, clock, reset);

    assign coluna_selecionada =
        (contador_ring[4]) ? (col_4) :
        (contador_ring[3]) ? (col_3) :
        (contador_ring[2]) ? (col_2) :
        (contador_ring[1]) ? (col_1) : (col_0);

endmodule