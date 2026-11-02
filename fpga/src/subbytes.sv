module subbytes(input  logic [127:0] a,
                  output logic [127:0] y);

  sbox sb0(a[127:120], y[127:120]);
  sbox sb1(a[119:112], y[119:112]);
 sbox sb2(a[111:104], y[111:104]);
sbox sb3(a[103:96], y[103:96]);
sbox sb4(a[95:88], y[95:88]);
sbox sb5(a[87:80], y[87:80]);
sbox sb6(a[79:72], y[79:72]);
sbox sb7(a[71:64], y[71:64]);
sbox sb8(a[63:56], y[63:56]);
sbox sb9(a[55:48], y[55:48]);
sbox sb10(a[47:40], y[47:40]);
sbox sb11(a[39:32], y[39:32]);
sbox sb12(a[31:24], y[31:24]);
sbox sb13(a[23:16], y[23:16]);
sbox sb14(a[15:8], y[15:8]);
sbox sb15(a[7:0], y[7:0]);
endmodule