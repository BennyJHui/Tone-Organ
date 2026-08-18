`define Wait 2'b00
`define Count 2'b01
`define Pulse 2'b10

module Clock_Divider(
    input clk_50MHz,
    input [3:0] switch,
    output reg Clk_div_Signal
);

    reg [19:0] n = 0;
    reg [19:0] counter = 0;
    reg [1:0] state;

    always @(*) begin
        case(switch[3:1])
            3'b000: n = 47800; // 523 Hz
            3'b001: n = 42588; // 587 Hz
            3'b010: n = 37935; // 659 Hz
            3'b011: n = 35816; // 698 Hz
            3'b100: n = 31927; // 783 Hz
            3'b101: n = 28408; // 880 Hz
            3'b110: n = 25328; // 987 Hz
            3'b111: n = 23900; // 1046 Hz
        endcase
    end

    always @(posedge clk_50MHz) begin
        if (~switch[0]) begin
            state <= `Wait;
        end else begin
            case(state)
                `Wait: state <= (switch[0]) ? `Count : `Wait;

                `Count: begin
                    if (counter == n) begin
                        counter <= 0;
                        state <= `Pulse;
                    end else begin
                        counter <= counter + 1;
                    end
                end

                `Pulse: begin 
                    if (counter == n) begin
                        state <= `Count;
                        counter <= 0;
                    end else begin
                        counter <= counter + 1;
                    end
                end

                default: state <= `Wait;
            endcase
        end
    end

    always @(*) begin
        Clk_div_Signal = 0;

        case(state)
            `Wait: begin
                // nothing
            end

            `Count: begin
                Clk_div_Signal = 0;
            end

            `Pulse: begin
                Clk_div_Signal = 1;
            end

            default: begin
                Clk_div_Signal = 0;
            end
        endcase
    end


endmodule