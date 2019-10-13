library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity CLZTB is
end CLZTB;
 
architecture Behavior OF CLZTB IS 
 
    -- Component Declaration
 
    component CLZ is port(
        s : in std_logic_vector(63 downto 0);
        q : out std_logic_vector(6 downto 0)
    );
    end component;

    --Inputs
    signal s : std_logic_vector(63 downto 0) := (others => '0');

    --Outputs
    signal q : std_logic_vector(6 downto 0);

    -- Clock period definitions
    constant CLOCK_PERIOD : time := 10 ns;
 
begin
    uut: CLZ port map (s, q);

    stim_proc: process
    begin
        s <= x"FFFFFFFFFFFFFFFE";
        wait for CLOCK_PERIOD;

        s <= x"0000000000000007";
        wait for CLOCK_PERIOD;

    end process;

end architecture Behavior;