// ex1_4_tb.sv - 課題1.4の回路のテストベンチ

// 課題1.4の回路のテストベンチ
module ex1_4_tb#(
    parameter D7_OUTPUT_FILE = "disp7seg/ex1_4.txt"
  );

  // 入力用信号
  logic[7:0] d;

  // 出力用信号
  logic[6:0] y;

  // テスト対象回路 UUT (the Unit Under Test)
  ex1_4 uut(.*);

  // 波形生成
  integer fd_d7 = 0;

  initial
  begin
    // ファイルのオープン
    fd_d7 = $fopen(D7_OUTPUT_FILE, "w");

    // 入力値の初期化
    d = 'b0000_0001;

    // ヘッダ表示
    $display("        d :        y");
    $display("--------- + --------");

    // テストパターンの生成 (全組み合わせ)
    for (int i = 0; i <= 8; i++)
    begin
      #10
       $display("%b_%b : %b_%b", d[7:4], d[3:0], y[6:4], y[3:0]);
      $fwrite(fd_d7, "%b: %b\n", d, y);
      d <<= 1;
    end;

    // シミュレーション終了
    $finish;
  end
endmodule
