`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:29:26 01/13/2019
// Design Name:   top
// Module Name:   E:/2.Research/1.Hardware/THU_crypt_design/top_tb.v
// Project Name:  THU_crypt_design
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module crypt_ecb_tb;

	reg clk;
	reg rst;
	reg mode;
	//reg [4:0]blocknum;
	reg [127:0]textin;
	reg [127:0]key;
	wire [127:0]textout;
	wire enable;
	//wire done;

	
	
	
	
	/*
	integer i,j;
	initial begin	
	//采用一个posedge clk or negedge rst
		clk = 0;
		rst = 0;	
		key <= 128'h01234567_89abcdef_fedcba98_76543210;
		textin <= 128'h01234567_89abcdef_fedcba98_76543210;
	
		#2 rst = 1;  
		
		//33ns 密文 da99343c 616fe47c 796af018 2cd01915
		

		#32 rst = 0;	
		key <= 128'h01234567_89abcdef_fedcba98_76543210;
		textin <= 128'h01234567_89abcdef_fedcba98_76543210;
		#2 rst = 1;  
		
		#32 rst = 0;	
		
		for(i=0;i<32;i=i+1) begin
			rst <= 0;
			//blocknum <= i;
			textin <= 128'h01234567_89abcdef_fedcba98_76543210;//plaintext
			key <= 128'h01234567_89abcdef_fedcba98_76543210;
			for(j=0;j<17;j=j+1) begin
				#2 rst <= 1;
			end
		end
		
	end
	always #1 clk = ~clk;
	*/
	
	initial begin	
		clk = 0;
		rst = 0;	
		mode = 0;
		key <= 128'd0;
		//key <= 128'hf8824664994aef9b418ca843498d658f;
		textin <= 128'd0;
	    //textin <= 128'hfe5180a5414b65bf26f6d2122b004aff;
		#10 rst = 1;  
		//33ns 密文 a751e
		
		#100 rst = 0;
		mode = 1;	
		key <= 128'h01234567_89abcdef_fedcba98_76543210;
		textin <= 128'h5c6f7253ae2c480d497422de7b4c40d3;
		#2 rst = 1;  
		
		#100 
		rst = 1;
		rst = 0;	
	end	
	always #1 clk = ~clk;	
	
	/*
	/// INITIAL BASIC
		clk <= 1;
		rst <= 0;
		#4  rst <= 1;
		//mode <= 0;
		start <= 0;
		#3 start <= 1;
		key <= 128'h01234567_89abcdef_fedcba98_76543210;
		textin <= 128'h01234567_89abcdef_fedcba98_76543210;
		#1  rst <= 0;
		
		
	/// ENCRYPTION MODE = 0
		//for(i=0;i<32;i=i+1) begin
			start <= 1;
			//blocknum <= i;
			textin <= 128'h01234567_89abcdef_fedcba98_76543210;//plaintext
			for(j=0;j<17;j=j+1) begin
				#1 start <= 0;
				if(j == 32'h00000010) begin
					#1 start <= 1;
					#1 ;
				end
				else begin
					#1 start <= 0;
					#1 ;
				end
			end
		//end		
	end
	always #1 clk = ~clk;
	*/
	

	clb_ecb uut(.clk(clk),
		.rst(rst),
		//.mode(mode),
		//.blocknum(blocknum),
		//.mode(mode),
		.textin(textin),
		.key(key),
		.textout(textout),
		.enable(enable)
		//.done(done)
		);

endmodule
