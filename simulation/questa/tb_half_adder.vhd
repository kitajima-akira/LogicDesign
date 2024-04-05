-- tb_half_adder.vhd - 半加算器用テストベンチ
library IEEE;
use IEEE.std_logic_1164.all;

-- 半加算器用テストベンチ
entity TB_HALF_ADDER is
end TB_HALF_ADDER;

architecture TB of TB_HALF_ADDER is
-- 半加算器(テスト対象回路)
component HALF_ADDER
	port (
		A, B: in std_logic;
		S, C: out std_logic
	);
end component HALF_ADDER;

-- テスト対象回路の入出力用信号
signal A, B, S, C: std_logic;

begin
	-- テスト対象回路に与える入力信号の列(テストベクタ)を生成するプロセス
	-- 入力A用
	P1: process
	begin
		A <= '0';
		wait for 50 ns;
		A <= '1';
		wait for 50 ns;
	end process;

	-- 入力B用
	P2: process
	begin
		B <= '0';
		wait for 100 ns;
		B <= '1';
		wait for 100 ns;
	end process;

	-- テスト対象回路のインスタンス
	DUV: HALF_ADDER
	   port map (
			A => A, 
			B => B, 
			S => S, 
			C => C
		);
end TB;
