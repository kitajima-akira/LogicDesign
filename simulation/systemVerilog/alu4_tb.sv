// alu4_tb.sv - 4ビットALUのテストベンチ

// 4ビットALUのテストベンチ
module alu4_tb;
  // 入力用信号
  logic x, y, z, w;  //! 演算指定用入力
  logic ci;  //! 桁上がり入力
  logic[3:0] a, b;  //! 演算対象数値

  // 出力用信号
  logic[3:0] c;  //! 桁上がり出力
  logic[3:0] g;  //! 演算結果

  // テスト対象回路 UUT (the Unit Under Test)
  alu4 uut(.*);

  string operation;  // 演算の種類を表す文字列
  initial
  begin
    // 入力値の初期化
    a = 'b1100;
    b = 'b1010;

    // ヘッダ表示
    $display("x y z w OP ci    a         b      :    c    g");
    $display("- - - - --- - --------- --------- + ---- ---------");

    // テストパターンの生成 (全組み合わせ)
    for (int i = 0; i < 32; i++)
    begin
      x = i[4];
      y = i[3];
      z = i[2];
      w = i[1];
      ci = i[0];
      #10
       operation = ~x & y & ~z ? " + "
       : x & y & ~z ? " - "
       : ~x & ~y & z & ~w ? "AND"
       : ~x & ~y & z & w ? "OR "
       : ~x & ~y & ~z & ~w ? "XOR"
       : "???";
      $display("%b %b %b %b %s %b %b (%d) %b (%d) : %b %b (%d)", x, y, z, w, operation, ci, a, a, b, b, c, g, g);
    end

    // シミュレーション終了
    $finish;
  end
endmodule
