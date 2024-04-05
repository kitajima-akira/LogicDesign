-- tb_key_7seg_ch.vhd - 対応するキーの文字表示回路用テストベンチ
library STD, IEEE;
use std.textio.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

-- 対応するキーの文字表示回路用テストベンチ
entity TB_KEY_7SEG_CH is
	generic (
		OUTPUT_FILE: string := "test_key_7seg_ch_out.txt"  -- 出力データのファイル名
	);
end TB_KEY_7SEG_CH;

architecture TB of TB_KEY_7SEG_CH is
-- 対応するキーの数値表示回路
component KEY_7SEG_CH
	port (
		D: in std_logic_vector(15 downto 0);  -- 16ビットキー
		Y: out std_logic_vector(6 downto 0)  -- 7セグメントLED
	);
end component KEY_7SEG_CH;

signal D: std_logic_vector(15 downto 0) := X"0001";
signal Y: std_logic_vector(6 downto 0);

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
		D <= D(14 downto 0) &  '0';

		-- 入力ファイルの終わりを検出する。
		assert D /= X"0000" report "End of input." severity failure;
	end process;

	-- 検証対象回路のコンポーネントを用意する。
	DUV: KEY_7SEG_CH
		port map (
			D => D,
			Y => Y
		);
end TB;
