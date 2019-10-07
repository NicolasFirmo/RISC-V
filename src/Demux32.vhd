library ieee;
use ieee.std_logic_1164.all;

entity Demux32 is port (
	addr    : in std_logic_vector(4 downto 0);
    en      : in std_logic;
    q       : out std_logic_vector(31 downto 0)
);
end Demux32;

architecture ckt of Demux32 is
    
    signal q_aux : std_logic_vector(31 downto 0) := (others => '0');

begin
	
	q_aux(0)  <= '1' when addr = "00000" else '0';
    q_aux(1)  <= '1' when addr = "00001" else '0';
    q_aux(2)  <= '1' when addr = "00010" else '0';
    q_aux(3)  <= '1' when addr = "00011" else '0';
    q_aux(4)  <= '1' when addr = "00100" else '0';
    q_aux(5)  <= '1' when addr = "00101" else '0';
    q_aux(6)  <= '1' when addr = "00110" else '0';
    q_aux(7)  <= '1' when addr = "00111" else '0';
    q_aux(8)  <= '1' when addr = "01000" else '0';
    q_aux(9)  <= '1' when addr = "01001" else '0';
    q_aux(10) <= '1' when addr = "01010" else '0';
    q_aux(11) <= '1' when addr = "01011" else '0';
    q_aux(12) <= '1' when addr = "01100" else '0';
    q_aux(13) <= '1' when addr = "01101" else '0';
    q_aux(14) <= '1' when addr = "01110" else '0';
    q_aux(15) <= '1' when addr = "01111" else '0';
    q_aux(16) <= '1' when addr = "10000" else '0';
    q_aux(17) <= '1' when addr = "10001" else '0';
    q_aux(18) <= '1' when addr = "10010" else '0';
    q_aux(19) <= '1' when addr = "10011" else '0';
    q_aux(20) <= '1' when addr = "10100" else '0';
    q_aux(21) <= '1' when addr = "10101" else '0';
    q_aux(22) <= '1' when addr = "10110" else '0';
    q_aux(23) <= '1' when addr = "10111" else '0';
    q_aux(24) <= '1' when addr = "11000" else '0';
    q_aux(25) <= '1' when addr = "11001" else '0';
    q_aux(26) <= '1' when addr = "11010" else '0';
    q_aux(27) <= '1' when addr = "11011" else '0';
    q_aux(28) <= '1' when addr = "11100" else '0';
    q_aux(29) <= '1' when addr = "11101" else '0';
    q_aux(30) <= '1' when addr = "11110" else '0';
    q_aux(31) <= '1' when addr = "11111" else '0';

    q <= q_aux and (31 downto 0 => en);

end ckt;