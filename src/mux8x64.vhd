library ieee;
use ieee.std_logic_1164.all;

entity mux4x64 is port (
    e0, e1, e2, e3,
    e4, e5, e6, e7  : in std_logic_vector(63 downto 0);
    sw              : in std_logic_vector(2 downto 0);
    s               : out std_logic_vector(63 downto 0)
);
end mux4x64;

architecture ckt of mux8x64 is
begin
  s <= e0 when sw = "000" else
       e1 when sw = "001" else
       e2 when sw = "010" else
       e3 when sw = "011" else
       e4 when sw = "100" else
       e5 when sw = "101" else
       e6 when sw = "110" else e7;
end ckt ;