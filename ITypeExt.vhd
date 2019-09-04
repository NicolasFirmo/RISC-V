library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ITypeExt is port (
	e: in std_logic_vector(11 downto 0);
	s: out std_logic_vector(63 downto 0)
);
end ITypeExt;

architecture ckt of ITypeExt is
begin
	s(11 downto 0)  <= e;
	s(63 downto 12) <= (others => e(11));
end ckt;