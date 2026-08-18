module Clock_Divider_1k_tb();

    reg clk_50MHz_tb;
    wire clk_1KHz_tb;

    Clock_Divider_1k U(clk_50MHz_tb, clk_1KHz_tb);

    initial begin
        clk_50MHz_tb = 0;
        forever begin
            #5;
            clk_50MHz_tb = ~clk_50MHz_tb;
        end
    end

    initial begin
        #500;
        $stop;
    end

endmodule