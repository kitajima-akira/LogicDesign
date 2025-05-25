// incrementer_tb.sv - +1加算器のテストベンチ

// +1加算器のテストベンチ
module incrementer_tb#(
    parameter WIDTH = 4  // データ幅
  );

  // 入力用信号
  logic[WIDTH - 1:0] a;

  // 出力用信号
  logic c;
  logic [WIDTH - 1:0] s;

  // テスト対象回路 UUT (the Unit Under Test)
  incrementer#(.WIDTH(WIDTH)) uut(.*);

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
