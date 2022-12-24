`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2022 23:04:26
// Design Name: 
// Module Name: comparator_1bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module comparator_1bit(a,b,gt ,lt,eq);

input a,b;
output lt,gt,eq;
wire abar,bbar;

not n1(abar,a);
//assign bbar = ~b;
not n2(bbar,b);
//assign lt = abar & b;

and a1(lt,abar,b);
//assign gt = bbar & a;
and a2(gt,bbar,a);
//assign eq = ~(lt|gt);
nor nor3(eq,lt,gt);
endmodule

