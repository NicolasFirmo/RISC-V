library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity MemoryTB is
end MemoryTB;
 
architecture Behavior OF MemoryTB IS 
 
    -- Component Declaration for the single-port RAM in VHDL
 
    component Memory port(
        wren, clk 	: in std_logic;
        frmt		: in std_logic_vector(2 downto 0);
        address		: in std_logic_vector(63 downto 0);
        data		: in std_logic_vector(63 downto 0);
        q			: out std_logic_vector(63 downto 0));
    end component;

   --Inputs
   signal address   : std_logic_vector(63 downto 0) := (others => '0');
   signal data      : std_logic_vector(63 downto 0) := (others => '0');
   signal wren      : std_logic := '0';
   signal clock     : std_logic := '0';
   signal frmt      : std_logic_vector(2 downto 0) := (others => '0');

  --Outputs
   signal q : std_logic_vector(63 downto 0);

   -- Clock period definitions
   constant CLOCK_PERIOD : time := 10 ns;
 
begin
    -- Instantiate the single-port RAM in VHDL
    uut: Memory port map (
        wren    => wren,
        clk     => clock,
        frmt    => frmt,
        address => address,
        data    => data,
        q       => q
    );

    -- Clock process definitions
    clock_process :process
    begin
        clock <= '0';
        wait for CLOCK_PERIOD / 2;
        clock <= '1';
        wait for CLOCK_PERIOD / 2;
    end process;

    stim_proc: process
    begin  
        wren <= '0'; 
        address <= (others => '1');
        data <= x"FFFFFFFFFFFFFFFF";
        
        wait for 100 ns; 
        
        -- start reading data from RAM 
        for i in 0 to 5 loop
            address <= address + x"0000000000000001";
            wait for CLOCK_PERIOD * 5;
        end loop;

        address <= (others => '1');
        wren <= '1';
        
        wait for 100 ns; 

        -- start writing to RAM
        for i in 0 to 5 loop
            address <= address + x"0000000000000001";
            data <= data - x"0000000000000001";
            wait for CLOCK_PERIOD * 5;
        end loop;  
        
        wren <= '0';
        wait;
    end process;

end architecture Behavior;