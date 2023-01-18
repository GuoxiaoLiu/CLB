`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:59:48 01/13/2019 
// Design Name: 
// Module Name:    MixWord 
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
module MixColumn(
	input [127:0]m_in,
	output [127:0]m_out
	);
	
	
	assign m_out[127:124]=m_in[123:120]^m_in[119:116]^m_in[115:112];
	assign m_out[123:120]=m_in[127:124]^m_in[119:116]^m_in[115:112];
	assign m_out[119:116]=m_in[127:124]^m_in[123:120]^m_in[115:112];
	assign m_out[115:112]=m_in[127:124]^m_in[123:120]^m_in[119:116];
	assign m_out[111:108]=m_in[107:104]^m_in[103:100]^m_in[99:96];
	assign m_out[107:104]=m_in[111:108]^m_in[103:100]^m_in[99:96];
	assign m_out[103:100]=m_in[111:108]^m_in[107:104]^m_in[99:96];
	assign m_out[99:96]=m_in[111:108]^m_in[107:104]^m_in[103:100];
	assign m_out[95:92]=m_in[91:88]^m_in[87:84]^m_in[83:80];
	assign m_out[91:88]=m_in[95:92]^m_in[87:84]^m_in[83:80];
	assign m_out[87:84]=m_in[95:92]^m_in[91:88]^m_in[83:80];
	assign m_out[83:80]=m_in[95:92]^m_in[91:88]^m_in[87:84];
	assign m_out[79:76]=m_in[75:72]^m_in[71:68]^m_in[67:64];
	assign m_out[75:72]=m_in[79:76]^m_in[71:68]^m_in[67:64];
	assign m_out[71:68]=m_in[79:76]^m_in[75:72]^m_in[67:64];
	assign m_out[67:64]=m_in[79:76]^m_in[75:72]^m_in[71:68];
	assign m_out[63:60]=m_in[59:56]^m_in[55:52]^m_in[51:48];
	assign m_out[59:56]=m_in[63:60]^m_in[55:52]^m_in[51:48];
	assign m_out[55:52]=m_in[63:60]^m_in[59:56]^m_in[51:48];
	assign m_out[51:48]=m_in[63:60]^m_in[59:56]^m_in[55:52];
	assign m_out[47:44]=m_in[43:40]^m_in[39:36]^m_in[35:32];
	assign m_out[43:40]=m_in[47:44]^m_in[39:36]^m_in[35:32];
	assign m_out[39:36]=m_in[47:44]^m_in[43:40]^m_in[35:32];
	assign m_out[35:32]=m_in[47:44]^m_in[43:40]^m_in[39:36];
	assign m_out[31:28]=m_in[27:24]^m_in[23:20]^m_in[19:16];
	assign m_out[27:24]=m_in[31:28]^m_in[23:20]^m_in[19:16];
	assign m_out[23:20]=m_in[31:28]^m_in[27:24]^m_in[19:16];
	assign m_out[19:16]=m_in[31:28]^m_in[27:24]^m_in[23:20];
	assign m_out[15:12]=m_in[11:8]^m_in[7:4]^m_in[3:0];
	assign m_out[11:8]=m_in[15:12]^m_in[7:4]^m_in[3:0];
	assign m_out[7:4]=m_in[15:12]^m_in[11:8]^m_in[3:0];
	assign m_out[3:0]=m_in[15:12]^m_in[11:8]^m_in[7:4];
	
endmodule
