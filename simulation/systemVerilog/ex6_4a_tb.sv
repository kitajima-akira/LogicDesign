// ex6_4a_tb.sv - 練習問題6.4aのテストベンチ

// 練習問題6.4aのテストベンチ
module ex6_4a_tb#(
    parameter OUTPUT_FILE = "karnaughmap/ex6_4a.txt"
  );

  // 入力用信号
  logic a, b, c, d;

  // 出力用信号
  logic ya, yb;

  // テスト対象回路 UUT (the Unit Under Test)
  ex6_4a uut(.*);

  // 波形生成
  integer fd = 0;

  initial
  begin
    // ファイルのオープン
    fd = $fopen(OUTPUT_FILE, "w");

    // ヘッダ表示
    $display("a b c d : ya yb");
    $display("- - - - +  -  -");

    // テストパターンの生成 (全組み合わせ)
    for (int i = 0; i < 16; i++)
    begin
      a = i[3];
      b = i[2];
      c = i[1];
      d = i[0];

      #10
       $display("%b %b %b %b :  %b  %b", a, b, c, d, ya, yb);
      $fwrite(fd, "%b%b%b%b %b%b\n", a, b, c, d, ya, yb);
    end;

    // シミュレーション終了
    $finish;
  end
endmodule
