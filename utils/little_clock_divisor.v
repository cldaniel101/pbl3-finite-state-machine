module little_clock_divisor(
    output new_frequency,

    input clock,
    input reset
);

    flipflop_t (new_frequency,   clock,  reset, 1);

endmodule