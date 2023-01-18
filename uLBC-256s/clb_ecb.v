`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:24:30 01/13/2019 
// Design Name: 256
// Module Name:    top   
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clb_ecb(
	input clk,
	input rst,
	//input mode,
	//input [4:0]blocknum;
	input [127:0]textin,
	input [255:0]key,
	output [127:0]textout,
	output enable
	);
	//output reg done;
	parameter pi=256'h00a0ac9329ac4bc991c2313219c193ca814420cb8b49cc9ba882c104ba4a2200;
	//reg [239:0]cstr;
	reg [5:0]r;
	wire [5:0] next_r;

	
	reg [127:0]rk0;
    reg [127:0]rk1;
    reg [5:0]lfsr;
    
    //reg [255:0]dkey;
    
	
	reg [127:0]Fr;
	wire [127:0]F_in;
	
	wire [127:0]en_out_s;//subbyte
	wire [127:0]en_out_c;//addconstant
	wire [127:0]en_out_p;//posperm
	wire [127:0]en_out_m;//mixcolumn
	

	assign next_r = r+1;
	
	always@(posedge clk or negedge rst) begin
		if(!rst) begin
			r <= 0;
		end
		else if (r >= 24) begin
		end
		else begin
			r <= next_r;
		end
	end
	
	
	always@(posedge clk or negedge rst) begin
///ENC
        if (!rst) begin
            rk0 <= key[255:128];
            rk1 <= key[127:0];
            Fr <= textin;
            lfsr <= 6'h20;
        end
		else if (r >= 30) begin
		end
		else begin
		    rk0 <= {rk0[55-:4], rk0[127-:4], rk0[111-:4], rk0[67-:4], rk0[51-:4], rk0[123-:4], rk0[107-:4], rk0[71-:4], rk0[27-:4], rk0[39-:4], rk0[79-:4], rk0[91-:4], rk0[31-:4], rk0[35-:4], rk0[75-:4], rk0[95-:4], rk0[3-:4], rk0[115-:4], rk0[23-:4], rk0[59-:4], rk0[7-:4], rk0[119-:4], rk0[19-:4], rk0[63-:4], rk0[83-:4], rk0[103-:4], rk0[47-:4], rk0[11-:4], rk0[87-:4], rk0[99-:4], rk0[43-:4], rk0[15-:4]};
            rk1 <= {rk1[55]^rk1[52], rk1[55-:3], rk1[127]^rk1[124], rk1[127-:3], rk1[111]^rk1[108], rk1[111-:3], rk1[67]^rk1[64], rk1[67-:3], rk1[51]^rk1[48], rk1[51-:3], rk1[123]^rk1[120], rk1[123-:3], rk1[107]^rk1[104], rk1[107-:3], rk1[71]^rk1[68], rk1[71-:3], rk1[27]^rk1[24], rk1[27-:3], rk1[39]^rk1[36], rk1[39-:3], rk1[79]^rk1[76], rk1[79-:3], rk1[91]^rk1[88], rk1[91-:3], rk1[31]^rk1[28], rk1[31-:3], rk1[35]^rk1[32], rk1[35-:3], rk1[75]^rk1[72], rk1[75-:3], rk1[95]^rk1[92], rk1[95-:3], rk1[3]^rk1[0], rk1[3-:3], rk1[115]^rk1[112], rk1[115-:3], rk1[23]^rk1[20], rk1[23-:3], rk1[59]^rk1[56], rk1[59-:3], rk1[7]^rk1[4], rk1[7-:3], rk1[119]^rk1[116], rk1[119-:3], rk1[19]^rk1[16], rk1[19-:3], rk1[63]^rk1[60], rk1[63-:3], rk1[83]^rk1[80], rk1[83-:3], rk1[103]^rk1[100], rk1[103-:3], rk1[47]^rk1[44], rk1[47-:3], rk1[11]^rk1[8], rk1[11-:3], rk1[87]^rk1[84], rk1[87-:3], rk1[99]^rk1[96], rk1[99-:3], rk1[43]^rk1[40], rk1[43-:3], rk1[15]^rk1[12], rk1[15-:3]};
            Fr <= en_out_m;	
            lfsr <= {lfsr[0]^lfsr[1]^1, lfsr[5:1]};r[0] <= lfsr[0]^lfsr[5]^1;
		end
	end

	assign F_in = Fr ^ rk0 ^ rk1;
	
	//enc
	SubByte sbox_F(F_in, en_out_s);
    //assign en_out_c =  {en_out_s[127-:8] ^ {lfsr,2'h0}, en_out_s[119-:16]^ 16'ha3a3, en_out_s[103-:8] ^ cstr[239-:8], en_out_s[95:0]};
    assign en_out_c =  {en_out_s[127-:8] ^ {lfsr,2'h0}, en_out_s[119-:16]^ 16'h3c3c, en_out_s[103-:8] ^ pi[(255-r*8 -8)-:8], en_out_s[95:0]};
	PosPerm P_F(en_out_c, en_out_p);
	MixColumn mx_F(en_out_p, en_out_m);

	
	assign textout = (r==24)?F_in:0;
	
	assign enable = (r==24)?1:0;


endmodule