module ALU_UNIT(
input [15:0]A,B,
input [3:0]ALU_FUN_in, //its value not known-->> ALU_OUT=16'b0

input clk,
output Arith_flag, Logic_flag, CMP_flag, Shift_flag,
output reg [15:0] ALU_OUT
);
  parameter ADD=0, SUB=1, MUL=2, DIV=3, AND=4, OR=5, NAND=6, 
    NOR=7, XOR=8, XNOR=9, CMPEQ=10, CMPGT=11, CMPLE=12,
    SHR=13, SHL=14;

  
  
  reg [15:0]Areg,Breg; //registers to isolate the operands A,B for a better power performance
  reg [3:0]ALU_FUN;
  reg [15:0] ALU_OUT_registered;
  
  wire subFlag;
  wire [15:0]  Result, addendOrSubbed;
  
  assign Arith_flag=(ALU_FUN[3]==0 & ALU_FUN[2] == 0) ?1:0;
  assign Logic_flag=( ( ALU_FUN[2] == 1 &&ALU_FUN[3]==0)  || (ALU_FUN[3]==1 && ALU_FUN[2] == 0 && ALU_FUN[1] == 0) )?1:0;
  assign CMP_flag=(ALU_FUN == 4'b1010 ||ALU_FUN == 4'b1011 ||ALU_FUN == 4'b1100)?1:0;
  assign Shift_flag=(ALU_FUN == 4'b1101 || ALU_FUN == 4'b1110)?1:0;
  
  always@(posedge clk)
  begin
    Areg<=A;
    Breg<=B;
    ALU_FUN<=ALU_FUN_in;
    ALU_OUT_registered<=ALU_OUT;
  end
  
  assign subFlag=(ALU_FUN == 4'b0000)? 0:1;
  
  assign addendOrSubbed=Breg ^ {16 {subFlag}};
  assign Result=Areg+addendOrSubbed+subFlag;
  
  //parameter ADD=0, SUB=1, MUL=2, DIV=3, AND=4, OR=5, NAND=6, 
    //NOR=7, XOR=8, XNOR=9, CMPEQ=10, CMPGT=11, CMPLE=12,
    //SHR=13, SHL=14;
  
  always@(*)
  begin 
    
    case(ALU_FUN)
      ADD:ALU_OUT=Result;
      SUB: ALU_OUT=Result;
      
      MUL: ALU_OUT=Areg*Breg;
      DIV: ALU_OUT=Areg/Breg;
      AND: ALU_OUT=Areg&Breg;
      OR: ALU_OUT=Areg|Breg;
      NOR: ALU_OUT=~(Areg|Breg);
      NAND: ALU_OUT=~(Areg&Breg);
      XOR: ALU_OUT=Areg^Breg;
      XNOR: ALU_OUT=~(Areg^Breg);
      
      CMPEQ:begin if(Areg==Breg) ALU_OUT=1; else ALU_OUT=0; end
      CMPGT:begin if(Areg > Breg) ALU_OUT=2; else ALU_OUT=0; end
      CMPLE:begin if(Areg < Breg) ALU_OUT=3; else ALU_OUT=0; end
      SHR: ALU_OUT=A>>1;
      SHL: ALU_OUT=A<<1;
      default:ALU_OUT=16'b0;
    endcase
      
    
    
  end
  
  
endmodule
