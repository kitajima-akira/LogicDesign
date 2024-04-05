-- tb_two_digit.vhd - 7セグメントLED 2桁表示回路のテストベンチ
library STD, IEEE;
use std.textio.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.std_logic_unsigned.all;

--  7セグメントLED 2桁表示回路のテストベンチ
entity TB_TWO_DIGIT is
	generic (
		OUTPUT_FILE: string := "test_two_digit_out.txt" -- 出力データのファイル名
	);
end TB_TWO_DIGIT;

architecture TB of TB_TWO_DIGIT is
--  7セグメントLED 2桁表示回路
component TWO_DIGIT
	port (
		A, B: in std_logic_vector(3 downto 0); -- 2進数入力
		YA, YB: out std_logic_vector(6 downto 0) -- 7セグメントLED
	);
end component TWO_DIGIT;

signal A, B: std_logic_vector(3 downto 0) := "0000";  -- 数値
signal YA, YB: std_logic_vector(6 downto 0);  -- 点灯パターン

begin

	SIM_DATA_IO: process
	file TEST_OUT: text open write_mode is OUTPUT_FILE;
	variable LINE_OUT: line;
	begin
		wait for 10 ns;
		-- 1周期分の動作 (繰り返し実行される。)

		write(LINE_OUT, A, right, 8);
		write(LINE_OUT, B, right, 8);
		write(LINE_OUT, YA, right, 8);
		write(LINE_OUT, YB, right, 8);
		writeline(TEST_OUT, LINE_OUT);

		-- 入力データを更新する。
		A <= A + 1;
		B <= B + 3;

		-- 入力ファイルの終わりを検出する。
		assert B /= "1101" report "End of input." severity failure;
	end process;

	-- 検証対象回路のコンポーネントを用意する。
	DUV: TWO_DIGIT
		port map (
			A => A,
			B => B,
			YA => YA,
			YB => YB
		);
end TB;
