library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Demux32TB is
end Demux32TB;
 
architecture Behavior OF Demux32TB IS 
 
    -- Component Declaration
 
    component Demux32 is port (
        addr    : in std_logic_vector(4 downto 0);
        en      : in std_logic;
        q       : out std_logic_vector(31 downto 0)
    );
    end component;

    --Inputs
    signal address   : std_logic_vector(4 downto 0) := (others => '0');
    signal en        : std_logic := '0';

    --Outputs
    signal q : std_logic_vector(31 downto 0);

    -- Clock period definitions
    constant CLOCK_PERIOD : time := 10 ns;
 
begin
    -- Instantiate the single-port RAM in VHDL
    uut: Demux32 port map (address, en, q);

    stim_proc: process
    begin
        address <= (others => '0');
        en <= '0';

        wait for CLOCK_PERIOD;
        
        for i in 0 to 30 loop
            address <= address + 1;
            wait for CLOCK_PERIOD;
        end loop;

        address <= (others => '0');
        en <= '1';
        
        wait for CLOCK_PERIOD;
        
        for i in 0 to 30 loop
            address <= address + 1;
            wait for CLOCK_PERIOD;
        end loop;
    end process;

end architecture Behavior;