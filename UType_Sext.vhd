library ieee ;
use ieee . std_logic_1164 .all;
use ieee.numeric_std.all;
entity UType_Sext is
port (e: in std_logic_vector(19 downto 0);
		s: out std_logic_vector(63 downto 0));
end UType_Sext ;

architecture ckt of UType_Sext is
begin
	 s <= std_logic_vector(resize(signed(e), s'length));
end ckt ;