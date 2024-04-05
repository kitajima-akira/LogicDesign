-- tb_bin_decoder_8.vhd - 8ビットバイナリデコーダ用テストベンチ
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

-- 8ビットバイナリデコーダ用テストベンチ
entity TB_BIN_DECODER_8 is
end TB_BIN_DECODER_8;

architecture TB of TB_BIN_DECODER_8 is
-- 8ビットバイナリデコーダ(テスト対象回路)
component BIN_DECODER_8
	port (
		D: in std_logic_vector(2 downto 0); -- 符号化値
		Y: out std_logic_vector(7 downto 0) -- 復号値
	);
end component BIN_DECODER_8;

-- テスト対象回路の入出力用信号
signal D: std_logic_vector(2 downto 0) := "111";
signal Y: std_logic_vector(7 downto 0);

begin
	-- テスト対象回路に与える入力信号の列(テストベクタ)を生成するプロセス
	-- 入力D用
	P1: process
	begin
		D <= D + "001";
		wait for 50 ns;
	end process;

	-- テスト対象回路のインスタンス
	DUV: BIN_DECODER_8
	   port map (
			D => D, 
			Y => Y 
		);
end TB;
