module main(output [1:0]limpeza,output VE, output [2:0] cout_Nivel, input reset, input asp, input got, input adb, input clock,
output test_MEF1_b1, output test_MEF1_b0
);

not (adbN,adb);
or (rega, asp,got);
wire [1:0]cout_MEF1;
and (rega_begin, cout_MEF1[1],cout_MEF1[0]);
or (c, cout_Nivel[2], cout_Nivel[1],cout_Nivel[0]);
wire [1:0]cout_MEF2;
xor (rega_open, cout_MEF2[1] ,cout_MEF2[0]);
or (Low, cout_Nivel[2], cout_Nivel[1]);
nand (aduba, adbN, asp);

clock_divisor(new_frequency1, clock, 1);
clock_divisor(new_frequency2, new_frequency1, 1);
clock_divisor(new_frequency3, new_frequency2, 1);
clock_divisor(new_frequency4, new_frequency3, 1);
clock_divisor(new_frequency5, new_frequency4, 1);

	
	valida_rega(rega_valida, erro, asp, got, cout_MEF1, limpeza);

	
	nivel_caixa(cout_Nivel,VE , rega_open, new_frequency5, reset);
	
	limp_register(limpeza, aduba, Low, VE, reset, new_frequency5);
	
	MEF2 (cout_MEF2, new_frequency5, reset, rega_valida);
	MEF1(cout_MEF1, c,VE , rega, reset, new_frequency5);

	assign test_MEF1_b1 = limpeza[1];
	assign test_MEF1_b0 = limpeza[0];

	
endmodule 