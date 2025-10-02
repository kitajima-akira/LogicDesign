// priority_encoder8_tb.sv - 8ビット優先度付きエンコーダのテストベンチ

// 8ビット優先度付きエンコーダのテストベンチ
module priority_encoder8_tb;

  // 入力用信号
  logic[7:0] d;

  // 出力用信号
  logic[2:0] y;

  // テスト対象回路 UUT (the Unit Under Test)
  priority_encoder8 uut(.*);

  // 波形生成
  initial
  begin
    // 入力値の初期化
    d = 'b0000_0001;

    // ヘッダ表示
    $display("        d :   y     ");
    $display("7654_3210 + --------");

    // テストパターンの生成
    for (int i = 0; i < 8; i++)
    begin
      #10
       $display("%b_%b : %b (%2d)", d[7:4], d[3:0], y, y);
      d <<= 1;
    end

    d = 'b1111_1111;
    for (int i = 0; i <= 8; i++)
    begin
      #10
       $display("%b_%b : %b (%2d)", d[7:4], d[3:0], y, y);
      d <<= 1;
    end
    // シミュレーション終了
    $finish;
  end
endmodule
