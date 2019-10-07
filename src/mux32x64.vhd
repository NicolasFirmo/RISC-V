library ieee;
use ieee.std_logic_1164.all;

entity mux32x64 is port (
    e0,  e1,  e2,  e3,
    e4,  e5,  e6,  e7,
    e8,  e9,  e10, e11,
    e12, e13, e14, e15,
    e16, e17, e18, e19,
    e20, e21, e22, e23,
    e24, e25, e26, e27,
    e28, e29, e30, e31  : in std_logic_vector(63 downto 0);
    sw                  : in std_logic_vector(4 downto 0);
    s                   : out std_logic_vector(63 downto 0)
);
end mux32x64;

architecture ckt of mux32x64 is
begin
  s <= e0  when sw = "00000" else
       e1  when sw = "00001" else
       e2  when sw = "00010" else
       e3  when sw = "00011" else
       e4  when sw = "00100" else
       e5  when sw = "00101" else
       e6  when sw = "00110" else
       e7  when sw = "00111" else
       e8  when sw = "01000" else
       e9  when sw = "01001" else
       e10 when sw = "01010" else
       e11 when sw = "01011" else
       e12 when sw = "01100" else
       e13 when sw = "01101" else
       e14 when sw = "01110" else 
       e15 when sw = "01111" else 
       e16 when sw = "10000" else
       e17 when sw = "10001" else
       e18 when sw = "10010" else
       e19 when sw = "10011" else
       e20 when sw = "10100" else
       e21 when sw = "10101" else
       e22 when sw = "10110" else
       e23 when sw = "10111" else
       e24 when sw = "11000" else
       e25 when sw = "11001" else
       e26 when sw = "11010" else
       e27 when sw = "11011" else
       e28 when sw = "11100" else
       e29 when sw = "11101" else
       e30 when sw = "11110" else e31;
end ckt;