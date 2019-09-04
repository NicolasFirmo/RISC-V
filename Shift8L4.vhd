library ieee;
use ieee.std_logic_1164.all;

entity Shift8L4 is port(
	en: 		in std_logic;
	entrada: in std_logic_vector(7 downto 0);
	saida: 	out std_logic_vector(7 downto 0)
);
end Shift8L4;

architecture bhvr of Shift8L4 is
begin
	saida(3 downto 0) <= (entrada(3 downto 0) and not (3 downto 0 => en));
	saida(7 downto 4) <= (
							(entrada(3 downto 0) and (3 downto 0 => en))
								xor 
							(entrada(7 downto 4) and (3 downto 0 => not en))
						);
	
end bhvr;