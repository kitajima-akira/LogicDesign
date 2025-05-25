// half_adder_tb.sv - 半加算器のテストベンチ

// 半加算器のテストベンチ
module half_adder_tb;

  // 入力用信号
  logic a;
  logic b;

  // 出力用信号
  logic s;
  logic c;

  // テスト対象回路 UUT (the Unit Under Test)
  half_adder uut(.*);

  // 波形生成
  initial
  begin
    // ヘッダ表示
    $display("a b : c s");
    $display("- - + - -");

    // テストパターンの生成 (全組み合わせ)
    for (int i = 0; i < 4; i++)
    begin
      a = i[1];
      b = i[0];
      #10
       $display("%b %b : %b %b", a, b, c, s);
    end

    // シミュレーション終了
    $finish;
  end
endmodule
