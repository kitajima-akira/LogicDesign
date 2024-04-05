-- tb_ex1_5.vhd - キー入力文字表示回路用テストベンチ
library STD, IEEE;
use std.textio.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

-- キー入力文字表示回路用テストベンチ
entity TB_EX1_5 is
	generic (
		OUTPUT_FILE: string := "test_ex1_5_out.txt" -- 出力データのファイル名
	);
end TB_EX1_5;

architecture TB of TB_EX1_5 is
-- キー入力文字表示回路
component EX1_5
	port (
		D: in std_logic_vector(15 downto 0);  -- キーボードからの入力
		Y: out std_logic_vector(6 downto 0)   -- 7セグメントLEDへの出力
	);
end component EX1_5;

signal D: std_logic_vector(15 downto 0) := X"0001";  -- 数値
signal Y: std_logic_vector(6 downto 0);  -- 点灯パターン

begin
	SIM_DATA_IO: process
	file TEST_OUT: text open write_mode is OUTPUT_FILE;
	variable LINE_OUT: line;
	begin
		wait for 10 ns;
		-- 1周期分の動作 (繰り返し実行される。)

		write(LINE_OUT, D, right, 16);
		write(LINE_OUT, Y, right, 8);
		writeline(TEST_OUT, LINE_OUT);

		-- 入力データを更新する。
		D <= D(14 downto 0) & '0';

		-- 入力ファイルの終わりを検出する。
		assert D /= X"0000" report "End of input." severity failure;
	end process;

	-- 検証対象回路のコンポーネントを用意する。
	DUV: EX1_5
		port map (
			D => D,
			Y => Y
		);
end TB;
