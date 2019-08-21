library ieee ;
use ieee . std_logic_1164 .all;
entity Reg32 is
port (clk,c,ld: in std_logic ;
		d: in std_logic_vector(31 downto 0);
		q : out std_logic_vector(31 downto 0));
end Reg32;
architecture ckt of Reg32 is
signal qs: std_logic_vector(31 downto 0);
begin
process (clk,c)
begin
if c = '0' then qs <= "00000000000000000000000000000000";
elsif clk ='1' and clk ' event and ld = '1' then
qs <= d;
end if;
end process ;
q <= qs;
end ckt;