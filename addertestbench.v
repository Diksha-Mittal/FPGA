module adder_tb ();
    reg clock,c;
    reg [1:4] i1;
    reg [1:4] i2;
    wire [1:8] out;
    reg [31:0] memo [0:15];

    initial clock=1'b0;
    always #10 clock=~clock;
    initial #1000 $finish;

    FPGA adder_inst(out,clock,{i1[1],i1[2],i1[3],i1[4],i2[1],i2[2],i2[3],i2[4],c});

    initial
    begin
        $readmemh("addermem.mem",memo);
        adder_inst.l1.mem[31:0]=memo[0];
        adder_inst.l1.mem[32]=memo[15][31];
        adder_inst.l2.mem[31:0]=memo[1];
        adder_inst.l2.mem[32]=memo[15][30];
        adder_inst.l3.mem[31:0]=memo[2];
        adder_inst.l3.mem[32]=memo[15][29];
        adder_inst.l4.mem[31:0]=memo[3];
        adder_inst.l4.mem[32]=memo[15][28];
        adder_inst.l5.mem[31:0]=memo[4];
        adder_inst.l5.mem[32]=memo[15][27];
        adder_inst.l6.mem[31:0]=memo[5];
        adder_inst.l6.mem[32]=memo[15][26];
        adder_inst.l7.mem[31:0]=memo[6];
        adder_inst.l7.mem[32]=memo[15][25];
        adder_inst.l8.mem[31:0]=memo[7];
        adder_inst.l8.mem[32]=memo[15][24];

        adder_inst.sb1.configure=memo[8];
        adder_inst.sb2.configure=memo[9];
        adder_inst.sb3.configure=memo[10];
        adder_inst.sb4.configure=memo[11];
        adder_inst.sb5.configure=memo[12];
        adder_inst.sb6.configure=memo[13];
        adder_inst.sb7.configure=memo[14];

        i1=4'b0001; i2=4'b1100; c=1'b0;
        #20
        $display("i1:%b, i2:%b, carry-in:%b, carry:%b, out:%b",i1,i2,c,out[4],out[5:8]);

        i1=4'b0001; i2=4'b1100; c=1'b1;
        #20
        $display("i1:%b, i2:%b, carry-in:%b, carry:%b, out:%b",i1,i2,c,out[4],out[5:8]);

        i1=4'b0101; i2=4'b1101; c=1'b0;
        #20
        $display("i1:%b, i2:%b, carry-in:%b, carry:%b, out:%b",i1,i2,c,out[4],out[5:8]);

        i1=4'b0101; i2=4'b1101; c=1'b1;
        #20
        $display("i1:%b, i2:%b, carry-in:%b, carry:%b, out:%b",i1,i2,c,out[4],out[5:8]);

        i1=4'b1111; i2=4'b0001; c=1'b0;
        #20
        $display("i1:%b, i2:%b, carry-in:%b, carry:%b, out:%b",i1,i2,c,out[4],out[5:8]);

        i1=4'b1111; i2=4'b0011; c=1'b1;
        #20
        $display("i1:%b, i2:%b, carry-in:%b, carry:%b, out:%b",i1,i2,c,out[4],out[5:8]);

        i1=4'b1001; i2=4'b0001; c=1'b0;
        #20
        $display("i1:%b, i2:%b, carry-in:%b, carry:%b, out:%b",i1,i2,c,out[4],out[5:8]);

        i1=4'b1001; i2=4'b0011; c=1'b1;
        #20
        $display("i1:%b, i2:%b, carry-in:%b, carry:%b, out:%b",i1,i2,c,out[4],out[5:8]);
    end

    initial
    begin
      $dumpfile("adderresult.vcd");
      $dumpvars;
    end
endmodule