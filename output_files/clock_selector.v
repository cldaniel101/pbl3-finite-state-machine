module clock_selector (
    output reg new_clock,  
    
    input clock,           
    input [1:0] rega,      
    input [1:0] limpeza,
		input erro
);

    clock_divisor(new_frequency1, clock, 1);
    little_clock_divisor(new_frequency2, new_frequency1, 1);
	little_clock_divisor(new_frequency3, new_frequency2, 1);
	little_clock_divisor(new_frequency4, new_frequency3, 1);
	clock_divisor(new_frequency5, new_frequency4, 1);
	clock_divisor(new_frequency6, new_frequency5, 1);


    always @ (posedge clock) begin
        if (rega == 2'b01 && !erro) begin
            // Se rega for 01 ou Gotejamento
            new_clock <= new_frequency2;

        end else if (rega == 2'b10 && !erro) begin
            // Se rega for 10 ou Aspersão
            new_clock <= new_frequency1;
				
        end else if (limpeza[1] && !erro) begin
            // Se rega for 10 (aspersão) e limpeza for 10 (ativo)
            new_clock <= new_frequency4;
				
        end 
		  else if (erro) new_clock = 0;
		  else begin
            // Caso contrário (enchimento)
            new_clock <= new_frequency1;
        end
    end

endmodule