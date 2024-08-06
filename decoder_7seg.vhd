-- decoder_7seg.vhd - 7セグメントLEDデコーダ
library IEEE;
use IEEE.std_logic_1164.all;

-- 7セグメントLEDデコーダ
--        
--        --Y(6)--
--       /        /
--     Y(1)      Y(5)
--      /        /
--      /--Y(0)--/ 
--      /        /
--    Y(2)     Y(4)   
--     /        /
--      --Y(3)--
-- 
entity DECODER_7SEG is
	port (
		D: in std_logic_vector(3 downto 0);  -- 数値の2進表現
		Y: out std_logic_vector(6 downto 0) -- 点灯バターン
	);
end DECODER_7SEG;

architecture DATAFLOW of DECODER_7SEG is
begin
    process (D)
    begin
        case D is         -- 6543210
        when "0000" => Y <= "1111110";  -- 0
        when "0001" => Y <= "0110000";  -- 1
        when "0010" => Y <= "1101101";  -- 2
        when "0011" => Y <= "1111001";  -- 3
        when "0100" => Y <= "0110011";  -- 4
        when "0101" => Y <= "1011011";  -- 5
        when "0110" => Y <= "1011111";  -- 6
        when "0111" => Y <= "1110000";  -- 7
        when "1000" => Y <= "1111111";  -- 8
        when "1001" => Y <= "1111011";  -- 9
        when "1010" => Y <= "1110111";  -- A
        when "1011" => Y <= "0011111";  -- b
        when "1100" => Y <= "1001110";  -- C
        when "1101" => Y <= "0111101";  -- d
        when "1110" => Y <= "1001111";  -- E
        when "1111" => Y <= "1000111";  -- F
        when others => Y <= "-------";
        end case;
    end process;
end DATAFLOW;
