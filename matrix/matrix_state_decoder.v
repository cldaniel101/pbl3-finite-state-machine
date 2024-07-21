module matrix_image_selector (
    output reg [6:0] col_4,
    output reg [6:0] col_3,
    output reg [6:0] col_2,
    output reg [6:0] col_1,
    output reg [6:0] col_0,

    input [1:0] state
);

    parameter idle = 3'b00;
    parameter gotejamento = 3'b01;
    parameter aspersao = 3'b10;

    always @(*) begin
        case (state)
            idle: begin
                col_4 <= 7'b1111111; 
                col_3 <= col_4; 
                col_2 <= col_4; 
                col_1 <= col_4;
                col_0 <= col_4;
				end
            aspersao: begin
                col_4 <= 7'b0111001; 
                col_3 <= 7'b0011110; 
                col_2 <= 7'b0000000; 
                col_1 <= col_3;
                col_0 <= col_4;
				end
            gotejamento: begin
                col_4 <= 7'b1001111; 
                col_3 <= 7'b0000011; 
                col_2 <= 7'b0000001; 
                col_1 <= col_3;
                col_0 <= col_4;
				end
            default: begin
                col_4 <= 7'b1111111; 
                col_3 <= col_4;
                col_2 <= col_4;
                col_1 <= col_4;
                col_0 <= col_4;
				end
        endcase
    end

endmodule