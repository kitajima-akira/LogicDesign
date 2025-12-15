// shift_register_logical.sv - 論理シフトレジスタ

//! 論理シフトレジスタ
//! シフト結果はすぐに出力される。
module shift_register_logical#(
    parameter WIDTH = 4
  )(
    input logic clock,  //! クロック
    input logic reset,  //! 非同期リセット
    input logic clear,  //! クリア
    input logic load,  //! ロード
    input logic shift_in,  //! シフト入力
    input logic shift_left,  //! 左シフト
    input logic shift_right,  //! 右シフト
    input logic[WIDTH - 1:0] d,  //! データ入力
    output logic shift_out,  //! シフトアウト
    output logic[WIDTH - 1:0] q  //! 保存値の出力
  );

  // シフト処理
  logic[WIDTH - 1:0] r;
  logic[WIDTH:0] shift_r;
  assign shift_r = shift_left ? ({1'b0, r} << 1) | shift_in : shift_right ? {shift_in, r} >> 1 : d;

  // 記憶部
  always_ff @(posedge clock, posedge reset)
  begin
    if (reset)
      r <= 0;
    else if (clear)
      r <= 0;
    else if (load | shift_left | shift_right)
      r <= shift_r;
  end

  // 出力計算
  assign shift_out = shift_left ? r[WIDTH - 1] : r[0];
  assign q = load | shift_left |shift_right ? shift_r : r;
endmodule
