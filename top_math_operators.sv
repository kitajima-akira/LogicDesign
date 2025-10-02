// top_math_operators.sv - 算術演算子回路トップレベル記述

//! トップレベル記述
module top_math_operators(
    input logic[9:0] SW, // スイッチ入力
    output logic[6:0] HEX0_n, // 7セグメントLED出力 (p下位)
    output logic[6:0] HEX1_n, // 7セグメントLED出力 (p上位)
    output logic[6:0] HEX2_n, // 7セグメントLED出力 (d)
    output logic[6:0] HEX3_n, // 7セグメントLED出力 (s)
    output logic[6:0] HEX4_n, // 7セグメントLED出力 (b)
    output logic[6:0] HEX5_n // 7セグメントLED出力 (a)
  );

  // 正論理用の信号
  logic[6:0] hex0, hex1, hex2, hex3, hex4, hex5; // 7セグメントLED出力
  assign HEX0_n = ~hex0;
  assign HEX1_n = ~hex1;
  assign HEX2_n = ~hex2;
  assign HEX3_n = ~hex3;
  assign HEX4_n = ~hex4;
  assign HEX5_n = ~hex5;

  // math_operatorsの入出力信号
  logic[3:0] a, b, ops_s, ops_d;
  logic[7:0] ops_p;
  assign a = SW[7:4];
  assign b = SW[3:0];

  // 算術演算子回路
  math_operators mop(
                   .a,
                   .b,
                   .s(ops_s),
                   .d(ops_d),
                   .p(ops_p)
                 );

  // 7セグメントLED5のデコーダ
  decoder_7seg dec5(
                 .d(a),
                 .y(hex5)
               );

  // 7セグメントLED4のデコーダ
  decoder_7seg dec4(
                 .d(b),
                 .y(hex4)
               );

  // 7セグメントLED3のデコーダ
  decoder_7seg dec3(
                 .d(ops_s),
                 .y(hex3)
               );

  // 7セグメントLED2のデコーダ
  decoder_7seg dec2(
                 .d(ops_d),
                 .y(hex2)
               );

  // 7セグメントLED1のデコーダ
  decoder_7seg dec1(
                 .d(ops_p[7:4]),
                 .y(hex1)
               );

  // 7セグメントLED0のデコーダ
  decoder_7seg dec0(
                 .d(ops_p[3:0]),
                 .y(hex0)
               );
endmodule
