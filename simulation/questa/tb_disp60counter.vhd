-- tb_disp60counter.vhd - 60カウンタ表示回路用のテストベンチ

-- テキストI/Oを用いるテストベンチでは次のようにライブラリを指定する。
library STD, IEEE;
use std.textio.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

-- 60カウンタ表示回路用のテストベンチ
entity TB_DISP60COUNTER is
	generic (
		-- ***各パラメータは検証対象回路に合わせて変更する。***
		CLK_CYCLE: time := 30 ns;  -- クロックサイクル時間
		OUTPUT_FILE: string := "test_disp_60counter_out.txt" -- 出力データのファイル名
	);
end TB_DISP60COUNTER;

architecture TB of TB_DISP60COUNTER is
-- 60カウンタ表示回路
component DISP60COUNTER
	port (
		CLK: in std_logic;  -- クロック生成器
		RST_a: in std_logic;  -- リセットスイッチ
		CLEAR, CNT: in std_logic;
		SSL1, SSL0: out std_logic_vector(6 downto 0)  -- 7セグメントLED
	);
end component DISP60COUNTER;

-- 順序回路で共通に用いる信号を用意する。
signal CLK: std_logic := '1';
signal RST_a: std_logic := '1';  -- リセットの初期値を1にする。
-- ***検証対象回路の入出力用信号を用意する。***
signal CLEAR, CNT: std_logic;
signal SSL1, SSL0: std_logic_vector(6 downto 0);

begin
	-- 起動時のリセット操作
    RST_a <= '0' after 3 * CLK_CYCLE;

	-- クロック信号発生用プロセス
	CLK_GEN: process 
	begin
		CLK <= not CLK;
		wait for CLK_CYCLE / 2;
	end process;

 	CLEAR <= '0';  -- 今回は常に0

	CNT <= '1';  -- 今回は常に0

	-- ファイル出力を行うプロセス
	SIM_MAIN: process
	file TEST_OUT: text open write_mode is OUTPUT_FILE;
	variable LINE_OUT: line;
	variable SEPARATOR: character := ':';

	begin
		wait for CLK_CYCLE;

		-- ***検証対象回路のコンポーネントから得られたデータをファイルへ出力する。***
--		write(LINE_OUT, now, right, 6);
		write(LINE_OUT, CLEAR, right, 2);
		write(LINE_OUT, CNT, right, 2);
		write(LINE_OUT, SEPARATOR);
		write(LINE_OUT, SSL1, right, 8);
		write(LINE_OUT, SSL0, right, 8);
		writeLine(TEST_OUT, LINE_OUT);
	end process;

	-- ***検証対象回路のコンポーネントを用意する。***
	DUV: DISP60COUNTER
		port map (
			CLK => CLK,
			RST_a => RST_a,
			CLEAR => CLEAR,
			CNT => CNT,
			SSL0 => SSL0,
			SSL1 => SSL1
		);
end TB;
