module valida_rega(output [1:0]rega, output erro, 
input asp, 
input got, 
input [1:0] mef1, 
input limpeza);

	assign not_rega = ~mef1_rega;
	assign not_asp = ~asp;
	assign not_got = ~got;
	assign not_erro = ~erro;

	and(erro_limpeza, rega_chave, limpeza);
	and(mef1_rega, mef1[1], mef1[0]);
	and(erro_estado_rega, not_rega, rega_chave);
	and (erro_sensor_rega, asp,got);
	
	or(rega_chave, asp, got);
	
	//Output erro
	or(erro, erro_limpeza, erro_estado_rega,erro_sensor_rega);
	
	and(out_asp, asp, not_got, not_erro);
	and(out_got,not_asp,got,not_erro);
	
	assign rega[1] = out_asp;
	assign rega[0] = out_got;


endmodule
