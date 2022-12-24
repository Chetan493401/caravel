`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2022 22:55:32
// Design Name: 
// Module Name: comparator_gt_32_bit
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


module comparator_gt_32_bit(gt,lt,eq,a,b );
input [31:0] a;
input [31:0] b;
output  lt,gt ,eq;
wire ltm,gtm,eqm;
wire ltl,gtl,eql;
wire tmp1;
comp_16b c1(gtm , ltm, eqm,a[31:16],b[31:16]);
comp_16b c2(gtl,ltl,eql,a[15:0],b[15:0]);

and a1(tmp1, eqm,gtl);
or  or1(gt, tmp1, gtm);

and a2(eq, eql,eqm);

nor n2(lt,eq , gt);


endmodule
