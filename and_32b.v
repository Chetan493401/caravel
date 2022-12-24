`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2022 20:24:52
// Design Name: 
// Module Name: and_32b
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


module and_32b(C,B,A );
input [31:0] A;
input [31:0] B;
output [31:0] C;

genvar i;
generate

for( i=0; i<=31; i=i+1)
begin //and_operation
nand a1(C[i] , B[i] , A[i]);
end
endgenerate


endmodule
