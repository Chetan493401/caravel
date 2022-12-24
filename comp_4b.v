`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2022 23:11:14
// Design Name: 
// Module Name: comp_4b
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


module comp_4b(A,B,GT,LT,EQ);
input [3:0] A,B;
output LT,GT,EQ;

wire [3:0]eq;
wire [3:0]lt;
wire [3:0]gt;
comparator_1bit c3(A[3],B[3],gt[3],lt[3],eq[3]);
comparator_1bit c2(A[2],B[2],gt[2],lt[2],eq[2]);
comparator_1bit c1(A[1],B[1],gt[1],lt[1],eq[1]);
comparator_1bit c0(A[0],B[0],gt[0],lt[0],eq[0]);
wire a,b,c,d,e,f;


and a1(a,eq[1],gt[0]);
or  o1(b,a,gt[1]);
and a2(c,b,eq[2]);
or  o2(d,c,gt[2]);
and a3(e,d,eq[3]);
or  o3(GT,gt[3],e);


and a4(EQ,eq[0],eq[1],eq[2],eq[3]);

nor n1(LT,EQ,GT);



endmodule
