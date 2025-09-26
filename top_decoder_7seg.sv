// top_decoder_7seg.sv - チュートリアル用トップレベル記述

//! トップレベル記述
module top_decoder_7seg(
    input logic[9:0] SW, //! スイッチ入力
    output logic[6:0] HEX0_n, //! 7セグメントLED出力
    output logic[6:0] HEX1_n //! 7セグメントLED出力
  );

  // 正論理用の信号
  logic[6:0] hex0, hex1; // 7セグメントLED出力
  assign HEX0_n = ~hex0;
  assign HEX1_n = ~hex1;

  // 一つ目の7セグメントLEDのデコーダ
  decoder_7seg_table dec0(
                       .d(SW[3:0]),
                       .y(hex0)
                     );

  // 二つ目の7セグメントLEDのデコーダ
  decoder_7seg_table dec1(
                       .d(SW[7:4]),
                       .y(hex1)
                     );
endmodule
