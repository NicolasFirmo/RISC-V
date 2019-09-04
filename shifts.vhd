library ieee;
use ieee.std_logic_1164.all;

entity shifts is port(
	en: 		in std_logic;
	entrada: in std_logic_vector(7 downto 0);
	saida: 	out std_logic_vector(7 downto 0)
);
end shifts;

architecture bhvr of shifts is
begin
	saida(0) <= (entrada(0) and not en);
	saida(7 downto 1) <= (
									(entrada(6 downto 0) and (6 downto 0 => en))
									xor 
									(entrada(7 downto 1) and (6 downto 0 => not en))
								);
	
end bhvr;