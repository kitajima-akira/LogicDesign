-- tb_p_enc8.vhd - 8ビットプライオリティエンコーダ用テストベンチ
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

-- 8ビットプライオリティエンコーダ用テストベンチ
entity TB_P_ENC8 is
end TB_P_ENC8;

architecture TB of TB_P_ENC8 is
-- 8ビットプライオリティエンコーダ(テスト対象回路)
component P_ENC8
	port (
		D: in std_logic_vector(7 downto 0);  -- 入力値
		Y: out std_logic_vector(2 downto 0)   -- 符号化値
	);
end component P_ENC8;

-- テスト対象回路の入出力用信号
signal D: std_logic_vector(7 downto 0) := X"FF";
signal Y: std_logic_vector(2 downto 0);

begin
	-- テスト対象回路に与える入力信号の列(テストベクタ)を生成するプロセス
	-- 入力D用
	P1: process
	begin
		D <= D + 1;
		wait for 50 ns;
	end process;

	-- テスト対象回路のインスタンス
	DUV: P_ENC8
	   port map (
			D => D, 
			Y => Y 
		);
end TB;
