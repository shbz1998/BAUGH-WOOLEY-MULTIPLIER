`timescale 1ns / 1ps

module WHITE_CELL(

input wire a, b, c_in, s_in,
output wire s_out, c_out

);
  
wire a_b;
assign a_b = (a && b);

FULL_ADDER FA1 (.a(a_b), .b(c_in), .c_in(s_in), .sum(s_out), .c_out(c_out));

endmodule
