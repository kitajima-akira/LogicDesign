-- tb_full_adder.vhd - 全加算器用テストベンチ
library IEEE;
use IEEE.std_logic_1164.all;

-- 全加算器用テストベンチ
entity TB_FULL_ADDER is
end TB_FULL_ADDER;

architecture TB of TB_FULL_ADDER is
-- 半加算器(テスト対象回路)
component FULL_ADDER
	port (
		A, B, CI: in std_logic;
		S, CO: out std_logic
	);
end component FULL_ADDER;

-- 複数のアーキテクチャがある場合にどちらにするのかを指定する。
for DUV: FULL_ADDER  -- インスタンス名: エンティティ名
	use entity WORK.FULL_ADDER(LOGIC);  -- 論理記述
--	use entity WORK.FULL_ADDER(STRUCTURE);  -- コンポーネントを用いた構造記述

-- テスト対象回路の入出力用信号
signal A, B, CI, S, CO: std_logic;

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

	-- 入力CI用
	P3: process
	begin
		CI <= '0';
		wait for 200 ns;
		CI <= '1';
		wait for 200 ns;
	end process;

	-- テスト対象回路のインスタンス
	DUV: FULL_ADDER
	   port map (
			A => A, 
			B => B,
			CI => CI, 
			S => S, 
			CO => CO
		);
end TB;
