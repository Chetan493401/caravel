`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2022 10:10:16
// Design Name: 
// Module Name: carry_primitiv
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

primitive carry(carry, a, b, c);
    input a,b,c;
    output carry;
    table
    
      1  1  ?  :  1 ;
      1  ?  1  :  1 ;
      ?  1  1  :  1 ;
      0  0  ?  :  0 ;
      0  ?  0  :  0 ;
      ?  0  0  :  0 ;
    endtable
    endprimitive
