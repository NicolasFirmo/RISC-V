library ieee ;
use ieee . std_logic_1164 .all;
use ieee.numeric_std.all;
entity SType_Sext is
port (e: in std_logic_vector(11 downto 0);
		s: out std_logic_vector(63 downto 0));
end SType_Sext ;

architecture ckt of SType_Sext is
begin
	 s <= std_logic_vector(resize(signed(e), s'length));
end ckt ;