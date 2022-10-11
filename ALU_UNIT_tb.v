`timescale 1us/1ns

module ALU_UNIT_tb();
  
  reg [15:0]A_tb,B_tb;
  reg [3:0]ALU_FUN_tb;  
  reg clk_tb;
  
  wire Arith_flag, Logic_flag, CMP_flag, Shift_flag;
  wire signed [15:0] ALU_OUT_tb;
  
  Assignment3 ALU( .A(A_tb), .B(B_tb), .ALU_FUN_in(ALU_FUN_tb),
   .clk(clk_tb), .ALU_OUT(ALU_OUT_tb),
    .Arith_flag(Arith_flag), .Logic_flag(Logic_flag),
    .CMP_flag(CMP_flag), .Shift_flag(Shift_flag));
  
  always #5 clk_tb=~clk_tb;
  
  initial
  begin
    $dumpfile("ALU.vcd");
    $dumpvars;
    
    clk_tb=1'b0;
    
    
    
    #3 $display("test1");  //3
    A_tb=1;
    B_tb=0;
    ALU_FUN_tb=4'b1111;
    #4 if(ALU_OUT_tb == 0)
         $display("test1 is passed");
       else
         $display("test1 failed, ALU_OUT!=0 @ ALU_FUN_tb=4'b1111");
         
    #5
    
    #2 $display("test2, adding");  //14
    A_tb=16'b0000000000000001;
    B_tb=16'b0000000000000011;
    ALU_FUN_tb=4'b0000;
    #4 if(ALU_OUT_tb == 16'b100 && Arith_flag==1)
         $display("test2 is passed");
       else
         $display("test2 failed, ALU_OUT!=4 @ a=1, b=3 %d" ,ALU_OUT_tb);
    
    
    #5     
      
    #2 $display("test3, adding +ve no. & -ve no.");  //25
    A_tb=16'b1111111111111110;
    B_tb=16'b0000000000000011;
    ALU_FUN_tb=4'b0000;
    #4 if(ALU_OUT_tb == 16'b1 && Arith_flag==1)
         $display("test3 is passed");
       else
         $display("test3 failed, ALU_OUT!=1 @ a=-2, b=3 ");
       
         
    #5     
      
    #2 $display("test4, sub");  //36
    A_tb=16'b0000000000001010;
    B_tb=16'b0000000000000011;
    ALU_FUN_tb=4'b0001;
    #10 if(ALU_OUT_tb == 16'b111 && Arith_flag==1)
         $display("test4 is passed");
       else
         $display("test4 failed, ALU_OUT!=7 @ a=10, b=3");
         
    #5     
      
    #2 $display("test5, unsigned_Mul");  //53
    A_tb=16'b0000000000001010;
    B_tb=16'b0000000000000011;
    ALU_FUN_tb=4'b0010;
    #4 if(ALU_OUT_tb == 30 && Arith_flag==1)
         $display("test5 is passed");
       else
         $display("test4 failed, ALU_OUT!=30 @ a=10, b=3");
         
    
    #5   
      
    #2 $display("test6, signed_Mul");  //58
    A_tb=16'b0000000000001010;
    B_tb=16'b1111111111111101;
    ALU_FUN_tb=4'b0010;
    #8 if(ALU_OUT_tb == -30 && Arith_flag==1)
         $display("test6 is passed");
       else
         $display("test6 failed, ALU_OUT!=-30 @ a=10, b=-3 %d", ALU_OUT_tb);
    
    #3
    
    #2 $display("test7, 5&10");  //71
    A_tb=16'b1010;
    B_tb=16'b0101;
    ALU_FUN_tb=4'b0100;
    #10 if(ALU_OUT_tb == 0 && Logic_flag==1)
         $display("test7 is passed");
       else
         $display("test7 failed, ALU_OUT!=0 @ a=10, b=5 %d", ALU_OUT_tb);
    
    #3
    
    #2 $display("test8, 5||10");  //81
    A_tb=16'b0000000000001010;
    B_tb=16'b0000000000000101;
    ALU_FUN_tb=4'b0101;
    #5 if(ALU_OUT_tb == 16'b0000000000001111 && Logic_flag==1)
         $display("test8 is passed");
       else
         $display("test8 failed, ALU_OUT!=15 @ a=10, b=5 %d", ALU_OUT_tb);
    
    #3
    
    #2 $display("test9, ~(5&10)");  //58
    A_tb=16'b1010;
    B_tb=16'b0101;
    ALU_FUN_tb=4'b0110;
    #5 if(ALU_OUT_tb == -1 && Logic_flag==1)
         $display("test9 is passed");
       else
         $display("test9 failed, ALU_OUT!=-1 @ a=10, b=5 %d", ALU_OUT_tb);
    
    #3
    
    #2 $display("test10, ~(15|10)");  //58
    A_tb=16'b1111;
    B_tb=16'b1010;
    ALU_FUN_tb=4'b0111;
    #5 if(ALU_OUT_tb == -16 && Logic_flag==1)
         $display("test10 is passed");
       else
         $display("test10 failed, ALU_OUT!=-16 @ a=15, b=10 %d", ALU_OUT_tb);

    #3
    
    #2 $display("test12, 15^10");  //58
    A_tb=16'b1111;
    B_tb=16'b1010;
    ALU_FUN_tb=4'b1000;
    #5 if(ALU_OUT_tb == 5 && Logic_flag==1)
         $display("test12 is passed");
       else
         $display("test12 failed, ALU_OUT!=5 @ a=15, b=10 %d", ALU_OUT_tb);



    #3
    
    #2 $display("test11, ~(15^10)");  //58
    A_tb=16'b1111;
    B_tb=16'b1010;
    ALU_FUN_tb=4'b1001;
    #5 if(ALU_OUT_tb == -6 && Logic_flag==1)
         $display("test11 is passed");
       else
         $display("test11 failed, ALU_OUT!=5 @ a=15, b=10 %d", ALU_OUT_tb);

    #3
    
    #2 $display("test13, CMP_EQ");  //58
    A_tb=16'b1111;
    B_tb=16'b1111;
    ALU_FUN_tb=4'b1010;
    #5 if(ALU_OUT_tb == 1 && CMP_flag==1)
         $display("test13 is passed");
       else
         $display("test13 failed, ALU_OUT!=1 @ a And b are equal %d", ALU_OUT_tb);
   
   #5
   
   #2 $display("test14, CMP_GT");  //58
    A_tb=16'b1111;
    B_tb=16'b1101;
    ALU_FUN_tb=4'b1011;
    #5 if(ALU_OUT_tb == 2 && CMP_flag==1)
         $display("test14 is passed");
       else
         $display("test14 failed, ALU_OUT!=2 @ a=15, b=13 %d", ALU_OUT_tb);
    
    #5
    
    #2 $display("test14, CMP_LT");  //58
    A_tb=16'b1100;
    B_tb=16'b1101;
    ALU_FUN_tb=4'b1100;
    #10 if(ALU_OUT_tb == 3 && CMP_flag==1)
         $display("test14 is passed");
       else
         $display("test14 failed, ALU_OUT!=3 @ a=12, b=13 %d", ALU_OUT_tb);
    
    
    #5
    
    #2 $display("test15, SHR");  //58
    A_tb=16'b1100;
    B_tb=16'b1101;
    ALU_FUN_tb=4'b1101;
    #10 if(ALU_OUT_tb == 6 && Shift_flag==1)
         $display("test15 is passed");
       else
         $display("test15 failed, ALU_OUT!=6 @ a=12 %d", ALU_OUT_tb);
         
    #5
    
    #2 $display("test16, CMP_LT");  //58
    A_tb=16'b1100;
    B_tb=16'b1101;
    ALU_FUN_tb=4'b1100;
    #10 if(ALU_OUT_tb == 3 && CMP_flag==1)
         $display("test16 is passed");
       else
         $display("test16 failed, ALU_OUT!=14 @ a=12 %d", ALU_OUT_tb);
         
    #5
    
    #2 $display("test17, DIV: 2 divisible numbers");  //58
    A_tb=16'b1100;
    B_tb=16'b0010;
    ALU_FUN_tb=4'b0011;
    #10 if(ALU_OUT_tb == 6 && Arith_flag==1)
         $display("test17 is passed");
       else
         $display("test17 failed, ALU_OUT!=6 @ a=12, b=2 %d", ALU_OUT_tb);
    
    
    #5
    
    #2 $display("test18, DIV: 2 non-divisible numbers");  //58
    A_tb=16'b1100;
    B_tb=16'b0101;
    ALU_FUN_tb=4'b0011;
    #10 if(ALU_OUT_tb ==2  && Arith_flag==1)
         $display("test17 is passed");
       else
         $display("test17 failed, ALU_OUT!=14 @ a=12 %d", ALU_OUT_tb);
    
    
    
             
    #300
    $finish;
    
  end
endmodule 
