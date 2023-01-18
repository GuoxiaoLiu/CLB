`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tsinghua University
// Engineer: Tianshuo Cong
// 
// Create Date:    20:50:54 01/14/2019 
// Design Name: 
// Module Name:    sbox 
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
module PosPerm(
	input [127:0]p_in,
	output [127:0]p_out
	);

	assign p_out[127:124]=p_in[127:124];
    assign p_out[123:120]=p_in[27:24];
    assign p_out[119:116]=p_in[55:52];
    assign p_out[115:112]=p_in[67:64];
    assign p_out[111:108]=p_in[111:108];
    assign p_out[107:104]=p_in[123:120];
    assign p_out[103:100]=p_in[7:4];
    assign p_out[99:96]=p_in[51:48];
    assign p_out[95:92]=p_in[95:92];
    assign p_out[91:88]=p_in[11:8];
    assign p_out[87:84]=p_in[39:36];
    assign p_out[83:80]=p_in[99:96];
    assign p_out[79:76]=p_in[79:76];
    assign p_out[75:72]=p_in[91:88];
    assign p_out[71:68]=p_in[23:20];
    assign p_out[67:64]=p_in[35:32];
    assign p_out[63:60]=p_in[47:44];
    assign p_out[59:56]=p_in[107:104];
    assign p_out[55:52]=p_in[87:84];
    assign p_out[51:48]=p_in[3:0];
    assign p_out[47:44]=p_in[63:60];
    assign p_out[43:40]=p_in[75:72];
    assign p_out[39:36]=p_in[119:116];
    assign p_out[35:32]=p_in[19:16];
    assign p_out[31:28]=p_in[15:12];
    assign p_out[27:24]=p_in[59:56];
    assign p_out[23:20]=p_in[103:100];
    assign p_out[19:16]=p_in[115:112];
    assign p_out[15:12]=p_in[31:28];
    assign p_out[11:8]=p_in[43:40];
    assign p_out[7:4]=p_in[71:68];
    assign p_out[3:0]=p_in[83:80];
	
endmodule
