// display_60count_tb.sv - 60カウント表示回路のテストベンチ

// 60カウント表示回路のテストベンチ
module display_60count_tb#(
    parameter CLOCK_PERIOD = 10,
    parameter VCD_FILE = "display_60count.vcd",
    parameter D7_OUTPUT_FILE = "disp7seg/display_60count.txt"
  );

  // 入力用信号
  logic clock;  //! クロック
  logic reset;  //! 非同期リセット
  logic clear;  //! クリア
  logic count;  //! カウント

  // 出力用信号
  logic[6:0] ssl1, ssl0;  //! 7セグメントLEDパターンの出力

  // テスト対象回路 UUT (the Unit Under Test)
  display_60count uut(.*);

  integer fd_d7;
  // 初期化波形生成
  initial
  begin
    // ファイルのオープン
    fd_d7 = $fopen(D7_OUTPUT_FILE, "w");

    // 波形ファイルの生成
    $dumpfile(VCD_FILE);
    $dumpvars(0, uut);

    // ヘッダ表示
    $display("reset");
    $display("| clear");
    $display("| | count");
    $display("| | | :    ssl1    ssl0");
    $display("- - - + ------- -------");

    // 入力信号の初期化
    clear = '0;
    count = '0;

    // リセット動作
    reset = '1;
    clock = '1;

    // リセット終了
    #(CLOCK_PERIOD * 1.5)
     reset = '0;
  end

  // クロック波形生成
  always #(CLOCK_PERIOD * 0.5)
    clock = ~clock;

  // クロック単位での動作
  always #CLOCK_PERIOD
  begin
    // 表示
    $display("%b %b %b : %b %b", reset, clear, count, ssl1, ssl0);
    $fwrite(fd_d7, "%b %b: %b %b\n", clear, count, ssl1, ssl0);
end

  // 波形生成
  initial
  begin
    // テストパターンの生成

    // 初期ステップ
    #(CLOCK_PERIOD * 4.5)
     count = '1;

    #(CLOCK_PERIOD * 64)
    // シミュレーション終了
    $finish;
  end
endmodule
