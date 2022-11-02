`timescale 1ns / 1ps

module FULL_ADDER( 
input wire a,b,c_in,
output wire sum,c_out
);
    
wire I1,I2,I3;

HALF_ADDER HA1(a,b,I1,I2);
HALF_ADDER HA2(I1,c_in,sum,I3);

assign c_out = I2 || I3;

endmodule 


