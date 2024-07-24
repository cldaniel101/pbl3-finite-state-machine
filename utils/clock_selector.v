module clock_selector (
    output reg new_clock,
    input clock,
    input [1:0] rega,
    input [1:0] limpeza,
    input erro,
    input VE
);

    wire new_frequency1, new_frequency2, new_frequency3, new_frequency4, new_frequency5, new_frequency6;

    clock_divisor(new_frequency1, clock, 1);
    little_clock_divisor(new_frequency2, new_frequency1, 1);
    little_clock_divisor(new_frequency3, new_frequency2, 1);
    little_clock_divisor(new_frequency4, new_frequency3, 1);
    clock_divisor(new_frequency5, new_frequency4, 1);
    clock_divisor(new_frequency6, new_frequency5, 1);

    always @(posedge clock) begin
        if (limpeza[1]) begin
            new_clock <= new_frequency4;
        end else if (rega == 2'b01 && !erro && !limpeza[1]) begin
            new_clock <= new_frequency2;
        end else if (rega == 2'b10 && !erro) begin
            new_clock <= new_frequency1;
        end else if (rega == 2'b00 && !erro && !VE) begin
            new_clock <= new_frequency4;
        end else begin
            new_clock <= new_frequency1;
        end
    end

endmodule