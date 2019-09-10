library ieee ;
use ieee . std_logic_1164 .all;
entity mux3x64 is
port (e0, e1, e2 : in std_logic_vector(63 downto 0);
		sw : in std_logic_vector(1 downto 0);
		s: out std_logic_vector(63 downto 0));
end mux3x64;

architecture ckt of mux3x64 is
begin
process (e0, e1, e2, sw)
begin
	case sw is
      when "00" => s <= e0;
      when "01" => s <= e1;
      when "10" => s <= e2;
      when "11" => s <= "0000000000000000000000000000000000000000000000000000000000000000";
    end case;
end process;
end ckt ;