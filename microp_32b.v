`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2022 00:04:55
// Design Name: 
// Module Name: microp_32b
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


module microp_32b(clk1,clk2,MEM_WB_IR);
input clk1,clk2;
output MEM_WB_IR;
reg[31:0] PC,IF_ID_IR,IF_ID_NPC;
reg[31:0] ID_EX_IR,ID_EX_NPC,ID_EX_A,ID_EX_B,ID_EX_Imm;
reg[2:0] ID_EX_type,EX_MEM_type,MEM_WB_type;
reg[31:0] EX_MEM_IR,EX_MEM_ALUOut,EX_MEM_B;
reg EX_MEM_cond;
reg[31:0] MEM_WB_IR,MEM_WB_ALUOut,MEM_WB_LMD;
reg[31:0] Reg[0:31];
reg[31:0] Mem[0:1023];
parameter ADD=6'b000000, SUB=6'b000001,NAND=6'b000010,NOR=6'b000011;
parameter SLT=6'b000100,SGT=6'b000101,SET = 6'b000110,HLT=6'b111111,LW=6'b001000,SW=6'b001001,ADDI=6'b001010,SUBI=6'b001011,SLTI=6'b001100,SETI=6'b001111,BNEQZ=6'b001101,BEQZ=6'b001110;
parameter RR_ALU=3'b000,RM_ALU=3'b001,LOAD=3'b010,STORE=3'b011,HALT=3'b101;
reg HALTED;

wire [31:0] EX_MEM_ALUOut1;
wire [31:0] EX_MEM_ALUOut_nand;
wire [31:0] EX_MEM_ALUOut_nor;
wire carry_neg;
wire [31:0] ID_EX_A1;
wire [31:0] ID_EX_B1;
wire  Cin;
reg  [31:0]EX_MEM_ALUOut_reg;
reg  [31:0]EX_MEM_ALUOut_nand_reg;
reg  [31:0]EX_MEM_ALUOut_nor_reg;
wire  gt,lt,eq;
reg   gt_reg,lt_reg,eq_reg;


assign Cin = ((ID_EX_IR[31:26] == SUB) || (ID_EX_IR[31:26]== SUBI))? 1'b1: 1'b0; 

assign ID_EX_B1= (ID_EX_type == RR_ALU)? ID_EX_B : ID_EX_Imm ;

assign ID_EX_A1= ID_EX_A;
// instantiation
carrylookahead_32b   carry1(EX_MEM_ALUOut1,carry_neg,ID_EX_A1,ID_EX_B1,Cin);
nand_32b             nand1(EX_MEM_ALUOut_nand,ID_EX_B1,ID_EX_A1);
nor_32b                nor1(EX_MEM_ALUOut_nor,ID_EX_B1,ID_EX_A1);
comparator_gt_32_bit   comp1(gt,lt,eq,ID_EX_A1,ID_EX_B1);
always@(EX_MEM_ALUOut1)

begin
EX_MEM_ALUOut_reg = EX_MEM_ALUOut1;
end

always@(EX_MEM_ALUOut_nand)                     //nand_operation

begin
EX_MEM_ALUOut_nand_reg = EX_MEM_ALUOut_nand;
end

always@(EX_MEM_ALUOut_nor)                     //nand_operation

begin
EX_MEM_ALUOut_nor_reg = EX_MEM_ALUOut_nor;
end

always@(gt or lt or eq)
begin
gt_reg = gt;
lt_reg = lt;
eq_reg = eq;
end

always @(posedge clk1)  //fetch
if(HALTED==0)
begin 
IF_ID_IR <=  Mem[PC];
IF_ID_NPC <=  PC+1;
PC <=  PC+1;
end
always @(posedge clk2)     ///decode
if(HALTED==0)
begin
if(IF_ID_IR[25:21] == 5'b00000) ID_EX_A <= 0;
else ID_EX_A <=  Reg[IF_ID_IR[25:21]];
if(IF_ID_IR[20:16] == 5'b00000) ID_EX_B <=0;
else ID_EX_B <=  Reg[IF_ID_IR[20:16]];
ID_EX_NPC <=  IF_ID_NPC;
ID_EX_IR <=  IF_ID_IR;
ID_EX_Imm <=  {{16{IF_ID_IR[15]}}, {IF_ID_IR[15:0]}};
case (IF_ID_IR[31:26])
ADD:ID_EX_type <=  RR_ALU;
SUB:ID_EX_type <=  RR_ALU;
NAND:ID_EX_type <= RR_ALU;
NOR:ID_EX_type <=  RR_ALU;
SLT:ID_EX_type <=  RR_ALU;
SGT:ID_EX_type <=  RR_ALU;
SET:ID_EX_type <=  RR_ALU;

ADDI:ID_EX_type <=  RM_ALU;
SUBI:ID_EX_type <=  RM_ALU;
SLTI: ID_EX_type <=  RM_ALU;
SETI: ID_EX_type <=  RM_ALU;
LW: ID_EX_type <=  LOAD;
SW: ID_EX_type <=  STORE;

HLT: ID_EX_type <=  HALT;
default: ID_EX_type <=  HALT;
endcase
end
always @(posedge clk1)   //execute
if(HALTED ==0)
begin
EX_MEM_type <=  ID_EX_type;
EX_MEM_IR <=  ID_EX_IR;

case (ID_EX_type)
RR_ALU: begin
case(ID_EX_IR[31:26])
ADD: EX_MEM_ALUOut <=  EX_MEM_ALUOut_reg;//ID_EX_A + ID_EX_B;
SUB: EX_MEM_ALUOut <=  EX_MEM_ALUOut_reg;//ID_EX_A - ID_EX_B;
NAND: EX_MEM_ALUOut <=  EX_MEM_ALUOut_nand_reg;//ID_EX_A & ID_EX_B;
NOR: EX_MEM_ALUOut  <=  EX_MEM_ALUOut_nor_reg;//ID_EX_A | ID_EX_B;
SLT: EX_MEM_ALUOut <=  lt_reg;//ID_EX_A < ID_EX_B;
SGT: EX_MEM_ALUOut <=  gt_reg;
SET: EX_MEM_ALUOut <=  eq_reg;

default: EX_MEM_ALUOut <= 32'hxxxxxxxx;
endcase 
end
RM_ALU: begin
case(ID_EX_IR[31:26])
ADDI: EX_MEM_ALUOut <= EX_MEM_ALUOut_reg; //ID_EX_A + ID_EX_Imm;
SUBI: EX_MEM_ALUOut <= EX_MEM_ALUOut_reg; //ID_EX_A - ID_EX_Imm;
SLTI: EX_MEM_ALUOut <=  gt_reg;
SETI: EX_MEM_ALUOut <=  eq_reg;
default: EX_MEM_ALUOut <=  32'hxxxxxxxx;
endcase
end
LOAD:
begin
EX_MEM_ALUOut <= EX_MEM_ALUOut_reg; //ID_EX_A + ID_EX_Imm;
EX_MEM_B <=  ID_EX_B;
end
STORE:
begin
EX_MEM_ALUOut <=  EX_MEM_ALUOut_reg; //ID_EX_A + ID_EX_Imm;
EX_MEM_B <=  ID_EX_B;
end

endcase 
end

always @(posedge clk2)  //memory
if(HALTED ==0)
begin
MEM_WB_type <=  EX_MEM_type;
MEM_WB_IR <=  EX_MEM_IR;
case(EX_MEM_type)
RR_ALU:MEM_WB_ALUOut <=  EX_MEM_ALUOut;
RM_ALU:MEM_WB_ALUOut <=  EX_MEM_ALUOut;
LOAD: MEM_WB_LMD <=  Mem[EX_MEM_ALUOut];
STORE: 
            begin
            Mem[EX_MEM_ALUOut] <=  EX_MEM_B;
            end

endcase
end
always @(posedge clk1)    
begin


case(MEM_WB_type)
RR_ALU: Reg[MEM_WB_IR[15:11]] <= MEM_WB_ALUOut;
RM_ALU: Reg[MEM_WB_IR[20:16]] <=  MEM_WB_ALUOut;
LOAD: Reg[MEM_WB_IR[20:16]] <=  MEM_WB_LMD;
HALT: HALTED <= 1'b1;

endcase
end
endmodule
