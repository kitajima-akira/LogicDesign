// display_60count_top_tb.sv - display_60countをボードで実行するための回路のテストベンチ

`timescale 1ns / 1ns

// display_60countをボードで実行するための回路のテストベンチ
module display_60count_top_tb#(
    parameter CLOCK_PERIOD = 1,
    parameter D7_OUTPUT_FILE = "disp7seg/display_60count_top.txt"
  );
  localparam FREQUENCY = 1; //! シミュレーションでのボードの動作周波数 (Hz)

  // 入力用信号
  logic clock;  //! クロック
  logic reset;  //! 非同期リセット
  logic reset_an;
  assign reset_an = ~reset;
  logic[9:0] SW;
  logic KEY0_n;
  logic key0;
  assign key0 = ~KEY0_n;

  // 出力用信号
  logic[6:0] ssl1, ssl0;  //! 7セグメントLEDパターンの出力
  logic[6:0] HEX1_n, HEX0_n;

  assign ssl1 = ~HEX1_n;
  assign ssl0 = ~HEX0_n;

  // テスト対象回路 UUT (the Unit Under Test)
  display_60count_top#(.FREQUENCY(FREQUENCY)) uut(.*);

  integer fd_d7;  // disp7seg用データのファイル
  logic[7:0] index;
  // 初期化波形生成
  initial
  begin
    // ファイルのオープン
    fd_d7 = $fopen(D7_OUTPUT_FILE, "w");

    // ヘッダ表示
    $display("reset");
    $display("| SW[0]");
    $display("| | key0");
    $display("| | | :    ssl1    ssl0");
    $display("- - - + ------- -------");

    // リセット動作
    reset = 1;
    clock = 1;

    // リセット終了
    #(CLOCK_PERIOD * 1.5)
     reset = 0;
    // テストパターンの生成
    KEY0_n = 1;
    SW = 'b0000000001;
    for (int i = 0; i <= 60; i++)  // 60回くり返し
    begin
      #2
    // 表示
    $display("%b %b %b : %b %b", reset, SW[0], key0, ssl1, ssl0);
    index = i;
    if (~reset)
        $fwrite(fd_d7, "%b %b %b %b : %b %b\n", index, reset, SW[0], key0, ssl1, ssl0);
      ;
    end
    // シミュレーション終了
    $finish;
  end

  // クロック波形生成
  always #(CLOCK_PERIOD * 0.5)
    clock = ~clock;
endmodule
