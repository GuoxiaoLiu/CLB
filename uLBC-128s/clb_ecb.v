`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:24:30 01/13/2019 
// Design Name: 
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
	input [127:0]key,
	output [127:0]textout,
	output enable
	);
	//output reg done;
	parameter pi=200'ha0ac9329ac4bc991c2313219c193ca814420cb8b49cc9ba800;
	reg [5:0]r;
	wire [5:0] next_r;

	
	reg [127:0]rk;
	reg [5:0]lfsr;
	//wire [5:0]cst;
    
	
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
            rk <= key;
            Fr <= textin;
            lfsr<=6'h20;
        end
		else if (r >= 20) begin
		end
		else begin
		    Fr <= en_out_m;
            rk <= {rk[55-:4], rk[127-:4], rk[111-:4], rk[67-:4], rk[51-:4], rk[123-:4], rk[107-:4], rk[71-:4], rk[27-:4], rk[39-:4], rk[79-:4], rk[91-:4], rk[31-:4], rk[35-:4], rk[75-:4], rk[95-:4], rk[3-:4], rk[115-:4], rk[23-:4], rk[59-:4], rk[7-:4], rk[119-:4], rk[19-:4], rk[63-:4], rk[83-:4], rk[103-:4], rk[47-:4], rk[11-:4], rk[87-:4], rk[99-:4], rk[43-:4], rk[15-:4]};
            lfsr <= {lfsr[0]^lfsr[1]^1, lfsr[5:1]};
		end
	end

	assign F_in = Fr ^ rk;
	SubByte sbox_F(F_in, en_out_s);
    //assign en_out_c =  {en_out_s[127-:8] ^ Const[(255 - r*8)-:8], en_out_s[119-:8]^ 8'h5a, en_out_s[111:0]};
	assign en_out_c =  {en_out_s[127-:8] ^ {lfsr,2'h0}, en_out_s[119-:16]^ 16'hc5c5, en_out_s[103-:8] ^ pi[(199-r*8)-:8], en_out_s[95:0]};
	PosPerm P_F(en_out_c, en_out_p);
	MixColumn mx_F(en_out_p, en_out_m);
	
	
	assign textout = (r==20)?F_in:0;
	
	assign enable = (r==20)?1:0;


endmodule