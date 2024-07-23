module matrix_alternate_display_mode (
    output [6:0] col_4,
    output [6:0] col_3,
    output [6:0] col_2,
    output [6:0] col_1,
    output [6:0] col_0,

    input [1:0] estado_atual,
    input [1:0] water_level,

    input selector
);

    wire [6:0] state_col_4, state_col_3, state_col_2, state_col_1, state_col_0;
    wire [6:0] water_col;

    matrix_image_selector(
        state_col_4,
        state_col_3,
        state_col_2,
        state_col_1,
        state_col_0,

        estado_atual
    );

    tank_empting_decoder (
        water_col,
        water_level
    );

    assign col_4 = (selector)? (state_col_4) : (water_col);
    assign col_3 = (selector)? (state_col_3) : (water_col);
    assign col_2 = (selector)? (state_col_2) : (water_col);
    assign col_1 = (selector)? (state_col_1) : (water_col);
    assign col_0 = (selector)? (state_col_0) : (water_col);


endmodule