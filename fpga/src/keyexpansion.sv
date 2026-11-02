module keyexpansion(input  logic         clk, 
				input logic [3:0] itercount,
                input  logic [127:0] key, 
                output logic [127:0] roundkey);

logic[127:0] previouskey;

//w[i − Nk]
always_ff @(posedge clk) begin

	previouskey <= roundkey;
end

//words must be 32bits

logic[31:0]  subword;
logic [31:0] rcon;

sbox_sync sb0(previouskey[23:16], clk, subword[31:24]);  //rot a1 to [0] in w[i-1] (previouskey[31:0]) and then sbox
sbox_sync sb1(previouskey[15:8], clk, subword[23:16]);
sbox_sync sb2(previouskey[7:0], clk, subword[15:8]);
sbox_sync sb3(previouskey[31:24], clk, subword[7:0]);

//   The key and message are 128-bit values packed into an array of 16 bytes as
//   shown below
//        [127:120] [95:88] [63:56] [31:24]     S0,0    S0,1    S0,2    S0,3
//        [119:112] [87:80] [55:48] [23:16]     S1,0    S1,1    S1,2    S1,3
//        [111:104] [79:72] [47:40] [15:8]      S2,0    S2,1    S2,2    S2,3
//        [103:96]  [71:64] [39:32] [7:0]       S3,0    S3,1    S3,2    S3,3
//
always_comb begin

	if(itercount<2) begin
		roundkey = key;
	end
	else begin
		roundkey[127:96] = previouskey[127:96]^subword^rcon;   // w[i]  = w[i − Nk]^ subword^rcon 
		roundkey[95:64] = previouskey[95:64]^roundkey[127:96]; //w[i] = w[i-nk]^w[i-1]
		roundkey[63:32] = previouskey[63:32]^roundkey[95:64]; //w[i] = w[i-nk]^w[i-1]
		roundkey[31:0] = previouskey[31:0]^roundkey[63:32]; //w[i] = w[i-nk]^w[i-1]
		end
	case (itercount-1)
            4'd1:    rcon = 32'h01000000;
            4'd2:    rcon = 32'h02000000;
            4'd3:    rcon = 32'h04000000;
            4'd4:    rcon = 32'h08000000;
            4'd5:    rcon = 32'h10000000;
            4'd6:    rcon = 32'h20000000;
            4'd7:    rcon = 32'h40000000;
            4'd8:    rcon = 32'h80000000;
            4'd9:    rcon = 32'h1b000000;
            4'd10:   rcon = 32'h36000000;
            default: rcon = 32'h00000000;
	endcase
end


endmodule