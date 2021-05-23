module decoder_tb ();
    reg clock;
    reg [0:2] a;
    wire [1:8] out;
    reg [31:0] memo [0:15];

    initial clock=1'b0;
    always #10 clock=~clock;
    initial #100 $finish;

    FPGA decoder_inst(out,clock,{1'b0,1'b0,1'b0,a[0],1'b0,1'b0,1'b0,a[1],a[2]});

    initial
    begin
        $readmemh("decodermem.mem",memo);
        decoder_inst.l1.mem[31:0]=memo[0];
        decoder_inst.l1.mem[32]=memo[15][31];
        decoder_inst.l2.mem[31:0]=memo[1];
        decoder_inst.l2.mem[32]=memo[15][30];
        decoder_inst.l3.mem[31:0]=memo[2];
        decoder_inst.l3.mem[32]=memo[15][29];
        decoder_inst.l4.mem[31:0]=memo[3];
        decoder_inst.l4.mem[32]=memo[15][28];
        decoder_inst.l5.mem[31:0]=memo[4];
        decoder_inst.l5.mem[32]=memo[15][27];
        decoder_inst.l6.mem[31:0]=memo[5];
        decoder_inst.l6.mem[32]=memo[15][26];
        decoder_inst.l7.mem[31:0]=memo[6];
        decoder_inst.l7.mem[32]=memo[15][25];
        decoder_inst.l8.mem[31:0]=memo[7];
        decoder_inst.l8.mem[32]=memo[15][24];

        decoder_inst.sb1.configure=memo[8];
        decoder_inst.sb2.configure=memo[9];
        decoder_inst.sb3.configure=memo[10];
        decoder_inst.sb4.configure=memo[11];
        decoder_inst.sb5.configure=memo[12];
        decoder_inst.sb6.configure=memo[13];
        decoder_inst.sb7.configure=memo[14];

        a=3'b111;
        #10
        $display("a:%b, out:%b",a,out);

        a=3'b110;
        #10
        $display("a:%b, out:%b",a,out);

        a=3'b101;
        #10
        $display("a:%b, out:%b",a,out);

        a=3'b100;
        #10
        $display("a:%b, out:%b",a,out);

        a=3'b011;
        #10
        $display("a:%b, out:%b",a,out);

        a=3'b010;
        #10
        $display("a:%b, out:%b",a,out);

        a=3'b001;
        #10
        $display("a:%b, out:%b",a,out);

        a=3'b000;
        #10
        $display("a:%b, out:%b",a,out);
    end

    initial
    begin
      $dumpfile("decoderresult.vcd");
      $dumpvars;
    end
endmodule