module Clock_Divider_tb();

    reg clk_50MHz_tb;
    reg [3:0] switch_tb;
    wire Clk_div_Signal_tb;

Clock_Divider U(
    .clk_50MHz(clk_50MHz_tb),
    .switch(switch_tb),
    .Clk_div_Signal(Clk_div_Signal_tb)
);

initial begin
    clk_50MHz_tb = 0;
    forever begin
        #5;
        clk_50MHz_tb = ~clk_50MHz_tb;
    end
end

initial begin
    switch_tb[3:1] = 3'b000;
    switch_tb[0] = 1;
    #1000;
    switch_tb = 0;
    #100;
    $stop;
end

endmodule