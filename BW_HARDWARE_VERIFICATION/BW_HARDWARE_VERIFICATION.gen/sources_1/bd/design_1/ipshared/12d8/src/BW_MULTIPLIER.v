`timescale 1ns / 1ps

module BW_MULTIPLIER(
input wire [3:0] a,b,
output wire [7:0] c
);

genvar i;

//-------------------ROW 1-----------------//
wire c_out_wire[3:0]; 
wire s_out_wire [3:0];
wire carry_out;
wire [7:0] p;

generate
for(i=0; i<4; i=i+1)
    begin
    if(i==3)
        begin
        GREY_CELL G0(.a(a[i]), .b(b[0]), .c_in(1'b0), .s_in(1'b0), .s_out(s_out_wire[i]), .c_out(c_out_wire[i]));
        end
    else
        begin
        WHITE_CELL U0(.a(a[i]), .b(b[0]), .c_in(1'b0), .s_in(1'b0), .s_out(s_out_wire[i]), .c_out(c_out_wire[i]));
    end
    end
endgenerate

assign p[0] = s_out_wire[0];

//-------------------ROW 2-----------------//
wire c_out_wire2[3:0]; 
wire s_out_wire2[3:0];


generate
for(i=0; i<4; i=i+1)
    begin
    if(i==3)
        begin
        GREY_CELL G0(.a(a[i]), .b(b[1]), .c_in(1'b0), .s_in(1'b0), .s_out(s_out_wire2[i]), .c_out(c_out_wire2[i]));
        end
    else
    begin
    WHITE_CELL U0(.a(a[i]), .b(b[1]), .c_in(c_out_wire[i]), .s_in(s_out_wire[i+1]), .s_out(s_out_wire2[i]), .c_out(c_out_wire2[i]));
    end
    end
endgenerate

assign p[1] = s_out_wire2[0];

//--------------------ROW 3 ----------------------//
wire c_out_wire3[3:0]; 
wire s_out_wire3[3:0];


generate
for(i=0; i<4; i=i+1)
    begin
    if(i==3)
        begin
        GREY_CELL G0(.a(a[i]), .b(b[2]), .c_in(1'b0), .s_in(1'b0), .s_out(s_out_wire3[i]), .c_out(c_out_wire3[i]));
        end
    else
    begin
    WHITE_CELL U0(.a(a[i]), .b(b[2]), .c_in(c_out_wire2[i]), .s_in(s_out_wire2[i+1]), .s_out(s_out_wire3[i]), .c_out(c_out_wire3[i]));
    end
    end
endgenerate

assign p[2] = s_out_wire3[0];


//--------------------ROW 3 ----------------------//
wire c_out_wire4[3:0]; 
wire s_out_wire4[3:0];


generate
for(i=0; i<4; i=i+1)
    begin
    if(i==3)
        begin
        WHITE_CELL D1(.a(a[i]), .b(b[3]), .c_in(1'b0), .s_in(1'b0), .s_out(s_out_wire4[i]), .c_out(c_out_wire4[i]));
        end
    else
    begin
    GREY_CELL E1(.a(a[i]), .b(b[3]), .c_in(c_out_wire3[i]), .s_in(s_out_wire3[i+1]), .s_out(s_out_wire4[i]), .c_out(c_out_wire4[i]));
    end
    end
endgenerate

assign p[3] = s_out_wire4[0];

//--------------------ROW 4 ----------------------//
wire[3:0] carry_chain;

FULL_ADDER F0(.c_in(1'b1), .a(c_out_wire4[0]), .b(s_out_wire4[1]), .sum(p[4]), .c_out(carry_chain[0]));
FULL_ADDER F1(.c_in(carry_chain[0]), .a(c_out_wire4[1]), .b(s_out_wire4[2]), .sum(p[5]), .c_out(carry_chain[1]));
FULL_ADDER F2(.c_in(carry_chain[1]), .a(c_out_wire4[2]), .b(s_out_wire4[3]), .sum(p[6]), .c_out(carry_chain[2]));
FULL_ADDER F3(.c_in(carry_chain[2]), .a(c_out_wire4[3]), .b(1'b1), .sum(p[7]), .c_out(carry_chain[3]));


assign c = p;


endmodule
