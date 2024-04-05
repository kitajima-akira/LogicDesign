-- tb_addsub4.vhd - 4ビット加減算器用テストベンチ
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


-- 4ビット加減算器用テストベンチ
entity TB_ADDSUB4 is
end TB_ADDSUB4;

architecture TB of TB_ADDSUB4 is
-- 4ビット加減算器(検証対象回路)
component ADDSUB4
	port (
		A, B: in std_logic_vector(3 downto 0);  -- 入力値
		SUB: in std_logic;  -- 演算選択(1で減算・0で加算)
		CI: in std_logic;  -- 桁上がり入力
		G: out std_logic_vector(3 downto 0);  -- 加算または減算の値
		CO: out std_logic  -- 桁上がり出力
	);
end component ADDSUB4;

-- 複数のアーキテクチャがある場合にどちらにするのかを指定する。
for DUV: ADDSUB4 -- インスタンス名: エンティティ名
	use entity WORK.ADDSUB4(LOGIC_VECTOR);  -- ビットベクタを用いた論理記述
--	use entity WORK.ADDSUB4(STRUCTURE);  -- コンポーネントを用いた構造記述

-- 検証対象回路の入出力用信号
signal A, B: std_logic_vector(3 downto 0) := X"0";
signal SUB: std_logic := '1';
signal CI: std_logic;
signal G: std_logic_vector(3 downto 0);
signal CO: std_logic;

begin
	CI <= SUB;

	-- 検証対象回路に与える入力信号の列(テストベクタ)を生成するプロセス
	-- 入力A用
	P1: process
	begin
		A <= A + 7;
		wait for 20 ns;
	end process;

	-- 入力B用
	P2: process
	begin
		B <= B + 1;
		wait for 200 ns;
	end process;

	-- 入力SUB用
	P3: process
	begin
		SUB <= not SUB;
		wait for 10 ns;
	end process;

	-- 検証対象回路のインスタンス
	DUV: ADDSUB4
		port map (
			A => A, 
			B => B,
			SUB => SUB,
			CI => CI,
			G => G,
			CO => CO
		);
end TB;
