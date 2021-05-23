module counter_tb ();
    reg clock,c,d;
    wire [1:8] out;
    reg [31:0] memo [0:15];

    initial clock=1'b0;
    always #10 clock=~clock;
    initial #1000 $finish;

    FPGA cntr_inst(out,clock,{1'b0,1'b0,1'b0,c,1'b0,1'b0,1'b0,d,1'b0});

    initial
    begin
        $readmemh("countermem.mem",memo);
        cntr_inst.l1.mem[31:0]=memo[0];
        cntr_inst.l1.mem[32]=memo[15][31];
        cntr_inst.l2.mem[31:0]=memo[1];
        cntr_inst.l2.mem[32]=memo[15][30];
        cntr_inst.l3.mem[31:0]=memo[2];
        cntr_inst.l3.mem[32]=memo[15][29];
        cntr_inst.l4.mem[31:0]=memo[3];
        cntr_inst.l4.mem[32]=memo[15][28];
        cntr_inst.l5.mem[31:0]=memo[4];
        cntr_inst.l5.mem[32]=memo[15][27];
        cntr_inst.l6.mem[31:0]=memo[5];
        cntr_inst.l6.mem[32]=memo[15][26];
        cntr_inst.l7.mem[31:0]=memo[6];
        cntr_inst.l7.mem[32]=memo[15][25];
        cntr_inst.l8.mem[31:0]=memo[7];
        cntr_inst.l8.mem[32]=memo[15][24];

        cntr_inst.sb1.configure=memo[8];
        cntr_inst.sb2.configure=memo[9];
        cntr_inst.sb3.configure=memo[10];
        cntr_inst.sb4.configure=memo[11];
        cntr_inst.sb5.configure=memo[12];
        cntr_inst.sb6.configure=memo[13];
        cntr_inst.sb7.configure=memo[14];

        c=1'b0; d=1'b1;
        #11
        $display("c:%b, d:%b, out:%b",c,d,out[5:8]);

        c=1'b1; d=1'b0;
        #20
        $display("c:%b, d:%b, out:%b",c,d,out[5:8]);

        c=1'b1; d=1'b0;
        #20
        $display("c:%b, d:%b, out:%b",c,d,out[5:8]);

        c=1'b1; d=1'b0;
        #20
        $display("c:%b, d:%b, out:%b",c,d,out[5:8]);

        c=1'b1; d=1'b0;                
        #20
        $display("c:%b, d:%b, out:%b",c,d,out[5:8]);

        c=1'b0; d=1'b1;
        #20
        $display("c:%b, d:%b, out:%b",c,d,out[5:8]);

        c=1'b0; d=1'b1;
        #20
        $display("c:%b, d:%b, out:%b",c,d,out[5:8]);

        c=1'b0; d=1'b0;
        #20
        $display("c:%b, d:%b, out:%b",c,d,out[5:8]);

        c=1'b0; d=1'b1;
        #20
        $display("c:%b, d:%b, out:%b",c,d,out[5:8]);
    end

    initial
    begin
      $dumpfile("counterresult.vcd");
      $dumpvars;
    end
endmodule