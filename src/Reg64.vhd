library ieee;
use ieee.std_logic_1164.all;

entity Reg64 is port (
	clk, ld : in std_logic;
	d		: in std_logic_vector(63 downto 0);
	q		: out std_logic_vector(63 downto 0)
);
end Reg64;

architecture ckt of Reg64 is

	signal qs: std_logic_vector(63 downto 0) := (others => '0');

begin
	
	process (clk, ld)
	begin
		if clk ='1' and clk'event and ld = '1' then
			qs <= d;
		end if;
	end process ;
	
	q <= qs;
end ckt;