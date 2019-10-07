library ieee;
use ieee.std_logic_1164.all;

entity mux4x64 is port (
  e0, e1, e2, e3  : in std_logic_vector(63 downto 0);
	sw              : in std_logic_vector(1 downto 0);
	s               : out std_logic_vector(63 downto 0)
);
end mux4x64;

architecture ckt of mux4x64 is
begin
  s <= e0 when sw = "00" else
       e1 when sw = "01" else
       e2 when sw = "10" else e3;
end ckt ;