module decoder_caixa_dagua (
    output reg [6:0] coluna,

    input [2:0] water_level
);

    always @(*) begin
        case (water_level)
            3'b000:  coluna <= 7'b1111111;
            3'b001:  coluna <= 7'b0111111;
            3'b010:  coluna <= 7'b0011111;
            3'b011:  coluna <= 7'b0001111;
            3'b100:  coluna <= 7'b0000111;
            3'b101:  coluna <= 7'b0000011;
            3'b110:  coluna <= 7'b0000001;
            3'b111:  coluna <= 7'b0000000;
            default: coluna <= 7'b1111111;
        endcase
    end

endmodule