-- tb_max3_4.vhd - 4ビット3値の最大値選択回路用テストベンチ
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


-- 4ビット3値の最大値選択回路用テストベンチ
entity TB_MAX3_4 is
end TB_MAX3_4;

architecture TB of TB_MAX3_4 is
-- 4ビット3値の最大値選択回路(テスト対象回路)
component MAX3_4
	port (
		D0, D1, D2: in std_logic_vector(3 downto 0);	-- 入力値
		Y: out std_logic_vector(3 downto 0)	-- 出力値
	);
end component MAX3_4;

-- テスト対象回路の入出力用信号
signal D0, D1, D2: std_logic_vector(3 downto 0) := X"F";
signal Y: std_logic_vector(3 downto 0);

begin
	-- テスト対象回路に与える入力信号の列(テストベクタ)を生成するプロセス
	-- 入力D0用
	P1: process
	begin
		D0 <= D0 + 1;
		wait for 10 ns;
	end process;

	-- 入力D1用
	P2: process
	begin
		D1 <= D1 + 3;
		wait for 20 ns;
	end process;

	-- 入力D2用
	P3: process
	begin
		D2 <= D2 + 5;
		wait for 40 ns;
	end process;

	-- テスト対象回路のインスタンス
	DUV: MAX3_4
	   port map (
			D0 => D0, 
			D1 => D1, 
			D2 => D2, 
			Y => Y
		);
end TB;
