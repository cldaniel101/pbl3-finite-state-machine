module valida_rega (
    output [1:0] rega,
    output erro,
    input asp,
    input got,
    input [1:0] mef1,
    input limpeza,
    input VE
);

    wire not_rega, not_asp, not_got, not_erro, not_critico;
    wire mef1_rega, erro_estado_rega, erro_sensor_rega, Erro_enchimento;
    wire rega_chave, erro_adb_limp, out_asp, out_got;

    assign not_rega = ~mef1_rega;
    assign not_asp = ~asp;
    assign not_got = ~got;
    assign not_erro = ~erro;

    and (mef1_rega, mef1[1], mef1[0]);
    and (erro_estado_rega, not_rega, rega_chave);
    and (erro_sensor_rega, asp, got);
    and (Erro_enchimento, VE, rega_chave);

    or (rega_chave, asp, got);

    // Output erro
    or (erro, erro_estado_rega, erro_sensor_rega, Erro_enchimento);

    and (out_asp, asp, not_got, not_erro);
    and (out_got, not_asp, got, not_erro);

    assign rega[1] = out_asp;
    assign rega[0] = out_got;

endmodule