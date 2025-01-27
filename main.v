module main (
    output [1:0] limpeza,
 
    output test_MEF1_b1, 
    output test_MEF1_b0,
    output erro,
    output rgb_l,
    output rgb_verde,
    output led_valvule,
    output matrix_col_4,
    output matrix_col_3,
    output matrix_col_2,
    output matrix_col_1,
    output matrix_col_0,
    output matrix_row_6,
    output matrix_row_5,
    output matrix_row_4,
    output matrix_row_3,
    output matrix_row_2,
    output matrix_row_1,
    output matrix_row_0,
    input reset, 
    input asp, 
    input got, 
    input adb, 
    input clock
);

    // Internal wires
    wire reset_pulse, adbN, rega_begin, critic, rega_open, Low, aduba, not_erro;
    wire [1:0] cout_MEF1, cout_MEF2, rega_valida;
    wire new_clock;
    wire [6:0] column_4, column_3, column_2, column_1, column_0;
	wire [2:0] cout_Nivel; 
	
    // Logic
    not (reset_pulse, reset);
    not (adbN, adb);
    or (rega, asp, got, limpeza);
    and (rega_begin, cout_MEF1[1], cout_MEF1[0]);
    or (critic, cout_Nivel[2], cout_Nivel[1], cout_Nivel[0]);
    xor (rega_open, cout_MEF2[1], cout_MEF2[0]);
    or (Low, cout_Nivel[2], cout_Nivel[1]);
    nand (aduba, adbN, asp);
    assign not_erro = ~erro;

    // Clock divisors
    clock_divisor(new_frequency1, clock, 1);
    clock_divisor(new_frequency2, new_frequency1, 1);
    clock_divisor(new_frequency3, new_frequency2, 1);
    clock_divisor(new_frequency4, new_frequency3, 1);
    clock_divisor(new_frequency5, new_frequency4, 1);    

    // Assignments
    assign limp = limpeza[1];
    and (rgb_l, not_erro, limp);
    and (rgb_verde, not_erro, limpeza[0]);
    and (led_valvule, not_erro, VE);

    // Modules
    clock_selector(new_clock, new_frequency4, cout_MEF2, limpeza, erro, VE);
    valida_rega(rega_valida, erro, asp, got, cout_MEF1, limpeza, VE, critic);
    nivel_caixa(cout_Nivel, VE, rega_open, new_clock, reset, erro);
    limp_register(limpeza, rega, aduba, Low, VE, reset, new_frequency3, critic);
    MEF2(cout_MEF2, new_frequency3, reset, rega_valida);
    MEF1(cout_MEF1, critic, VE, rega, reset, new_frequency3);

    // Test assignments
    assign test_MEF1_b1 = limpeza[1];
    assign test_MEF1_b0 = limpeza[0];

    // Matrix display
    matrix_alternate_display_mode (
        column_4, column_3,
        column_2, column_1,
        column_0,
        cout_MEF2, // 2 bits
        cout_Nivel, // 3 bits
        new_frequency5
    );

    matrix_column_selector (
        {matrix_row_6, matrix_row_5, matrix_row_4, matrix_row_3, matrix_row_2, matrix_row_1, matrix_row_0},
        {matrix_col_4, matrix_col_3, matrix_col_2, matrix_col_1, matrix_col_0},
        column_4, column_3, column_2, column_1, column_0,
        new_frequency3,
        reset_pulse
    );

endmodule
