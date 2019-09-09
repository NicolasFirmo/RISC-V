library ieee ;
use ieee.std_logic_1164.all;

entity BTypeExt is port (
	e: in std_logic_vector(11 downto 0);
	s: out std_logic_vector(63 downto 0)
);
end BTypeExt;

architecture ckt of BTypeExt is
begin
    s(10) <= '0';
	s(12 downto 1) <= e(11 downto 0);
    s(63 downto 13) <= (others => e(11));
end ckt ;