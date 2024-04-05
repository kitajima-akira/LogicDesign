-- tb_mathop4.vhd - 4ビット算術演算用テストベンチ
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

-- 4ビット算術演算用テストベンチ
entity TB_MATHOP4 is
end TB_MATHOP4;

architecture TB of TB_MATHOP4 is
-- 4ビット算術演算(検証対象回路)
component MATHOP4
	port (
		A, B: in std_logic_vector(3 downto 0);
		S: out std_logic_vector(3 downto 0);
		D: out std_logic_vector(3 downto 0);
		P: out std_logic_vector(7 downto 0)
	);
end component MATHOP4;

-- 検証対象回路の入出力用信号
signal A, B: std_logic_vector(3 downto 0) := X"0";
signal S, D: std_logic_vector(3 downto 0);
signal P: std_logic_vector(7 downto 0);

begin
	-- 検証対象回路に与える入力信号の列(テストベクタ)を生成するプロセス
	-- 入力A用
	P1: process
	begin
		A <= A + 7;
		wait for 10 ns;
	end process;

	-- 入力B用
	P2: process
	begin
		B <= B + 1;
		wait for 100 ns;
	end process;

	-- 検証対象回路のインスタンス
	DUV: MATHOP4
		port map (
			A => A, 
			B => B, 
			S => S,
			D => D,
			P => P 
		);
end TB;
