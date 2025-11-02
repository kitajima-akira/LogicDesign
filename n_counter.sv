// n_counter.sv - n進カウンタ

//! n進カウンタ
module n_counter#(
    parameter RADIX = 10  //! 基数
  )(
    input logic clock,  //! クロック
    input logic reset,  //! 非同期リセット
    input logic clear,  //! クリア
    input logic count,  //! カウント
    output logic co, //! 桁上がり
    output logic[$clog2(RADIX) - 1:0] q  //! 保存値の出力
    );

  localparam WIDTH = $clog2(RADIX);  //! 0～基数 - 1の表現に必要なビット幅

  // オーバーフローの判定
  logic[WIDTH - 1:0] count_q;  //! カウント値
  logic overflow;  //! 次にオーバーフローするか
  assign overflow = count_q == RADIX - 1;

  // 桁上がり出力値の計算
  logic out_co;  //! 桁上がり出力値
  assign out_co = overflow & count;

  // カウンタをリセットするかどうかの判定
  logic count_clear;  //! カウンタをリセットするか
  assign count_clear = clear | out_co;

  //! カウンタ本体
  binary_counter#(.WIDTH(WIDTH)) counter(
                  .clock,
                  .reset,
                  .clear(count_clear),
                  .count,
                  .q(count_q)
                );

  // 出力
  assign co = out_co;
  assign q = count_q;
endmodule
