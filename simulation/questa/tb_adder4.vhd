-- tb_adder4.vhd - 4ビット加算器用テストベンチ
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

-- 4ビット加算器用テストベンチ
entity TB_ADDER4 is
end TB_ADDER4;

architecture TB of TB_ADDER4 is
-- 4ビット加算器(検証対象回路)
component ADDER4 is
	port (
		A, B: in std_logic_vector(3 downto 0);
		CI: in std_logic;
		S: out std_logic_vector(3 downto 0);
		CO: out std_logic
	);
end component ADDER4;

-- 複数のアーキテクチャがある場合にどちらにするのかを指定する。
for DUV: ADDER4 -- インスタンス名: エンティティ名
	use entity WORK.ADDER4(LOGIC);  -- 論理記述
--	use entity WORK.ADDER4(LOGIC_VECTOR);  -- ビットベクタを用いた論理記述
--	use entity WORK.ADDER4(BEHAVIOR);  -- 算術演算を用いた動作記述
--	use entity WORK.ADDER4(STRUCTURE);  -- コンポーネントを用いた構造記述

-- 検証対象回路の入出力用信号
signal A, B: std_logic_vector(3 downto 0) := X"F";
signal CI: std_logic := '1';
signal S: std_logic_vector(3 downto 0);
signal CO: std_logic;

begin
	-- 検証対象回路に与える入力信号の列(テストベクタ)を生成するプロセス
	-- 入力A用
	P1: process
	begin
		A <= A + 1;
		wait for 10 ns;
	end process;

	-- 入力B用
	P2: process
	begin
		B <= B + 1;
		wait for 160 ns;
	end process;

	-- 入力CI用
	P3: process
	begin
		CI <= not CI;
		wait for 160 * 16 ns;
	end process;

	-- 検証対象回路のインスタンス
	DUV: ADDER4
		port map (
			A => A, 
			B => B,
			CI => CI,
			S => S,
			CO => CO
		);
end TB;
