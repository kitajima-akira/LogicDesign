// two_digit_tb.sv - 2桁表示回路のテストベンチ

// 2桁表示回路のテストベンチ
module two_digit_tb #(
    parameter D7_OUTPUT_FILE = "disp7seg/two_digit.txt"
  );

  // 入力用信号
  logic[3:0] a, b;

  // 出力用信号
  logic[6:0] ya, yb;

  // テスト対象回路 UUT (the Unit Under Test)
  two_digit uut (.*);

  // 波形生成
  integer fd_d7 = 0;

  initial
  begin
    // ファイルのオープン
    fd_d7 = $fopen(D7_OUTPUT_FILE, "w");

    // 入力値の初期化
    a = '0;
    b = 'b0100;

    // ヘッダ表示
    $display("   a    b :       ya       yb");
    $display("---- ---- + -------- --------");

    // テストパターンの生成 (全組み合わせ)
    for (int i = 0; i < 16; i++)
    begin
      #10
       $display("%b %b : %b_%b %b_%b", a, b, ya[6:4], ya[3:0], yb[6:4], yb[3:0]);
      $fwrite(fd_d7, "%b %b: %b %b\n", a, b, ya, yb);
      a++;
      b++;
    end;

    // シミュレーション終了
    $finish;
  end
endmodule
