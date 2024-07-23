module main(
	output [1:0]limpeza,
	output VE,
	output [2:0] cout_Nivel,
	output test_MEF1_b1,
	output test_MEF1_b0,


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


	not (reset_pulse, reset);
	not (adbN,adb);
	or (rega, asp,got);
	wire [1:0]cout_MEF1;
	and (rega_begin, cout_MEF1[1],cout_MEF1[0]);
	or (c, cout_Nivel[2], cout_Nivel[1],cout_Nivel[0]);
	wire [1:0]cout_MEF2;
	xor (rega_open, cout_MEF2[1] ,cout_MEF2[0]);
	or (Low, cout_Nivel[2], cout_Nivel[1]);
	nand (aduba, adbN, asp);
	wire[1:0]rega_valida;
	wire new_clock;
    
	clock_divisor(new_frequency1, clock, 1);
	clock_divisor(new_frequency2, new_frequency1, 1);
	clock_divisor(new_frequency3, new_frequency2, 1);
	clock_divisor(new_frequency4, new_frequency3, 1);
	clock_divisor(new_frequency5, new_frequency4, 1);
    
	always @ (posedge clock) begin
    	if (cout_MEF2 == 2'b01) begin
        	// Se rega for 01 ou Gotejamento
        	new_clock <= new_frequency5;


    	end else if (cout_MEF2 == 2'b10) begin
        	// Se rega for 10 ou Aspersão
        	new_clock <= new_frequency4;


    	end else if (cout_MEF2 == 2'b10 && limpeza == 2'b10) begin
        	// Se rega for 10 (aspersão) e limpeza for 10 (ativo)
        	new_clock <= new_frequency2;


    	end else begin
        	// Caso contrário (enchimento)
        	new_clock <= new_frequency5;
    	end
	end


   	clock_selector(fast_clock, default_clock, clock, cout_MEF2, limpeza);


    
	valida_rega(rega_valida, erro, asp, got, cout_MEF1, limpeza[1],VE);
    
    
    
	nivel_caixa(cout_Nivel,VE , rega_open,new_frequency5, reset, erro);
    
	limp_register(limpeza, aduba, Low, VE, reset, new_frequency5);
    
	MEF2 (cout_MEF2, new_frequency5, reset, rega_valida);


	MEF1(cout_MEF1, c,VE , rega, reset, new_frequency5);




	assign test_MEF1_b1 = cout_MEF2[1];
	assign test_MEF1_b0 = cout_MEF2[0];


	wire [6:0] column_4, column_3, column_2, column_1, column_0;
	wire [6:0] selected_matrix_column;


	matrix_alternate_display_mode (
    	column_4, column_3,
    	column_2, column_1,
    	column_0,


    	cout_MEF2, // 2 bits
    	cout_Nivel, // 2 bits


    	new_frequency5
	);


	matrix_column_selector (
    	{matrix_row_6, matrix_row_5, matrix_row_4, matrix_row_3, matrix_row_2, matrix_row_1, matrix_row_0},
    	{matrix_col_4, matrix_col_3, matrix_col_2, matrix_col_1, matrix_col_0},


    	column_4,
    	column_3,
    	column_2,
    	column_1,
    	column_0,


    	new_frequency3,
    	reset_pulse
	);




endmodule



