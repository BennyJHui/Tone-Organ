`define Left  1'b0
`define Right 1'b1

module LED_Display(
    input clk_1KHz,
    output reg [7:0] LED
);

    reg state = `Left;
    reg [2:0] counter = 3'b000;

    always @(posedge clk_1KHz) begin
        case(state)

            `Left: begin
                if (counter == 3'b111) begin
                    state <= `Right;
                    counter <= 3'b110;
                end
                else begin
                    counter <= counter + 1'b1;
                end
            end

            `Right: begin
                if (counter == 3'b000) begin
                    state <= `Left;
                    counter <= 3'b001;
                end
                else begin
                    counter <= counter - 1'b1;
                end
            end

        endcase
    end

    always @(*) begin
        case(counter)
            3'b000: LED = 8'b00000001;
            3'b001: LED = 8'b00000010;
            3'b010: LED = 8'b00000100;
            3'b011: LED = 8'b00001000;
            3'b100: LED = 8'b00010000;
            3'b101: LED = 8'b00100000;
            3'b110: LED = 8'b01000000;
            3'b111: LED = 8'b10000000;
            default: LED = 8'b00000001;
        endcase
    end

endmodule