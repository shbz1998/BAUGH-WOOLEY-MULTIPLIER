`timescale 1ns / 1ps
`define PERIOD 10

module BW_MULTIPLIER_TB(

    );
    
reg [3:0] a,b;
wire [7:0] c;
reg [7:0] ideal;
reg clk;
reg[3:0] d, e;
reg[7:0] f;

integer i;
integer j;

BW_MULTIPLIER BW0(.a(a), .b(b), .c(c));

initial 
begin
clk <= 0;
forever #(`PERIOD/2) clk = ~clk;
end

initial 
begin

for (i=0; i<16; i=i+1)
begin
    for(j=0; j<16; j=j+1)
    begin
        a=i;
        b=j;       
        #(`PERIOD);
    end
end

#(`PERIOD);
d = 4'b1110;
e = 4'b0111;
f = d*e;


end

endmodule
