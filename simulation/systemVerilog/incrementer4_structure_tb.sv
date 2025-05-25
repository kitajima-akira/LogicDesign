// incrementer4_structure_tb.sv - 4ビット+1加算器のテストベンチ

// 4ビット+1加算器のテストベンチ
module incrementer4_structure_tb;

  // 入力用信号
  logic[3:0] a;

  // 出力用信号
  logic c;
  logic[3:0] s;

  // テスト対象回路 UUT (the Unit Under Test)
  incrementer4_structure uut(.*);

  // 波形生成
  initial
  begin
    // 入力値の初期化
    a = '0;

    // ヘッダ表示
    $display("   a      : c    s     ");
    $display("--------- + - ---------");

    // テストパターンの生成
    for (int i = 0; i < 16; i++)
    begin
      #10
       $display("%b (%2d) : %b %b (%2d)", a, a, c, s, s);
      a++;
    end

    // シミュレーション終了
    $finish;
  end
endmodule
