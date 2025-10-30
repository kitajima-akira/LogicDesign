// binary_counter_tb.sv - バイナリカウンタのテストベンチ

// バイナリカウンタのテストベンチ
module binary_counter_tb#(
    parameter CLOCK_PERIOD = 10,
    parameter WIDTH = 4,
    parameter VCD_FILE = "binary_counter.vcd"
  );

  // 入力用信号
  logic clock;  //! クロック
  logic reset;  //! 非同期リセット
  logic clear;  //! クリア
  logic count;  //! カウント

  // 出力用信号
  logic[WIDTH - 1:0] q;  //! 保存値の出力

  // テスト対象回路 UUT (the Unit Under Test)
  binary_counter#(.WIDTH(WIDTH)) uut(.*);

  // 初期化波形生成
  initial
  begin
    // 波形ファイルの生成
    $dumpfile(VCD_FILE);
    $dumpvars(0, uut);

    // ヘッダ表示
    $display("reset");
    $display("| clear");
    $display("| | count");
    $display("| | | :    q");
    $display("- - - + ----");

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
    $display("%b %b %b : %b", reset, clear, count, q);
  end

  // 波形生成
  initial
  begin
    // テストパターンの生成

    // 初期ステップ
    #(CLOCK_PERIOD * 4.5)
     count = '1;

    #CLOCK_PERIOD
     count = '0;

    #(CLOCK_PERIOD * 2)
     count = '1;

    #CLOCK_PERIOD
     count = '0;

    #(CLOCK_PERIOD * 4)
     clear = '1;

    #CLOCK_PERIOD
     clear = '0;

    #CLOCK_PERIOD
    // シミュレーション終了
    $finish;
  end
endmodule
