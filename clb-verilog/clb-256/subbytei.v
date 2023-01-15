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
module SubByteI(
	input [127:0]s_in,
	output [127:0]s_out
	);
	
	sboxi s1(s_in[127:124], s_out[127:124]);
	sboxi s2(s_in[123:120], s_out[123:120]);
	sboxi s3(s_in[119:116], s_out[119:116]);
	sboxi s4(s_in[115:112], s_out[115:112]);
	sboxi s5(s_in[111:108], s_out[111:108]);
	sboxi s6(s_in[107:104], s_out[107:104]);
	sboxi s7(s_in[103:100], s_out[103:100]);
	sboxi s8(s_in[99:96], s_out[99:96]);
	sboxi s9(s_in[95:92], s_out[95:92]);
	sboxi s10(s_in[91:88], s_out[91:88]);
	sboxi s11(s_in[87:84], s_out[87:84]);
	sboxi s12(s_in[83:80], s_out[83:80]);
	sboxi s13(s_in[79:76], s_out[79:76]);
	sboxi s14(s_in[75:72], s_out[75:72]);
	sboxi s15(s_in[71:68], s_out[71:68]);
	sboxi s16(s_in[67:64], s_out[67:64]);
	sboxi s17(s_in[63:60], s_out[63:60]);
	sboxi s18(s_in[59:56], s_out[59:56]);
	sboxi s19(s_in[55:52], s_out[55:52]);
	sboxi s20(s_in[51:48], s_out[51:48]);
	sboxi s21(s_in[47:44], s_out[47:44]);
	sboxi s22(s_in[43:40], s_out[43:40]);
	sboxi s23(s_in[39:36], s_out[39:36]);
	sboxi s24(s_in[35:32], s_out[35:32]);
	sboxi s25(s_in[31:28], s_out[31:28]);
	sboxi s26(s_in[27:24], s_out[27:24]);
	sboxi s27(s_in[23:20], s_out[23:20]);
	sboxi s28(s_in[19:16], s_out[19:16]);
	sboxi s29(s_in[15:12], s_out[15:12]);
	sboxi s30(s_in[11:8], s_out[11:8]);
	sboxi s31(s_in[7:4], s_out[7:4]);
	sboxi s32(s_in[3:0], s_out[3:0]);

endmodule
