`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2022 21:59:35
// Design Name: 
// Module Name: nor_32b
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


module nor_32b(C,B,A );
input [31:0] A;
input [31:0] B;
output [31:0] C;

genvar i;
generate

for( i=0; i<=31; i=i+1)
begin //nor_operation
nor a1(C[i] , B[i] , A[i]);
end
endgenerate


endmodule
