library ieee ;
use ieee . std_logic_1164 .all;
entity mux2x64 is
port (e0, e1 : in std_logic_vector(63 downto 0);
		sw : in std_logic;
		s: out std_logic_vector(63 downto 0));
end mux2x64 ;

architecture ckt of mux2x64 is
begin
process (e0, e1 , sw )
begin
	case sw is
      when '0' => s <= e0;
      when '1' => s <= e1;
    end case;
end process;
end ckt ;