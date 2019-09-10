library ieee;
use ieee.std_logic_1164.all;

entity Shift64R32 is port(
	en: 		in std_logic;
	entrada: in std_logic_vector(63 downto 0);
	saida: 	out std_logic_vector(63 downto 0)
);
end Shift64R32;

architecture bhvr of Shift64R32 is
begin
	saida(63 downto 32) <= (entrada(63 downto 32) and not (63 downto 32 => en));
	saida(31 downto 0) <= (
							(entrada(63 downto 32) and (31 downto 0 => en))
								xor 
							(entrada(31 downto 0) and (63 downto 32 => not en))
						);
	
end bhvr;