library ieee;
use ieee.std_logic_1164.all;

entity Shift64L8 is port(
	en: 		in std_logic;
	entrada: in std_logic_vector(63 downto 0);
	saida: 	out std_logic_vector(63 downto 0)
);
end Shift64L8;

architecture bhvr of Shift64L8 is
begin
	saida(7 downto 0) <= (entrada(7 downto 0) and not (7 downto 0 => en));
	saida(63 downto 8) <= (
							(entrada(55 downto 0) and (55 downto 0 => en))
								xor 
							(entrada(63 downto 8) and (63 downto 8 => not en))
						);
	
end bhvr;