library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity DivTB is
end DivTB;
 
architecture Behavior OF DivTB IS 
 
    -- Component Declaration
 
    component Div is port(
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
    uut: Div port map (A, B, C, D);

    stim_proc: process
    begin
        A <= x"8000000000000000";
        B <= x"FFFFFFFFFFFFFFFF";

        wait for CLOCK_PERIOD;
        
        A <= x"0000000000000141";
        B <= x"0000000001000021";

        wait for CLOCK_PERIOD;

        A <= x"FFFFFFFFFFFFEEBF";
        B <= x"0000000000000021";

        wait for CLOCK_PERIOD;

        A <= x"0000000000002141";
        B <= x"0000000000001021";

        wait for CLOCK_PERIOD;

        A <= x"0003056300002141";
        B <= x"00000F0D05601021";

        wait for CLOCK_PERIOD;
    end process;

end architecture Behavior;