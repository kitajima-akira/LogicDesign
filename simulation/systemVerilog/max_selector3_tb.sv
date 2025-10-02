// max_selector3_tb.sv - 3入力最大値セレクタのテストベンチ

// 3入力最大値セレクタのテストベンチ
module max_selector3_tb#(
    parameter WIDTH = 4
  );

  // 入力用信号
  logic[WIDTH - 1:0] d0, d1, d2;

  // 出力用信号
  logic[WIDTH - 1:0] y;

  // テスト対象回路 UUT (the Unit Under Test)
  max_selector3 #(.WIDTH(WIDTH)) uut(.*);

  // 波形生成
  initial
  begin
    // 入力値の初期化
    d0 = '0;
    d1 = 'b1111;
    d2 = 'b0110;

    // ヘッダ表示
    $display("  d0        d1        d2      :    y     ");
    $display("--------- --------- --------- + ---------");

    // テストパターンの生成
    for (int i = 0; i < 8; i++)
    begin
      #10
       $display("%b (%2d) %b (%2d) %b (%2d) : %b (%2d)", d0, d0, d1, d1, d2, d2, y, y);
      d0 = d0 + 7;
      d1 = d1 + 4;
      d2 = d2 + 2;
    end

    // シミュレーション終了
    $finish;
  end
endmodule
