-- tb_ex7_2a.vhd - 演習課題7.2a用テストベンチ
library STD, IEEE;
use std.textio.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.std_logic_unsigned.all;

-- 演習課題7.2a用テストベンチ
entity TB_EX7_2A is
	generic (
		OUTPUT_FILE: string := "test_ex7_2a_out.txt"; -- 出力データのファイル名
		CLK_CYCLE: time := 50 ns           -- クロックサイクル時間
	);
end TB_EX7_2A;

architecture TB of TB_EX7_2A is
-- 演習課題7.2aの回路(テスト対象回路)
component EX7_2A
	port (
		A, B, C, D: in std_logic;
		YA, YB: out std_logic
	);
end component EX7_2A;

signal COUNT: std_logic_vector(3 downto 0) := "0000";
-- テスト対象回路の入出力用信号
signal A, B, C, D: std_logic := '1';
signal YA, YB: std_logic;

begin
	A <= COUNT(3);
	B <= COUNT(2);
	C <= COUNT(1);
	D <= COUNT(0);

	-- テスト対象回路に与える入力信号の列(テストベクタ)を生成するプロセス
	SIM_DATA_IO: process
	file TEST_OUT: text open write_mode is OUTPUT_FILE;
	variable LINE_OUT: line;
	begin
		wait for CLK_CYCLE;
		-- 1周期分の動作 (繰り返し実行される。)

		write(LINE_OUT, COUNT, right, 8);
		write(LINE_OUT, ' ', right, 1);
		write(LINE_OUT, YA, right, 1);
		write(LINE_OUT, YB, right, 1);
		writeline(TEST_OUT, LINE_OUT);

		-- 入力データを更新する。
		COUNT <= COUNT + 1;

		-- 入力ファイルの終わりを検出する。
		assert COUNT /= "1111" report "End of input." severity failure;
	end process;
	
	-- テスト対象回路のインスタンス
	DUV: EX7_2A
	   port map (
			A => A,
			B => B,
			C => C,
			D => D, 
			YA => YA,
			YB => YB
		);
end TB;
