library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UTypeExt is port (
	e: in std_logic_vector(19 downto 0);
	s: out std_logic_vector(63 downto 0)
);
end UTypeExt;

architecture ckt of UTypeExt is
begin
	s(11 downto 0)  <= (others => '0');
	s(31 downto 12) <= e;
	s(63 downto 32) <= (others => e(19));
end ckt ;