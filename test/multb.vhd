library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity MulTB is
end MulTB;
 
architecture Behavior OF MulTB IS 
 
    -- Component Declaration
 
    component Mul is port(
        A, B		: in std_logic_vector(63 downto 0);
        C, D        : out std_logic_vector(63 downto 0)
    );
    end component;

    --Inputs
    signal A, B   : std_logic_vector(63 downto 0) := (others => '0');

    --Outputs
    signal C, D   : std_logic_vector(63 downto 0);

    -- Clock period definitions
    constant CLOCK_PERIOD : time := 10 ns;
 
begin
    -- Instantiate the single-port RAM in VHDL
    uut: Mul port map (A, B, C, D);

    stim_proc: process
    begin
        A <= x"FFFFFFFFFFFFFFFE";
        B <= x"0000000000000002";

        wait for CLOCK_PERIOD;
        
        A <= x"FFCCCCCCCCCCCCCC";
        B <= x"0000000000000003";

        wait for CLOCK_PERIOD;
    end process;

end architecture Behavior;