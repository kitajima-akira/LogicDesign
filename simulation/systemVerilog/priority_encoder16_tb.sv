// priority_encoder16_tb.sv - 16ビット優先度付きエンコーダのテストベンチ

// 16ビット優先度付きエンコーダのテストベンチ
module priority_encoder16_tb;

  // 入力用信号
  logic[15:0] d;

  // 出力用信号
  logic[3:0] y;

  // テスト対象回路 UUT (the Unit Under Test)
  priority_encoder16 uut(.*);

  // 波形生成
  initial
  begin
    // ヘッダ表示
    $display("                  d :    y     ");
    $display("5432_1098_7654_3210 + ---------");

    // テストパターンの生成
    d = 'b0000_0000_0000_0001;
    for (int i = 0; i < 16; i++)
    begin
      #10
       $display("%b_%b_%b_%b : %b (%2d)", d[15:12], d[11:8], d[7:4], d[3:0], y, y);
      d <<= 1;
    end

    d = 'b1111_1111_1111_1111;
    for (int i = 0; i <= 16; i++)
    begin
      #10
       $display("%b_%b_%b_%b : %b (%2d)", d[15:12], d[11:8], d[7:4], d[3:0], y, y);
      d <<= 1;
    end
    // シミュレーション終了
    $finish;
  end
endmodule
