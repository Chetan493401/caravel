`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2022 13:22:09
// Design Name: 
// Module Name: carrylookahead_32b
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


module carrylookahead_32b(Sum,Cout, A , B_ ,Cin

    );
    input [31:0] A;
    input [31:0] B_;
    input  Cin;
    output [31:0] Sum;
    output Cout;
    wire  [31:0] B;
    wire [31:0] P;
    wire [31:0] G;
    wire [31:0] C;
    wire [31:0] X;
    assign Cout = C[31];
    
    genvar M;
    generate 
    for(M =0;M<32;M=M+1)
    begin //Add or Subtract
    xor xadd_sub(B[M],B_[M],Cin);
    end 
    endgenerate
    
    
    
    
    genvar i;
    generate 
    for (i=0;i<32;i=i+1)
    begin //prop_gen
    xor x1(P[i],A[i],B[i]);
    and a1(G[i],A[i],B[i]);
    end
    endgenerate
    
    
    and an1(X[0],P[0],Cin);
    or  o1(C[0],G[0],X[0]);
    
    
    genvar j;
    generate
    for(j=0;j<31;j=j+1)
    begin //genr_car
    and and1( X[j+1],P[j+1],C[j]);
    or  or1(C[j+1],G[j+1],X[j+1]);
    end 
    endgenerate
    
    xor sum0(Sum[0],P[0],Cin);
    
    genvar k;
    generate
    for(k=0;k<31;k=k+1)
    begin //gen_Sum
    xor x_sum(Sum[k+1],P[k+1],C[k]);
    end
    endgenerate
    
    
    
    
endmodule
