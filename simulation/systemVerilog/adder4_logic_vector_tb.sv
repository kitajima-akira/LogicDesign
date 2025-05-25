// adder4_logic_vector_tb.sv - 4ビット加算器のテストベンチ

// 4ビット加算器のテストベンチ
module adder4_logic_vector_tb#(
    parameter TEST_VECTOR_FILE = "adder4_tv.txt",
    parameter VCD_FILE = "adder4_logic_vector.vcd"
  );

  // 入力用信号
  logic[3:0] a;
  logic[3:0] b;
  logic ci;

  // 出力用信号
  logic[3:0] s;
  logic co;

  // テスト対象回路 UUT (the Unit Under Test)
  adder4_logic_vector uut(.*);

  // 波形生成
  integer fd = 0;  // ファイルディスクリプタ
  integer lineno = 0;  // 行番号
  integer error_no = 0;  // エラーの個数

  initial
  begin
    // 波形ファイルの生成
    $dumpfile(VCD_FILE);
    $dumpvars(0, uut);

    // ファイルのオープン
    fd = $fopen(TEST_VECTOR_FILE, "r");
    if (fd == 0)
    begin
      $display("Error: %s: open failed", TEST_VECTOR_FILE);
      $finish;
    end

    // ヘッダ表示
    $display("   a         b     ci :co    s     ");
    $display("--------- --------- - + - ---------");

    // テストパターンの生成 (ファイルから読み込み)
    begin
      forever
      begin
        // ファイルから1行読み込み
        logic[3:0] a_in;
        logic[3:0] b_in;
        logic ci_in;
        logic[3:0] s_ex;
        logic co_ex;

        lineno++;
        if ($fscanf(fd, "%b %b %b : %b %b", a_in, b_in, ci_in, co_ex, s_ex) == 5)
        begin
          // 入力値の設定
          a = a_in;
          b = b_in;
          ci = ci_in;

          // 10ns 待ち
          #10
           // 結果の表示
           $display("%b (%d) %b (%d) %b : %b %b (%d)", a, a, b, b, ci, co, s, s);
          if ((co != co_ex) || (s != s_ex))
          begin
            $display("Error: %s:%1d: unexpected result. Expected: %b %b", TEST_VECTOR_FILE, lineno, co_ex, s_ex);
            error_no++;
          end
        end
        else
        begin
          // ファイルの終端
          if (error_no == 0)
          begin
            $display("Result: all tests passed.");
            $display("Waveform file generated: %s", VCD_FILE);
          end
          else
            $display("Result: %1d test(s) failed.", error_no);
          break;
        end
      end

      // シミュレーション終了
      $finish;
    end
  end
endmodule
