library ieee;
use ieee.std_logic_1164.all;

entity Shift64L16 is port(
	en: 		in std_logic;
	entrada: in std_logic_vector(63 downto 0);
	saida: 	out std_logic_vector(63 downto 0)
);
end Shift64L16;

architecture bhvr of Shift64L16 is
begin
	saida(15 downto 0) <= (entrada(15 downto 0) and not (15 downto 0 => en));
	saida(63 downto 16) <= (
							(entrada(47 downto 0) and (47 downto 0 => en))
								xor 
							(entrada(63 downto 16) and (63 downto 16 => not en))
						);
	
end bhvr;