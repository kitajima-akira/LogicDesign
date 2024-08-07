-- tb_decoder_7seg.vhd - 7セグメントLEDデコーダ用テストベンチ
library STD, IEEE;
use std.textio.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.std_logic_unsigned.all;

-- 7セグメントLEDデコーダ用テストベンチ
entity TB_DECODER_7SEG is
	generic (
		OUTPUT_FILE: string := "test_decoder_7seg_out.txt" -- 出力データのファイル名
	);
end TB_DECODER_7SEG;

architecture TB of TB_DECODER_7SEG is
-- 7セグメントLEDデコーダ
component DECODER_7SEG is
	port (
		D: in std_logic_vector(3 downto 0);  -- 数値
		Y: out std_logic_vector(6 downto 0)  -- 点灯パターン
	);
end component DECODER_7SEG;

-- 複数のアーキテクチャがある場合にどちらにするのかを指定する。
for DUV: DECODER_7SEG -- インスタンス名: エンティティ名
	use entity WORK.DECODER_7SEG(DATAFLOW);  -- テーブル記述
--	use entity WORK.DECODER_7SEG(LOGIC);  -- 論理記述

signal D: std_logic_vector(3 downto 0) := "0000";  -- 数値
signal Y: std_logic_vector(6 downto 0);  -- 点灯パターン

begin
	SIM_DATA_IO: process
	file TEST_OUT: text open write_mode is OUTPUT_FILE;
	variable LINE_OUT: line;
	variable SEPARATOR: character := ':';
	begin
		wait for 10 ns;
		-- 1周期分の動作 (繰り返し実行される。)
		write(LINE_OUT, D, right, 8);
		write(LINE_OUT, SEPARATOR);
		write(LINE_OUT, Y, right, 8);
		writeline(TEST_OUT, LINE_OUT);

		-- 入力データを更新する。
		D <= D + 1;

		-- 入力ファイルの終わりを検出する。
		assert D /= "1111" report "End of input." severity failure;
	end process;

	-- 検証対象回路のコンポーネントを用意する。
	DUV: DECODER_7SEG
		port map (
			D => D,
			Y => Y
		);
end TB;
