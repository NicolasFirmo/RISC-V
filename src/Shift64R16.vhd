library ieee;
use ieee.std_logic_1164.all;

entity Shift64R16 is port(
	en: 		in std_logic;
	entrada: in std_logic_vector(63 downto 0);
	saida: 	out std_logic_vector(63 downto 0)
);
end Shift64R16;

architecture bhvr of Shift64R16 is
begin
	saida(63 downto 48) <= (entrada(63 downto 48) and not (63 downto 48 => en));
	saida(47 downto 0) <= (
							(entrada(63 downto 16) and (47 downto 0 => en))
								xor 
							(entrada(47 downto 0) and (63 downto 16 => not en))
						);
	
end bhvr;