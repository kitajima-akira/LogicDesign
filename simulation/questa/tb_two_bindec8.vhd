-- tb_two_bindec8.vhd - 8ビットバイナリデコーダ二つ分の回路のテストベンチ
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

-- 8ビットバイナリデコーダ二つ分の回路のテストベンチ
entity TB_TWO_BINDEC8 is
end TB_TWO_BINDEC8;

architecture TB of TB_TWO_BINDEC8 is
-- バイナリデコーダ二つ分の回路
component TWO_BINDEC8
	port (
		A, B: in std_logic_vector(2 downto 0);  -- 二つの3ビット入力
		YA, YB: out std_logic_vector(7 downto 0)  -- 二つの8ビット出力
	);
end component TWO_BINDEC8;

signal A, B: std_logic_vector(2 downto 0) := "000";
signal YA, YB: std_logic_vector(7 downto 0);

begin
	INPUT: process
	begin
		wait for 10 ns;
		-- 1周期分の動作 (繰り返し実行される。)

		-- 入力データを更新する。
		A <= A + 1;
		B <= B + 3;
	end process;

	-- 検証対象回路のコンポーネントを用意する。
	DUV: TWO_BINDEC8
		port map (
			A => A,
			B => B,
			YA => YA,
			YB => YB
		);
end TB;
