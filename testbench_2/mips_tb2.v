
//Purpose of this test case
// Load a word stored in memory location 120, add 45 to it, and store
// the result in memory location 121
//Steps
//1.Initialize registers R1 with memory address 120
//2.Load contents of memory location 120 into registers R2.
//3.Add 45 to register R2.
//4.Store the result in memory location 121.



module test_mips32_2;

    reg clk1, clk2;

    integer k;

    pipe_mips32 mips (clk1, clk2);
    
    initial begin    //generating 2 phase clock
        clk1=0; clk2=0;
        repeat(20)
        begin
            #5 clk1=1;  #5 clk1=0;
            #5 clk2=1;  #5 clk2=0;
        end
    end

    initial
    begin
        for(k=0;k<31;k++)
            mips.Reg[k]=k;

        mips.Mem[0] = 32'h28010078;     //ADDI R1,R0,120
        mips.Mem[1] = 32'h0c631800;     //OR R3,R3,R3   DUMMY INSTR
        mips.Mem[2] = 32'h20220000;     //LW R2,0(R1)
        mips.Mem[3] = 32'h0c631800;     //OR R3,R3,R3   DUMMY INSTR
        mips.Mem[4] = 32'h2842002d;     //ADDI R2,R2,45
        mips.Mem[5] = 32'h0c631800;     //OR R3,R3,R3   DUMMY INSTR
        mips.Mem[6] = 32'h24220001;     //SW R2,1(R1)
        mips.Mem[7] = 32'hfc000000;     //HLT

        mips.Mem[120] = 85;

        mips.PC=0;
        mips.HALTED=0;
        mips.TAKEN_BRANCH=0;

        #500 $display ("Mem[120]: %4d \nMem[121]: %4d",mips.Mem[120], mips.Mem[121]);
        
    end

    initial
    begin
        $dumpfile ("mips2.vcd");
        $dumpvars(0, test_mips32_2);
        #600 $finish;
    end
endmodule
    
        
