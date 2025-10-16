// alu_element_tb.sv - 1ビットALUのテストベンチ

// 1ビットALUのテストベンチ
module alu_element_tb;
  // 入力用信号
  logic x, y, w;  //! 演算指定用入力
  logic ci;  //! 桁上がり入力
  logic a, b;  //! 演算対象数値

  // 出力用信号
  logic co;  //! 桁上がり出力
  logic s;  //! 演算結果

  // テスト対象回路 UUT (the Unit Under Test)
  alu_element uut(.*);

  initial
  begin
    // ヘッダ表示
    $display("x y wci a b :co s");
    $display("- - - - - - + - -");

    // テストパターンの生成 (全組み合わせ)
    for (int i = 0; i < 56; i++)
    begin
      x = i[5];
      y = i[4];
      w = i[3];
      ci = i[2];
      a = i[1];
      b = i[0];
      #10
       $display("%b_%b_%b_%b %b %b : %b_%b", x, y, w, ci, a, b, co, s);
    end

    // シミュレーション終了
    $finish;
  end
endmodule
