-- top_disp7seg.vhd - DE0-CV用トップレベル記述 (7セグメントLEDデコーダ)
library IEEE;
use IEEE.std_logic_1164.all;

entity TOP_DISP7SEG is
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
        HEX1_n: out std_logic_vector(6 downto 0)  -- U22 AA17 AB18 AA18 AA19 AB20 AA20
--        HEX2_n: out std_logic_vector(6 downto 0);  -- AB21 AB22 V14 Y14 AA10 AB17 Y19
--        HEX3_n: out std_logic_vector(6 downto 0);  -- V19 V18 U17 V16 Y17 W16 Y16
--        HEX4_n: out std_logic_vector(6 downto 0);  -- P9 Y15 U15 U16 V20 Y20 U20
--        HEX5_n: out std_logic_vector(6 downto 0);  -- W19 C2 C1 P14 T14 M8 N9
    );
end TOP_DISP7SEG;

architecture STRUCTURE of TOP_DISP7SEG is
-- 7セグメントLEDデコーダ
--        Y(6)
--        __
-- Y(1)  /__/ Y(5)
--       Y(0)
-- Y(2)  /__/ Y(4)
--       Y(3)
component DECODER_7SEG is
	port (
		D: in std_logic_vector(3 downto 0);  -- 数値の2進表現
		Y: out std_logic_vector(6 downto 0) -- 点灯バターン
	);
end component DECODER_7SEG;

-- 正論理用の信号
--signal KEY0: std_logic;  -- プッシュスイッチ
signal HEX0, HEX1: std_logic_vector(6 downto 0);  -- 7セグメントLED

begin
    -- 負論理の入力を正論理に直す。
--    KEY0 <= not KEY0_n;
    -- 正論理の信号を負論理にして出力する。
    HEX0_n <= not HEX0;

    DEC0: DECODER_7SEG
        port map (
            D => SW(3 downto 0),
            Y => HEX0
        );
--    HEX0_n <= not (DEC0_Y(0) & DEC0_Y(1) & DEC0_Y(2) & DEC0_Y(3) & DEC0_Y(4) & DEC0_Y(5) & DEC0_Y(6));

    DEC1: DECODER_7SEG
        port map (
            D => SW(7 downto 4),
            Y => HEX1
        );
--    HEX1_n <= not (DEC1_Y(0) & DEC1_Y(1) & DEC1_Y(2) & DEC1_Y(3) & DEC1_Y(4) & DEC1_Y(5) & DEC1_Y(6));
    HEX1_n <= not HEX1;
end STRUCTURE;

-- DECODER_7SEGにどのアーキテクチャを用いるのかの指定
configuration TOP_DISP7SEG_CFG of TOP_DISP7SEG is
    for STRUCTURE
        for DEC0: DECODER_7SEG
            use entity work.DECODER_7SEG(DATAFLOW); -- ()内にアーキテクチャ名を書くとそのアーキテクチャが使われる。
        end for;
        for DEC1: DECODER_7SEG
            use entity work.DECODER_7SEG(DATAFLOW);
        end for;
    end for;
end configuration TOP_DISP7SEG_CFG;
