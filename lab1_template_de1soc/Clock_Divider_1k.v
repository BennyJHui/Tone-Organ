`define Count 1'b0
`define Pulse 1'b1

module Clock_Divider_1k(
    input clk_50MHz,
    output clk_1KHz
);

    reg [25:0] counter = 0;
    reg state = `Count;

    always @(posedge clk_50MHz) begin
        case(state)
            `Count: begin
                if (counter == 26'd25000000) begin
                    counter <= 0;
                    state <= `Pulse;
                end else begin
                    counter <= counter + 1;
                end
            end

            `Pulse: begin
                if (counter == 26'd25000000) begin
                    counter <= 0;
                    state <= `Count;
                end else begin
                    counter <= counter + 1;
                end
            end

            default: state <= `Count;
        endcase
    end

    assign clk_1KHz = (state == `Pulse) ? 1 : 0;

endmodule