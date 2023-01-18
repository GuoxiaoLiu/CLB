`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:50:00 01/14/2019 
// Design Name: 
// Module Name:    SubNibble_table 
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
module SubByte(
	input [127:0]s_in,
	output [127:0]s_out
	);
	
	sbox s1(s_in[127:124], s_out[127:124]);
	sbox s2(s_in[123:120], s_out[123:120]);
	sbox s3(s_in[119:116], s_out[119:116]);
	sbox s4(s_in[115:112], s_out[115:112]);
	sbox s5(s_in[111:108], s_out[111:108]);
	sbox s6(s_in[107:104], s_out[107:104]);
	sbox s7(s_in[103:100], s_out[103:100]);
	sbox s8(s_in[99:96], s_out[99:96]);
	sbox s9(s_in[95:92], s_out[95:92]);
	sbox s10(s_in[91:88], s_out[91:88]);
	sbox s11(s_in[87:84], s_out[87:84]);
	sbox s12(s_in[83:80], s_out[83:80]);
	sbox s13(s_in[79:76], s_out[79:76]);
	sbox s14(s_in[75:72], s_out[75:72]);
	sbox s15(s_in[71:68], s_out[71:68]);
	sbox s16(s_in[67:64], s_out[67:64]);
	sbox s17(s_in[63:60], s_out[63:60]);
	sbox s18(s_in[59:56], s_out[59:56]);
	sbox s19(s_in[55:52], s_out[55:52]);
	sbox s20(s_in[51:48], s_out[51:48]);
	sbox s21(s_in[47:44], s_out[47:44]);
	sbox s22(s_in[43:40], s_out[43:40]);
	sbox s23(s_in[39:36], s_out[39:36]);
	sbox s24(s_in[35:32], s_out[35:32]);
	sbox s25(s_in[31:28], s_out[31:28]);
	sbox s26(s_in[27:24], s_out[27:24]);
	sbox s27(s_in[23:20], s_out[23:20]);
	sbox s28(s_in[19:16], s_out[19:16]);
	sbox s29(s_in[15:12], s_out[15:12]);
	sbox s30(s_in[11:8], s_out[11:8]);
	sbox s31(s_in[7:4], s_out[7:4]);
	sbox s32(s_in[3:0], s_out[3:0]);

endmodule
