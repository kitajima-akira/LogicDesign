-- tb_sel2_4.vhd - 4ビット2入力セレクタ用テストベンチ
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


-- 4ビット2入力セレクタ用テストベンチ
entity TB_SEL2_4 is
end TB_SEL2_4;

architecture TB of TB_SEL2_4 is
-- 4ビット2入力セレクタ(テスト対象回路)
component SEL2_4
	port (
		S: in std_logic;	-- 選択信号
		D0, D1: in std_logic_vector(3 downto 0);	-- 入力値
		Y: out std_logic_vector(3 downto 0)	-- 出力値
	);
end component SEL2_4;

-- 複数のアーキテクチャがある場合にどちらにするのかを指定する。
for DUV: SEL2_4 -- インスタンス名: エンティティ名
	use entity WORK.SEL2_4(LOGIC_VECTOR);  -- 論理記述
--	use entity WORK.SEL2_4(BEHAVIOR);  -- 動作記述

-- テスト対象回路の入出力用信号
signal D0, D1: std_logic_vector(3 downto 0) := X"0";
signal S: std_logic := '1';
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
		D1 <= D1 + 1;
		wait for 160 ns;
	end process;

	-- 入力S用
	P3: process
	begin
		S <= not S;
		wait for 20 ns;
	end process;

	-- テスト対象回路のインスタンス
	DUV: SEL2_4
	   port map (
			D0 => D0, 
			D1 => D1, 
			S => S,
			Y => Y
		);
end TB;
