module LED_Display_tb();

    reg clk_1KHz_tb;
    wire [7:0] LED_tb;

    LED_Display U(clk_1KHz_tb, LED_tb);

    initial begin
        clk_1KHz_tb = 0;
        forever begin
            #5;
            clk_1KHz_tb = ~clk_1KHz_tb;
        end
    end

    initial begin
        #500;
        $stop;
    end

endmodule