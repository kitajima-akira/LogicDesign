// selector2_behavior_tb.sv - 2入力セレクタのテストベンチ

// 2入力セレクタのテストベンチ
module selector2_behavior_tb#(
    parameter WIDTH = 4
  );

  // 入力用信号
  logic[WIDTH - 1:0] d0, d1;
  logic s;

  // 出力用信号
  logic[WIDTH - 1:0] y;

  // テスト対象回路 UUT (the Unit Under Test)
  selector2_behavior#(.WIDTH(WIDTH)) uut(.*);

  // 波形生成
  initial
  begin
    // 入力値の初期化
    d0 = '0;
    d1 = '1;
    s = '0;

    // ヘッダ表示
    $display("  d0   d1 s :    y");
    $display("---- ---- - + ----");

    // テストパターンの生成
    for (int i = 0; i < 8; i++)
    begin
      #10
       $display("%b %b %b : %b", d0, d1, s, y);
      d0 = d0 + 1;
      d1 = d1 + 4;
      s = ~s;
    end

    // シミュレーション終了
    $finish;
  end
endmodule
