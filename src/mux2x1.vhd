library ieee;
use ieee.std_logic_1164.all;

entity Mux2x1 is port (
    input0, input1  : in std_logic_vector;
	sel             : in std_logic;
	output          : out std_logic_vector
);
end Mux2x1;

architecture Behavioral of Mux2x1 is

begin

  output <= input0 when sel = '0' else input1;
  
end Behavioral;