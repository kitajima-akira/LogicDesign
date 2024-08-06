-- tb_top_inc4.vhd - DE0-CV用トップレベル記述 (インクリメント(+1)回路)用テストベンチ
library STD, IEEE;
use std.textio.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.std_logic_unsigned.all;

-- 7セグメントLEDデコーダ用テストベンチ
entity TB_TOP_INC4 is
	generic (
		OUTPUT_FILE: string := "test_top_inc4_out.txt" -- 出力データのファイル名
	);
end TB_TOP_INC4;

architecture TB of TB_TOP_INC4 is
-- DE0-CV用トップレベル記述 (インクリメント(+1)回路)
component TOP_INC4 is
    port (
        -- Clock
--        CLOCK_50, CLOCK2_50, CLOCK3_50, CLOCK4_50: in std_logic; -- M9(Bank 3B) H13(Bank 7A)  E10(Bank 8A) V15(Bank 4A)
        -- Push-button
--        KEY0_n: in std_logic;  -- U7
--        KEY1_n: in std_logic;  -- W9
--        KEY2_n: in std_logic;  -- M7
--        KEY3_n: in std_logic;  -- M6
--        RESET_n: in std_logic;  -- P22
        -- Slide Switch
        SW: in std_logic_vector(9 downto 0);  -- AB12 AB13 AA13 AA14 AB15 AA15 T12 T13 V13 U13
        -- LED
--        LED: out std_logic_vector(9 downto 0);  -- L1 L2 U1 U2 N1 N2 Y3 W2 AA1 AA2
        -- 7-segment display
        --      0
        --     ----
        --  5 / 6  / 1
        --     ----
        --  4 /    / 2
        --     ----
        --      3
        HEX0_n: out std_logic_vector(6 downto 0);  -- AA22 Y21 Y22 W21 W22 V21 U21
        HEX1_n: out std_logic_vector(6 downto 0);  -- U22 AA17 AB18 AA18 AA19 AB20 AA20
        HEX2_n: out std_logic_vector(6 downto 0)  -- AB21 AB22 V14 Y14 AA10 AB17 Y19
--        HEX3_n: out std_logic_vector(6 downto 0);  -- V19 V18 U17 V16 Y17 W16 Y16
--        HEX4_n: out std_logic_vector(6 downto 0);  -- P9 Y15 U15 U16 V20 Y20 U20
--        HEX5_n: out std_logic_vector(6 downto 0);  -- W19 C2 C1 P14 T14 M8 N9
    );
end component TOP_INC4;

-- 複数のアーキテクチャがある場合にどちらにするのかを指定する。
for DUV: TOP_INC4 -- インスタンス名: エンティティ名
    use configuration work.top_inc4_cfg;

signal SW: std_logic_vector(9 downto 0) := "0000000000";  -- 入力
signal HEX0_n, HEX1_n, HEX2_n: std_logic_vector(6 downto 0);  -- 点灯パターン

begin
	SIM_DATA_IO: process
	file TEST_OUT: text open write_mode is OUTPUT_FILE;
	variable LINE_OUT: line;
	variable SEPARATOR: character := ':';
	begin
		wait for 10 ns;
		-- 1周期分の動作 (繰り返し実行される。)
		write(LINE_OUT, SW(3 downto 0), right, 8);
		write(LINE_OUT, SEPARATOR);
		write(LINE_OUT, not HEX2_n, right, 8);
		write(LINE_OUT, not HEX1_n, right, 8);
		write(LINE_OUT, not HEX0_n, right, 8);
		writeline(TEST_OUT, LINE_OUT);

		-- 入力データを更新する。
		SW <= SW + 1;

		-- 入力ファイルの終わりを検出する。
		assert SW(3 downto 0) /= "1111" report "End of input." severity failure;
	end process;

	-- 検証対象回路のコンポーネントを用意する。
	DUV: TOP_INC4
		port map (
			SW => SW,
			HEX0_n => HEX0_n,
            HEX1_n => HEX1_n,
            HEX2_n => HEX2_n
		);
end TB;
