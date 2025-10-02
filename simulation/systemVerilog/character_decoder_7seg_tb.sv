// character_decoder_7seg_tb.sv - 7セグメントLED文字デコーダのテストベンチ

// 7セグメントLED文字デコーダのテストベンチ
module character_decoder_7seg_tb#(
    parameter D7_OUTPUT_FILE = "disp7seg/character_decoder_7seg.txt"
  );

  // 入力用信号
  logic[3:0] d;

  // 出力用信号
  logic[6:0] y;

  // テスト対象回路 UUT (the Unit Under Test)
  character_decoder_7seg uut(.*);

  // 波形生成
  integer fd_d7 = 0;
  integer fd_km = 0;

  initial
  begin
    // ファイルのオープン
    fd_d7 = $fopen(D7_OUTPUT_FILE, "w");

    // 入力値の初期化
    d = '0;

    // ヘッダ表示
    $display("   d :        y");
    $display("---- + ---_----");

    // テストパターンの生成 (全組み合わせ)
    for (int i = 0; i < 16; i++)
    begin
      #10;
      $display("%b : %b_%b", d, y[6:4], y[3:0]);
      $fwrite(fd_d7, "%b: %b\n", d, y);
      d++;
    end;

    // シミュレーション終了
    $finish;
  end
endmodule
