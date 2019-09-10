library ieee;
use ieee.std_logic_1164.all;

entity Shift64R8 is port(
	en: 		in std_logic;
	entrada: in std_logic_vector(63 downto 0);
	saida: 	out std_logic_vector(63 downto 0)
);
end Shift64R8;

architecture bhvr of Shift64R8 is
begin
	saida(63 downto 56) <= (entrada(63 downto 56) and not (63 downto 56 => en));
	saida(55 downto 0) <= (
							(entrada(63 downto 8) and (55 downto 0 => en))
								xor 
							(entrada(55 downto 0) and (63 downto 8 => not en))
						);
	
end bhvr;