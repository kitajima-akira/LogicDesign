-- tb_bin_encoder4.vhd - 4ビットバイナリエンコーダ用テストベンチ
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

-- 4ビットバイナリエンコーダ用テストベンチ
entity TB_BIN_ENCODER4 is
end TB_BIN_ENCODER4;

architecture TB of TB_BIN_ENCODER4 is
-- 4ビットバイナリエンコーダ(テスト対象回路)
component BIN_ENCODER4
	port (
		D: in std_logic_vector(3 downto 0); -- 入力値
		Y: out std_logic_vector(1 downto 0) -- 符号化値
	);
end component BIN_ENCODER4;

-- テスト対象回路の入出力用信号
signal D: std_logic_vector(3 downto 0) := "1111";
signal Y: std_logic_vector(1 downto 0);

begin
	-- テスト対象回路に与える入力信号の列(テストベクタ)を生成するプロセス
	-- 入力D用
	P1: process
	begin
		D <= D + 1;
		wait for 50 ns;
	end process;

	-- テスト対象回路のインスタンス
	DUV: BIN_ENCODER4
	   port map (
			D => D, 
			Y => Y 
		);
end TB;
