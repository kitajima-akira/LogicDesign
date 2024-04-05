-- tb_inc4.vhd - 4ビット+1加算器用テストベンチ
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

-- 4ビット+1加算器用テストベンチ
entity TB_INC4 is
end TB_INC4;

architecture TB of TB_INC4 is
-- 4ビット+1加算器
component INC4
	port (
		A: in std_logic_vector(3 downto 0);  -- 入力値
		C: out std_logic;  -- 桁上がり
		S: out std_logic_vector(3 downto 0)  -- 加算値
	);
end component INC4;

-- 複数のアーキテクチャがある場合にどちらにするのかを指定する。
for DUV: INC4 -- インスタンス名: エンティティ名
	use entity WORK.INC4(LOGIC);  -- 論理記述
--	use entity WORK.INC4(LOGIC_VECTOR);  -- ビットベクタを用いた論理記述

-- 検証対象回路の入出力用信号
signal A: std_logic_vector(3 downto 0) := X"F";
signal S: std_logic_vector(3 downto 0);
signal C: std_logic;

begin
	-- 検証対象回路に与える入力信号の列(テストベクタ)を生成するプロセス
	-- 入力A用
	P1: process
	begin
		A <= A + 1;
		wait for 10 ns;
	end process;

	-- 検証対象回路のインスタンス
	DUV: INC4
		port map (
			A => A, 
			C => C,
			S => S
		);
end TB;
