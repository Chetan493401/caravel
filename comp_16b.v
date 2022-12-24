`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2022 23:18:57
// Design Name: 
// Module Name: comp_16b
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


module comp_16b(gt1,lt1,eq1,a1,b1);
input [15:0] a1,b1;
output lt1,gt1,eq1;

wire [3:0]eq;
wire [3:0]lt;
wire [3:0]gt;
comp_4b c3(a1[15:12],b1[15:12],gt[3],lt[3],eq[3]);
comp_4b c2(a1[11:8],b1[11:8],gt[2],lt[2],eq[2]);
comp_4b c1(a1[7:4],b1[7:4],gt[1],lt[1],eq[1]);
comp_4b c0(a1[3:0],b1[3:0],gt[0],lt[0],eq[0]);
wire a,b,c,d,e,f;


and and1(a,eq[1],gt[0]);
or  o1(b,a,gt[1]);
and a2(c,b,eq[2]);
or  o2(d,c,gt[2]);
and a3(e,d,eq[3]);
or  o3(gt1,gt[3],e);
and a4(eq1,eq[0],eq[1],eq[2],eq[3]);

nor n1(lt1,eq1,gt1);
endmodule
