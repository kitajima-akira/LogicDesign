-- top_ex1_5.vhd - DE0-CV用トップレベル記述 (課題1.5)
library IEEE;
use IEEE.std_logic_1164.all;

entity TOP_EX1_5 is
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
        HEX0_n: out std_logic_vector(6 downto 0)  -- AA22 Y21 Y22 W21 W22 V21 U21
        -- HEX1_n: out std_logic_vector(6 downto 0);  -- U22 AA17 AB18 AA18 AA19 AB20 AA20
        -- HEX2_n: out std_logic_vector(6 downto 0);  -- AB21 AB22 V14 Y14 AA10 AB17 Y19
        -- HEX3_n: out std_logic_vector(6 downto 0);  -- V19 V18 U17 V16 Y17 W16 Y16
        -- HEX4_n: out std_logic_vector(6 downto 0);  -- P9 Y15 U15 U16 V20 Y20 U20
        -- HEX5_n: out std_logic_vector(6 downto 0)   -- W19 C2 C1 P14 T14 M8 N9
    );
end TOP_EX1_5;

architecture STRUCTURE of TOP_EX1_5 is
-- 複数のプロセス文の例
component EX1_5 is
    port (
        D: in std_logic_vector(7 downto 0);
        Y: out std_logic_vector(6 downto 0)
    );
end component EX1_5;

-- 正論理用の信号
--signal KEY0: std_logic;  -- プッシュスイッチ
signal HEX0: std_logic_vector(6 downto 0);  -- 7セグメントLED
-- 接続用信号
signal D: std_logic_vector(7 downto 0);

begin
    -- 負論理の入力を正論理に直す。
--    KEY0 <= not KEY0_n;

    -- 正論理の信号を負論理にして出力する。
    HEX0_n <= not HEX0;
    -- HEX1_n <= not HEX1;
    -- HEX2_n <= not HEX2;
    -- HEX3_n <= not HEX3;
    -- HEX4_n <= not HEX4;
    -- HEX5_n <= not HEX5;

    C: EX1_5
        port map (
            D => SW(7 downto 0),
            Y => HEX0
        );
end STRUCTURE;
