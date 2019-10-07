library ieee;
use ieee.std_logic_1164.all;

entity mux16x64 is port (
    e0,  e1,  e2,  e3,
    e4,  e5,  e6,  e7,
    e8,  e9,  e10, e11,
    e12, e13, e14, e15  : in std_logic_vector(63 downto 0);
    sw                  : in std_logic_vector(3 downto 0);
    s                   : out std_logic_vector(63 downto 0)
);
end mux16x64;

architecture ckt of mux16x64 is
begin
  s <= e0  when sw = "0000" else
       e1  when sw = "0001" else
       e2  when sw = "0010" else
       e3  when sw = "0011" else
       e4  when sw = "0100" else
       e5  when sw = "0101" else
       e6  when sw = "0110" else
       e7  when sw = "0111" else
       e8  when sw = "1000" else
       e9  when sw = "1001" else
       e10 when sw = "1010" else
       e11 when sw = "1011" else
       e12 when sw = "1100" else
       e13 when sw = "1101" else
       e14 when sw = "1110" else e15;
end ckt;