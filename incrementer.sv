// incrementer.sv - インクリメント回路

//! インクリメント回路
module incrementer#(
    parameter WIDTH = 4  //! データ幅
  )(
    input logic[WIDTH - 1:0] a,  //! 入力値
    output logic c,  //! 桁上がり出力
    output logic[WIDTH - 1:0] s  //! 出力値
  );

  // 各桁への桁上がり入力
  logic[WIDTH - 1:0] ci;  //! 桁上がり入力
  logic[WIDTH - 1:0] cc;  //! 桁上がり出力
  assign ci = {cc[WIDTH - 2:0], 1'b1};

  // // 加算 (半加算器)
  // assign s = a ^ ci;
  // assign cc = a & ci;
  generate
    genvar i;
    for (i = 0; i < WIDTH; i++)
    begin: instance_block
      half_adder ha(
                   .a(a[i]),
                   .b(ci[i]),
                   .c(cc[i]),
                   .s(s[i])
                 );
    end
  endgenerate

  assign c = cc[WIDTH - 1];
endmodule
