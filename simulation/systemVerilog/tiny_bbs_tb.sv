// tiny_bbs_tb.sv - 簡易電光掲示板回路のテストベンチ

`timescale 1ns / 1ns

// 簡易電光掲示板回路のテストベンチ
module tiny_bbs_tb#(
    parameter CLOCK_PERIOD = 10,
    parameter D7_OUTPUT_FILE = "disp7seg/tiny_bbs.txt"
  );

  // 入力用信号
  logic clock;  //! クロック
  logic reset;  //! 非同期リセット
  logic key;  //! キー入力

  // 出力用信号
  logic[6:0] ssl5, ssl4, ssl3, ssl2, ssl1, ssl0;  //! 7セグメントLEDパターンの出力

  // テスト対象回路 UUT (the Unit Under Test)
  tiny_bbs uut(.*);

  integer fd_d7;
  // 初期化波形生成
  initial
  begin
    // ファイルのオープン
    fd_d7 = $fopen(D7_OUTPUT_FILE, "w");

    // ヘッダ表示
    $display("reset");
    $display("| key");
    $display("| | :    ssl5    ssl4    ssl3    ssl2    ssl1    ssl0");
    $display("- - + ------- ------- ------- ------- ------- -------");

    // 入力信号の初期化
    key = 0;

    // リセット動作
    reset = 1;
    clock = 1;

    // リセット終了
    #(CLOCK_PERIOD * 1.5)
     reset = 0;
  end

  // クロック波形生成
  always #(CLOCK_PERIOD * 0.5)
    clock = ~clock;

  // クロック単位での動作
  always #CLOCK_PERIOD
  begin
    // 表示
    $display("%b %b : %b %b %b %b %b %b", reset, key, ssl5, ssl4, ssl3, ssl2, ssl1, ssl0);
    if (~reset)
        $fwrite(fd_d7, "%b: %b %b %b %b %b %b\n", key, ssl5, ssl4, ssl3, ssl2, ssl1, ssl0);
  end

  // 波形生成
  initial
  begin
    // テストパターンの生成

    // 初期ステップ
    #(CLOCK_PERIOD * 4.5)
     key = 1;

    for (int i = 0; i < 16; i++)  // キーを押す回数だけくり返し
    begin
      // キーを1回押してはなす。
      #(CLOCK_PERIOD * 2)
       key = 0;
      #CLOCK_PERIOD
       key = 1;
    end
    // シミュレーション終了
    $finish;
  end
endmodule
