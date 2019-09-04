library ieee;
use ieee.std_logic_1164.all;

entity Shift8L2 is port(
	en: 		in std_logic;
	entrada: in std_logic_vector(7 downto 0);
	saida: 	out std_logic_vector(7 downto 0)
);
end Shift8L2;

architecture bhvr of Shift8L2 is
begin
	saida(1 downto 0) <= (entrada(1 downto 0) and not (1 downto 0 => en));
	saida(7 downto 2) <= (
							(entrada(5 downto 0) and (5 downto 0 => en))
								xor 
							(entrada(7 downto 2) and (5 downto 0 => not en))
						);
	
end bhvr;