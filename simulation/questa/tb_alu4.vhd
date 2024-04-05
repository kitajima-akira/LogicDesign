-- tb_alu4.vhd - 4ビットALU用テストベンチ
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

-- 4ビットALU用テストベンチ
entity TB_ALU4 is
end TB_ALU4;

architecture TB of TB_ALU4 is
-- 4ビットALU
component ALU4
	port (
		A, B: in std_logic_vector(3 downto 0);  -- 演算に用いる値
		W, X, Y, Z: in std_logic;  -- 何の演算をするのかの指定
		CI: in std_logic;  -- 桁上がり入力
		G: out std_logic_vector(3 downto 0);  -- 演算結果
		C: out std_logic_vector(3 downto 0)  -- ビットごとの桁上がり出力
	);
end component ALU4;

-- 検証対象回路の入出力用信号
signal A, B: std_logic_vector(3 downto 0) := X"F";
signal W, X, Y, Z: std_logic;
signal CI: std_logic := '0';
signal G, C: std_logic_vector(3 downto 0);

begin
	-- 検証対象回路に与える入力信号の列(テストベクタ)を生成するプロセス
	-- 入力A用
	P1: process
	begin
		A <= A + 7;
		wait for 100 ns;
	end process;

	-- 入力B用
	P2: process
	begin
		B <= B + 1;
		wait for 1600 ns;
	end process;

	-- 入力CI用
	P3: process
	begin
		CI <= not CI;
		wait for 10 ns;
	end process;

    -- 演算指定用
    P4: process
    begin
        -- 加算
        X <= '0';
        Y <= '1';
        Z <= '0';
        W <= '0';
        wait for 20 ns;
        -- 減算
        X <= '1';
        Y <= '1';
        Z <= '0';
        W <= '0';
        wait for 20 ns;
        -- AND
        X <= '0';
        Y <= '0';
        Z <= '1';
        W <= '0';
        wait for 20 ns;
        -- OR
        X <= '0';
        Y <= '0';
        Z <= '1';
        W <= '1';
        wait for 20 ns;
        -- XOR
        X <= '0';
        Y <= '0';
        Z <= '0';
        W <= '0';
        wait for 20 ns;
    end process;

	-- 検証対象回路のインスタンス
	DUV: ALU4
		port map (
			A => A, 
			B => B,
            W => W,
            X => X,
            Y => Y,
            Z => Z,
            CI => CI,
			G => G,
			C => C
		);
end TB;
