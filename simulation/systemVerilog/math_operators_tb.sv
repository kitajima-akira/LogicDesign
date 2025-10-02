// math_operators_tb.sv -算術演算器のテストベンチ

// 算術演算器のテストベンチ
module math_operators_tb#(
    parameter WIDTH = 4,
    parameter TEST_VECTOR_FILE = "math_operators4_tv.txt",
    parameter VCD_FILE = "math_operators.vcd"
  );

  // 入力用信号
  logic[WIDTH - 1:0] a;
  logic[WIDTH - 1:0] b;

  // 出力用信号
  logic[WIDTH - 1:0] s;
  logic[WIDTH - 1:0] d;
  logic[WIDTH * 2 - 1:0] p;

  // テスト対象回路 UUT (the Unit Under Test)
  math_operators#(.WIDTH(WIDTH)) uut(.*);

  // 波形生成
  integer fd = 0;
  integer lineno = 0;
  integer error_no = 0;

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
    end;

    // ヘッダ表示
    $display("   a         b      :    s         d             p      ");
    $display("--------- --------- + --------- --------- --------------");

    // テストパターンの生成 (ファイルから読み込み)
    begin
      forever
      begin
        // ファイルから1行読み込み
        logic[WIDTH - 1:0] a_in;
        logic[WIDTH - 1:0] b_in;
        logic[WIDTH - 1:0] s_ex;
        logic[WIDTH - 1:0] d_ex;
        logic[WIDTH * 2 - 1:0] p_ex;

        lineno++;
        if ($fscanf(fd, "%b %b : %b %b %b", a_in, b_in, s_ex, d_ex, p_ex) == 5)
        begin
          // 入力値の設定
          a = a_in;
          b = b_in;

          // 10ns 待ち
          #10;

          // 結果の表示
          $display("%b (%d) %b (%d) : %b (%d) %b (%d) %b (%d)", a, a, b, b, s, s, d, d, p, p);
          if ((s != s_ex) || (d != d_ex) || (p != p_ex))
          begin
            $display("Error: %s:%1d: unexpected result.  Expected: %b %b %b", TEST_VECTOR_FILE, lineno, s_ex, d_ex, p_ex);
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
