-- tb_addsub16.vhd - 16ビット加減算器用テストベンチ
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


-- 16ビット加減算器用テストベンチ
entity TB_ADDSUB16 is
end TB_ADDSUB16;

architecture TB of TB_ADDSUB16 is
-- 16ビット加減算器(検証対象回路)
component ADDSUB16
	port (
		A, B: in std_logic_vector(15 downto 0);  -- 入力値
		SUB: in std_logic;  -- 演算選択(1で減算・0で加算)
		CI: in std_logic;  -- 演算選択(1で減算・0で加算)
		G: out std_logic_vector(15 downto 0);  -- 加算または減算の値
		CO: out std_logic  -- 桁上がり出力
	);
end component ADDSUB16;

-- 検証対象回路の入出力用信号
signal A3, A2, A1, A0, B3, B2, B1, B0: std_logic_vector(3 downto 0) := X"0";
signal A, B: std_logic_vector(15 downto 0) := X"0000";
signal SUB: std_logic := '0';
signal CI: std_logic;
signal G: std_logic_vector(15 downto 0);
signal CO: std_logic;

begin
	A <= A3 & A2 & A1 & A0;
	B <= B3 & B2 & B1 & B0;
	CI <= SUB;

	-- 検証対象回路に与える入力信号の列(テストベクタ)を生成するプロセス
	-- 入力A用
	P1: process
	begin
		A3 <= A3 + 1;
		A2 <= A2 + 3;
		A1 <= A1 + 5;
		A0 <= A0 + 7;
		wait for 10 ns;
	end process;

	-- 入力B用
	P2: process
	begin
		B3 <= B3 + 9;
		B2 <= B2 + 11;
		B1 <= B1 + 13;
		B0 <= B0 + 15;
		wait for 100 ns;
	end process;

	-- 入力SUB用
	P3: process
	begin
		SUB <= not SUB;
		wait for 5 ns;
	end process;

	-- 検証対象回路のインスタンス
	DUV: ADDSUB16
		port map (
			A => A, 
			B => B,
			SUB => SUB,
			CI => CI,
			G => G,
			CO => CO
		);
end TB;
