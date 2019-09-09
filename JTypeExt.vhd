library ieee ;
use ieee.std_logic_1164.all;

entity JTypeExt is port (
	e: in std_logic_vector(19 downto 0);
	s: out std_logic_vector(63 downto 0)
);
end JTypeExt;

architecture ckt of JTypeExt is
begin
    s(0) <= '0';
    s(20 downto 1) <= e(19 downto 0);
	s(63 downto 21) <= (others => e(19));
end ckt;