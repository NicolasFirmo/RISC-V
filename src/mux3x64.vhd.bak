library ieee ;
use ieee . std_logic_1164 .all;
entity mux4x64 is
port (e0, e1, e2, e3 : in std_logic_vector(63 downto 0);
		sw : in std_logic_vector(1 downto 0);
		s: out std_logic_vector(63 downto 0));
end mux4x64;

architecture ckt of mux4x64 is
begin
process (e0, e1, e2, e3 , sw)
begin
	case sw is
      when "00" => s <= e0;
      when "01" => s <= e1;
      when "10" => s <= e2;
      when "11" => s <= e3;
    end case;
end process;
end ckt ;