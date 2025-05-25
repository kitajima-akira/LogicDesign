// binary_decoder8_tb.sv - 8ビットバイナリデコーダのテストベンチ

// 8ビットバイナリデコーダのテストベンチ
module binary_decoder8_tb;

  // 入力用信号
  logic[2:0] d;

  // 出力用信号
  logic[7:0] y;

  // テスト対象回路 UUT (the Unit Under Test)
  binary_decoder8 uut(.*);

  // 波形生成
  initial
  begin
    // 入力値の初期化
    d = '0;
    // ヘッダ表示
    $display("  d     :         y");
    $display("------- + 7654_3210");

    // テストパターンの生成 (全組み合わせ)
    for (int i = 0; i < 8; i++)
    begin
      #10;
      $display("%b (%1d) : %b_%b", d, d, y[7:4], y[3:0]);
      d++;
    end;

    // シミュレーション終了
    $finish;
  end
endmodule
