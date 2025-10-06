// binary_encoder4_tb.sv - 4ビットバイナリエンコーダのテストベンチ

// 4ビットバイナリエンコーダのテストベンチ
module binary_encoder4_tb;

  // 入力用信号
  logic[3:0] d;

  // 出力用信号
  logic[1:0] y;

  // テスト対象回路 UUT (the Unit Under Test)
  binary_encoder4 uut(.*);

  // 波形生成
  initial
  begin
    // 入力値の初期化
    d = '0;

    // ヘッダ表示
    $display("   d :  y     ");
    $display("---- + -------");

    // テストパターンの生成
    for (int i = 0; i < 16; i++)
    begin
      #10;
      $display("%b : %b (%2d)", d, y, y);
      d++;
    end;

    // シミュレーション終了
    $finish;
  end
endmodule
