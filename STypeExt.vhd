library ieee ;
use ieee.std_logic_1164 .all;

entity STypeExt is port (
	e: in std_logic_vector(11 downto 0);
	s: out std_logic_vector(63 downto 0)
);
end STypeExt;

architecture ckt of STypeExt is
begin
	s(11 downto 0) <= e(11 downto 0);
	s(63 downto 1) <= (others => e(11));
end ckt ;