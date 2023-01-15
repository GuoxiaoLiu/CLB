
#include<stdio.h> 
#include<stdlib.h> 
#include<time.h> 
#include <string.h>

#include<iostream>
#include <iomanip>
using namespace std;

// #define DEBUG2

// #define ROL(x,a) (((x)<<(a))|((x)>>(32-(a))))
// #define bit(x,i) ((x>>i)&1)
// #define SM4_L(b)  ((b) ^ ROL(b,2) ^ ROL(b,10) ^ ROL(b,18) ^ ROL(b,24))
// #define SM4_KL(b)  ((b) ^ ROL(b,13) ^ ROL(b,23))


static const unsigned char CLB_Box[16] = {
	// 3, 2, 0, 6, 1, 10, 4, 15, 11, 8, 9, 12, 13, 14, 5, 7
	14, 12, 8, 2, 1, 5, 0, 6, 10, 9, 11, 3, 4, 13, 7, 15
};

static const unsigned char CLB_Box_Inv[16] = {
	// 2, 4, 1, 0, 6, 14, 3, 15, 9, 10, 5, 8, 11, 12, 13, 7
    6, 4, 3, 11, 12, 5, 7, 14, 2, 9, 8, 10, 1, 13, 0, 15
};

static const unsigned char Pos_Box[32] = {
	// 4, 9, 14, 19, 0, 21, 26, 31,
	// 12, 29, 6, 23, 16, 25, 22, 7,
	// 8, 5, 30, 27, 24, 17, 2, 11,
	// 28, 13, 10, 3, 20, 1, 18, 15
	0, 25, 18, 15, 4, 1, 30, 19,
	8, 29, 22, 7, 12, 9, 26, 23,
	20, 5, 10, 31, 16, 13, 2, 27,
	28, 17, 6, 3, 24, 21, 14, 11
};

static const unsigned char Pos_Box_Inv[32] = {
	// 4, 29, 22, 27, 
	// 0, 17, 10, 15,
	// 16, 1, 26, 23, 
	// 8, 25, 2, 31,
	// 12, 21, 30, 3, 
	// 28, 5, 14, 11,
	// 20, 13, 6, 19, 
	// 24, 9, 18, 7
	0, 5, 22, 27, 4, 17, 26, 11, 8, 13, 18, 31, 12, 21, 30, 3, 20, 25, 2, 7, 16, 29, 10, 15, 28, 1, 14, 23, 24, 9, 6, 19
};

static const unsigned char F_Box[32] = {
	// 1, 5, 21, 17, 2, 6, 25, 29, 
	// 15, 11, 28, 24, 10, 14, 7, 3,
	// 23, 19, 0, 4, 26, 30, 9, 13, 
	// 12, 8, 18, 22, 31, 27, 20, 16
	18, 0, 4, 15, 19, 1, 5, 14,
	25, 22, 12, 9, 24, 23, 13, 8,
	31, 3, 26, 17, 30, 2, 27, 16,
	11, 6, 20, 29, 10, 7, 21, 28
};

static const unsigned char lF_Box[16] = {
	0, 8, 1, 9, 2, 10, 3, 11, 12, 4, 13, 5, 14, 6, 15, 7
};

static const unsigned char CLB_const_c0[32] = {
	0x8, 0xc, 0xe, 0xf, 0xf, 0x7, 0xb, 0xd,
	0xe, 0xf, 0x7, 0x3, 0x9, 0xc, 0xe, 0x7,
	0xb, 0x5, 0xa, 0xd, 0x6, 0x3, 0x1, 0x0,
	0x8, 0x4, 0xa, 0xd, 0xe, 0x7, 0x3, 0x1
};

static const unsigned char CLB_const_c1[32] = {
	0x0, 0x0, 0x0, 0x0, 0x8, 0xc, 0xc, 0xc,
	0xc, 0x4, 0x8, 0xc, 0xc, 0xc, 0x4, 0x0,
	0x8, 0xc, 0xc, 0x4, 0x8, 0x4, 0x8, 0xc,
	0x4, 0x0, 0x0, 0x0, 0x8, 0x4, 0x8, 0xc
};

static const unsigned char CLB_const_c2_128 = 0x5;
static const unsigned char CLB_const_c3_128 = 0xa;
static const unsigned char CLB_const_c4_128 = 0x5;
static const unsigned char CLB_const_c5_128 = 0xa;
static const unsigned char CLB_const_c2_256 = 0xa;
static const unsigned char CLB_const_c3_256 = 0x3;
static const unsigned char CLB_const_c4_256 = 0xa;
static const unsigned char CLB_const_c5_256 = 0x3;

static const unsigned char CLB_const_c6[32] = {
	0xa, 0xa, 0x9, 0x2, 0xa, 0x4, 0xc, 0x9,
	0xc, 0x3, 0x3, 0x1, 0xc, 0x9, 0xc, 0x8,
	0x4, 0x2, 0xc, 0x8, 0x4, 0xc, 0x9, 0xa,
	0x8, 0xc, 0x0, 0xb, 0x4, 0x2, 0xc, 0x1
};

static const unsigned char CLB_const_c7[32] = {
	0x0, 0xc, 0x3, 0x9, 0xc, 0xb, 0x9, 0x1,
	0x2, 0x1, 0x2, 0x9, 0x1, 0x3, 0xa, 0x1,
	0x4, 0x0, 0xb, 0xb, 0x9, 0xc, 0xb, 0x8,
	0x2, 0x1, 0x4, 0xa, 0xa, 0x2, 0x9, 0x8
};


// 
void KeyGen_128(unsigned int MK[4], unsigned int subkey[])
{
	for(int i = 0; i < 4; i ++){
		subkey[i] = MK[i];
	}

	for(int R = 1; R <= 24; R ++){
		subkey[R*4] = subkey[R*4+1] = subkey[R*4+2] = subkey[R*4+3] = 0;
		for(int i = 0; i < 32; i ++){
			int pos = R*4 + i/8;
			int shift = 28 - (i%8) * 4;
			int pos_o = (R-1) * 4 + F_Box[i]/8;
			int shift_o = 28 - (F_Box[i]%8) * 4;
			subkey[pos] |= ((subkey[pos_o] >> shift_o) & 0xF) << shift;
		}
	}
}

// 

unsigned int subkey_0[33*4];
unsigned int subkey_1[33*4];
void KeyGen_256(unsigned int MK[8], unsigned int subkey[])
{
	for(int i = 0; i < 4; i ++){
		subkey_0[i] = MK[i];
		subkey_1[i] = MK[i+4];
	}

	for(int R = 1; R <= 30; R ++){
		subkey_0[R*4] = subkey_0[R*4+1] = subkey_0[R*4+2] = subkey_0[R*4+3] = 0;
		subkey_1[R*4] = subkey_1[R*4+1] = subkey_1[R*4+2] = subkey_1[R*4+3] = 0;
		unsigned int k_tmp[4] = { 0 };
		for(int i = 0; i < 32; i ++){
			int pos = i/8;
			int shift = 28 - (i%8) * 4;
			k_tmp[pos] |= lF_Box[(subkey_1[4*(R-1) + pos] >> shift) & 0xF] << shift;
		}	
		for(int i = 0; i < 32; i ++){
			int pos = R*4 + i/8;
			int shift = 28 - (i%8) * 4;
			int pos_o = F_Box[i]/8;
			int shift_o = 28 - (F_Box[i]%8) * 4;
			subkey_0[pos] |= ((subkey_0[4*(R-1) + pos_o] >> shift_o) & 0xF) << shift;
			subkey_1[pos] |= ((k_tmp[pos_o] >> shift_o) & 0xF) << shift;
		}
	}

	#ifdef DEBUG2
	for(int i = 0; i < 31; i ++){
		printf("subkey0R%d:", i);
		for(int j = 0; j < 4; j ++){
			printf("%08x", subkey_0[i*4+j]);
		}
		printf("\nsubkey1R%d:",i);
		for(int j = 0; j < 4; j ++){
			printf("%08x", subkey_1[i*4+j]);
		}
		printf("\n");
	}
	#endif
	for(int i = 0; i < 31*4; i ++){
		subkey[i] = subkey_0[i] ^ subkey_1[i];
	}

}

//
void ENC_CLB_128(unsigned int X[4], unsigned int subkey[])
{
	// 切分成半字节方便计算
	unsigned char X_char[32];
	unsigned char X_calced[32];
	unsigned char subkey_char[25 * 32];
	for(int i = 0; i < 32; i++){
		X_char[i] = (X[i/8] >> (28 - (i%8) * 4)) & 0XF;
	}
	for(int i = 0; i < 25 * 32; i++){
		subkey_char[i] = (subkey[i/8] >> (28 - (i%8) * 4)) & 0XF;
	}

	for(int i = 0; i < 32; i++){
		X_char[i] ^= subkey_char[i];
	}

	for(int round = 1; round <= 24; round++){
		//subbytes
		for(int i = 0; i < 32; i ++){
			X_char[i] = CLB_Box[X_char[i]];
		}
		
		//addConst
		X_char[0] ^= CLB_const_c0[round - 1];
		X_char[1] ^= CLB_const_c1[round - 1];
		X_char[2] ^= CLB_const_c2_128;
		X_char[3] ^= CLB_const_c3_128;
		X_char[4] ^= CLB_const_c4_128;
		X_char[5] ^= CLB_const_c5_128;
		X_char[6] ^= CLB_const_c6[round - 1];
		X_char[7] ^= CLB_const_c7[round - 1];
		
		//posPerm
		for(int i = 0; i < 32; i ++){
			X_calced[i] = X_char[Pos_Box[i]];
		}
		for(int i = 0; i < 32; i ++){
			X_char[i] = X_calced[i];
		}

		//mixColumn
		for(int i = 0; i < 8; i ++){
			X_calced[i*4] = X_char[i*4+1] ^ X_char[i*4+2] ^ X_char[i*4+3];
			X_calced[i*4+1] = X_char[i*4] ^ X_char[i*4+2] ^ X_char[i*4+3];
			X_calced[i*4+2] = X_char[i*4] ^ X_char[i*4+1] ^ X_char[i*4+3];
			X_calced[i*4+3] = X_char[i*4] ^ X_char[i*4+1] ^ X_char[i*4+2];
		}
		for(int i = 0; i < 32; i ++){
			X_char[i] = X_calced[i];
		}
		
		//rk
		for(int i = 0; i < 32; i ++){
			X_char[i] ^= subkey_char[round*32 + i];
		}

		#ifdef DEBUG
		cout << "The " << dec << round << "-th round：" << endl;
		cout << "Round key: ";
		for(int i = 0; i < 32; i ++){
			cout << hex << (int)subkey_char[round*32 + i];
		}cout << endl;
		cout << "Cipher: ";
		for(int i = 0; i < 32; i ++){
			cout << hex << (int)X_char[i];
		}cout << endl;
		#endif
	
	}

	for(int i = 0; i < 4; i ++){ X[i] = 0; }
	for(int i = 0; i < 32; i ++){
		X[i/8] |= ((unsigned int)(X_char[i] & 0XF) << (28 - (i%8) * 4)) ;
	}
}

//
void ENC_CLB_256(unsigned int X[4], unsigned int subkey[])
{
	// half byte
	unsigned char X_char[32];
	unsigned char X_calced[32];
	unsigned char subkey_char[31 * 32];
	for(int i = 0; i < 32; i++){
		X_char[i] = (X[i/8] >> (28 - (i%8) * 4)) & 0XF;
	}
	for(int i = 0; i < 31 * 32; i++){
		subkey_char[i] = (subkey[i/8] >> (28 - (i%8) * 4)) & 0XF;
	}

	for(int i = 0; i < 32; i++){
		X_char[i] ^= subkey_char[i];
	}

	for(int round = 1; round <= 30; round++){
		//subbytes
		#ifdef DEBUG
		cout << "The " << dec << round << "-th round：" << endl;
		#endif
		for(int i = 0; i < 32; i ++){
			X_char[i] = CLB_Box[X_char[i]];
		}
		#ifdef DEBUG1
		cout << "Sbox" << endl;
		for(int i = 0; i < 32; i ++){
			cout << hex << (int)X_char[i];
		}cout << endl;
		#endif
		//addConst
		X_char[0] ^= CLB_const_c0[round - 1];
		X_char[1] ^= CLB_const_c1[round - 1];
		X_char[2] ^= CLB_const_c2_256;
		X_char[3] ^= CLB_const_c3_256;
		X_char[4] ^= CLB_const_c4_256;
		X_char[5] ^= CLB_const_c5_256;
		X_char[6] ^= CLB_const_c6[round - 1];
		X_char[7] ^= CLB_const_c7[round - 1];
		#ifdef DEBUG1
		cout << "AC" << endl;
		for(int i = 0; i < 32; i ++){
			cout << hex << (int)X_char[i];
		}cout << endl;
		#endif
		//posPerm
		for(int i = 0; i < 32; i ++){
			X_calced[i] = X_char[Pos_Box[i]];
		}
		for(int i = 0; i < 32; i ++){
			X_char[i] = X_calced[i];
		}
		#ifdef DEBUG1
		cout << "Ppern" << endl;
		for(int i = 0; i < 32; i ++){
			cout << hex << (int)X_char[i];
		}cout << endl;
		#endif
		//mixColumn
		for(int i = 0; i < 8; i ++){
			X_calced[i*4] = X_char[i*4+1] ^ X_char[i*4+2] ^ X_char[i*4+3];
			X_calced[i*4+1] = X_char[i*4] ^ X_char[i*4+2] ^ X_char[i*4+3];
			X_calced[i*4+2] = X_char[i*4] ^ X_char[i*4+1] ^ X_char[i*4+3];
			X_calced[i*4+3] = X_char[i*4] ^ X_char[i*4+1] ^ X_char[i*4+2];
		}
		for(int i = 0; i < 32; i ++){
			X_char[i] = X_calced[i];
		}
		#ifdef DEBUG1
		cout << "MC" << endl;
		for(int i = 0; i < 32; i ++){
			cout << hex << (int)X_char[i];
		}cout << endl;
		#endif
		//rk
		for(int i = 0; i < 32; i ++){
			X_char[i] ^= subkey_char[round*32 + i];
		}

		#ifdef DEBUG
		cout << "Round key: ";
		for(int i = 0; i < 32; i ++){
			cout << hex << (int)subkey_char[round*32 + i];
		}cout << endl;
		cout << "Cipher: ";
		for(int i = 0; i < 32; i ++){
			cout << hex << (int)X_char[i];
		}cout << endl;
		#endif
	}

	for(int i = 0; i < 4; i ++){ X[i] = 0; }
	for(int i = 0; i < 32; i ++){
		X[i/8] |= ((unsigned int)(X_char[i] & 0XF) << (28 - (i%8) * 4)) ;
	}
}


//0(128)/1(256)加密，2(128)/3(256)解密
int CLB_Block(int mode, unsigned int X[4], unsigned int MK[4])
{
	if (mode > 3 || mode < 0)
	{
		printf("error mode, encryption mode is 0(128)/1(256), decryption mode is 2(128)/3(256)");
		return 0;
	}
	unsigned int subkey[31*4] = { 0 };

	if(mode == 0){
		// KeyGen_128_fast(MK, subkey);
		// ENC_CLB_128_fast(X, subkey);
		KeyGen_128(MK, subkey);
		ENC_CLB_128(X, subkey);
	}
	else if(mode == 1){
		// KeyGen_256_fast(MK, subkey);
		// ENC_CLB_256_fast(X, subkey);
		KeyGen_256(MK, subkey);
		ENC_CLB_256(X, subkey);
	}
	else if(mode == 2){
		KeyGen_128(MK, subkey);
		DEC_CLB_128(X, subkey);
	}
	else{
		KeyGen_256(MK, subkey);
		DEC_CLB_256(X, subkey);
	}
	return 1;
}

//
void DEC_CLB_128(unsigned int X[4], unsigned int subkey[]){
	unsigned char X_char[32];
	unsigned char X_calced[32];
	unsigned char subkey_char[25 * 32];
	for(int i = 0; i < 32; i++){
		X_char[i] = (X[i/8] >> (28 - (i%8) * 4)) & 0XF;
	}
	for(int i = 0; i < 25 * 32; i++){
		subkey_char[i] = (subkey[i/8] >> (28 - (i%8) * 4)) & 0XF;
	}

	for(int round = 24; round > 0; round --){
		//rk
		for(int i = 0; i < 32; i ++){
			X_char[i] ^= subkey_char[round*32 + i];
		}
		//mixColumn
		for(int i = 0; i < 8; i ++){
			X_calced[i*4] = X_char[i*4+1] ^ X_char[i*4+2] ^ X_char[i*4+3];
			X_calced[i*4+1] = X_char[i*4] ^ X_char[i*4+2] ^ X_char[i*4+3];
			X_calced[i*4+2] = X_char[i*4] ^ X_char[i*4+1] ^ X_char[i*4+3];
			X_calced[i*4+3] = X_char[i*4] ^ X_char[i*4+1] ^ X_char[i*4+2];
		}
		for(int i = 0; i < 32; i ++){
			X_char[i] = X_calced[i];
		}
		//posPerm-1
		for(int i = 0; i < 32; i ++){
			X_calced[i] = X_char[Pos_Box_Inv[i]];
		}
		for(int i = 0; i < 32; i ++){
			X_char[i] = X_calced[i];
		}
		//addConst
		X_char[0] ^= CLB_const_c0[round - 1];
		X_char[1] ^= CLB_const_c1[round - 1];
		X_char[2] ^= CLB_const_c2_128;
		X_char[3] ^= CLB_const_c3_128;
		X_char[4] ^= CLB_const_c4_128;
		X_char[5] ^= CLB_const_c5_128;
		X_char[6] ^= CLB_const_c6[round - 1];
		X_char[7] ^= CLB_const_c7[round - 1];
		//subbytes-1
		for(int i = 0; i < 32; i ++){
			X_char[i] = CLB_Box_Inv[X_char[i]];
		}
		#ifdef DEBUG
		cout << "The " << dec << round << "-th round：" << endl;
		cout << "Round key: ";
		for(int i = 0; i < 32; i ++){
			cout << hex << (int)subkey_char[round*32 + i];
		}cout << endl;
		cout << "Plaintext: ";
		for(int i = 0; i < 32; i ++){
			cout << hex << (int)X_char[i];
		}cout << endl;
		#endif
	}

	for(int i = 0; i < 32; i ++)
		X_char[i] ^= subkey_char[i];

	for(int i = 0; i < 4; i ++){ X[i] = 0; }
	for(int i = 0; i < 32; i ++){
		X[i/8] |= ((unsigned int)(X_char[i] & 0XF) << (28 - (i%8) * 4)) ;
	}
}

//
void DEC_CLB_256(unsigned int X[4], unsigned int subkey[]){
	unsigned char X_char[32];
	unsigned char X_calced[32];
	unsigned char subkey_char[31 * 32];
	for(int i = 0; i < 32; i++){
		X_char[i] = (X[i/8] >> (28 - (i%8) * 4)) & 0XF;
	}
	for(int i = 0; i < 31 * 32; i++){
		subkey_char[i] = (subkey[i/8] >> (28 - (i%8) * 4)) & 0XF;
	}

	for(int round = 30; round > 0; round --){
		//rk
		for(int i = 0; i < 32; i ++){
			X_char[i] ^= subkey_char[round*32 + i];
		}
		//mixColumn
		for(int i = 0; i < 8; i ++){
			X_calced[i*4] = X_char[i*4+1] ^ X_char[i*4+2] ^ X_char[i*4+3];
			X_calced[i*4+1] = X_char[i*4] ^ X_char[i*4+2] ^ X_char[i*4+3];
			X_calced[i*4+2] = X_char[i*4] ^ X_char[i*4+1] ^ X_char[i*4+3];
			X_calced[i*4+3] = X_char[i*4] ^ X_char[i*4+1] ^ X_char[i*4+2];
		}
		for(int i = 0; i < 32; i ++){
			X_char[i] = X_calced[i];
		}
		//posPerm-1
		for(int i = 0; i < 32; i ++){
			X_calced[i] = X_char[Pos_Box_Inv[i]];
		}
		for(int i = 0; i < 32; i ++){
			X_char[i] = X_calced[i];
		}
		//addConst
		X_char[0] ^= CLB_const_c0[round - 1];
		X_char[1] ^= CLB_const_c1[round - 1];
		X_char[2] ^= CLB_const_c2_256;
		X_char[3] ^= CLB_const_c3_256;
		X_char[4] ^= CLB_const_c4_256;
		X_char[5] ^= CLB_const_c5_256;
		X_char[6] ^= CLB_const_c6[round - 1];
		X_char[7] ^= CLB_const_c7[round - 1];
		//subbytes
		for(int i = 0; i < 32; i ++){
			X_char[i] = CLB_Box_Inv[X_char[i]];
		}
	}

	for(int i = 0; i < 32; i ++)
		X_char[i] ^= subkey_char[i];

	for(int i = 0; i < 4; i ++){ X[i] = 0; }
	for(int i = 0; i < 32; i ++){
		X[i/8] |= ((unsigned int)(X_char[i] & 0XF) << (28 - (i%8) * 4)) ;
	}
}

void Verify_Block(){
	unsigned int MK[8], X0[4], X1[4];
	MK[0] = X1[0] = X0[0] = 0x01234567;
	MK[1] = X1[1] = X0[1] = 0x89abcdef;
	MK[2] = X1[2] = X0[2] = 0xfedcba98;
	MK[3] = X1[3] = X0[3] = 0x76543210;
	MK[4] = 0x0f1f2f3f;
	MK[5] = 0x4f5f6f7f;
	MK[6] = 0x8f9fafbf;
	MK[7] = 0xcfdfefff;
	
	cout << "Instance1: encryption with 128-bit key" << endl;
	cout << "Plaintext: " << setw(8) << setfill('0') << hex << X0[0] << X0[1] << X0[2] << X0[3] << endl;
	cout << "Key: " << setw(8) << setfill('0') << hex << MK[0] << MK[1] << MK[2] << MK[3] << endl;
	CLB_Block(0, X0, MK);
	for(int i = 0; i < 4; i++){
		cout << hex << X0[i];
	}
	cout << endl;
	cout << "Instance2: encryption with 256-bit key" << endl;
	cout << "Plaintext: " << setw(4) << setfill('0') << hex << X1[0] << X1[1] << X1[2] << X1[3] << endl;
	cout << "Key: " << setw(4) << setfill('0') << hex << MK[0] << MK[1] << MK[2] << MK[3] << MK[4] << MK[5] << MK[6] << MK[7] << endl;
	CLB_Block(1, X1, MK);
	for(int i = 0; i < 4; i++){
		cout << hex << X1[i];
	}
}

int main()
{
	Verify_Block();
}
