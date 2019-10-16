library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity DatapathTB is
end DatapathTB;
 
architecture Behavior OF DatapathTB IS 
 
    -- Component Declaration
 
    component Datapath is port(
        clk : std_logic
    );
    end component;

    -- Clock period definitions
    constant CLOCK_PERIOD : time := 10 ns;

    signal clk : std_logic := '0';
 
begin
    
    dp : Datapath port map(clk);

    clk_process: process

    begin

        wait for CLOCK_PERIOD / 2;
        clk <= not clk;
    
    end process;

end architecture Behavior;