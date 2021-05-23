module mux(out,a,b);
    output out;
    input [3:0] a;
    input [1:0] b;

    assign out=(a[3]&(b[0])&(b[1])) | (a[2]&(~b[0])&(b[1])) | (a[1]&(b[0])&(~b[1])) | (a[0]&(~b[0])&(~b[1]));
endmodule

module LUT(out,ctrl,mem);
    output out;
    input [4:0] ctrl;
    input [31:0] mem;
    wire [7:0] stage1;
    wire w1,w2;

    mux a1(stage1[0],mem[3:0],ctrl[1:0]);
    mux a2(stage1[1],mem[7:4],ctrl[1:0]);
    mux a3(stage1[2],mem[11:8],ctrl[1:0]);
    mux a4(stage1[3],mem[15:12],ctrl[1:0]);
    mux a5(stage1[4],mem[19:16],ctrl[1:0]);
    mux a6(stage1[5],mem[23:20],ctrl[1:0]);
    mux a7(stage1[6],mem[27:24],ctrl[1:0]);
    mux a8(stage1[7],mem[31:28],ctrl[1:0]);

    mux u2(w1,stage1[3:0],ctrl[3:2]);
    mux u3(w2,stage1[7:4],ctrl[3:2]);

    assign out=(w2)&(ctrl[4])|(w1)&(~ctrl[4]);
endmodule

module logic_tile(out, clock, in5, in4, in3, in2, in1);
    output out;
    input clock,in1,in2,in3,in4,in5;

    reg [32:0] mem;
    wire intermediate; 
    reg ffout;

    initial
        begin
            ffout=0;
        end

    wire [4:0] ctrl;
    assign ctrl[4]=in5;
    assign ctrl[3]=in4;
    assign ctrl[2]=in3;
    assign ctrl[1]=in2;
    assign ctrl[0]=in1;

    LUT u4(intermediate,ctrl,mem[31:0]);

    always @(posedge clock)
    begin
        ffout<=intermediate;
    end

    assign out=(ffout)&(mem[32])|(intermediate)&(~mem[32]);
endmodule

module switch_box_4x4 (out,in);
    output [3:0] out;
    input [3:0] in;
    reg [15:0] configure;
    reg [3:0] out;
    
    always @(*)
    begin
        out[0] = (in[0] & configure[0]) | (in[1] & configure[1]) | (in[2] & configure[2]) | (in[3] & configure[3]);
        out[1] = (in[0] & configure[4]) | (in[1] & configure[5]) | (in[2] & configure[6]) | (in[3] & configure[7]);
        out[2] = (in[0] & configure[8]) | (in[1] & configure[9]) | (in[2] & configure[10]) | (in[3] & configure[11]);
        out[3] = (in[0] & configure[12]) | (in[1] & configure[13]) | (in[2] & configure[14]) | (in[3] & configure[15]);
    end
endmodule

module FPGA(out,clock,i);
    output [1:8] out;
    input [1:9] i;
    input clock;
    wire [0:23] a;
    wire [0:3] c;

    switch_box_4x4 sb1(a[0:3],{i[4],i[8],i[9],out[8]});
    switch_box_4x4 sb2(a[4:7],{i[4],i[8],i[3],i[7]});
    switch_box_4x4 sb3(a[8:11],{i[4],i[8],i[2],i[6]});
    switch_box_4x4 sb4(a[12:15],{i[4],i[8],i[1],i[5]});

    logic_tile l1(out[8],clock,a[0],a[1],a[2],1'b0,1'b0);
    logic_tile l2(c[0],clock,a[0],a[1],a[2],1'b0,1'b0);

    switch_box_4x4 sb5(a[16:19],{out[6],c[1],c[0],out[7]});

    logic_tile l3(out[7],clock,a[4],a[5],a[2],a[17],a[16]);
    logic_tile l4(c[1],clock,a[4],a[5],a[2],a[17],a[16]);

    logic_tile l5(out[6],clock,a[8],a[9],a[2],a[17],a[16]);
    logic_tile l6(c[2],clock,a[8],a[9],a[2],a[17],a[16]);

    switch_box_4x4 sb6(a[20:23],{c[1],c[2],out[5],i[9]});

    logic_tile l7(out[5],clock,a[12],a[13],a[20],a[21],a[22]);
    logic_tile l8(c[3],clock,a[12],a[13],a[20],a[21],a[22]);

    switch_box_4x4 sb7(out[1:4],{c[2],c[1],c[0],c[3]});
endmodule