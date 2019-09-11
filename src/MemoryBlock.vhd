library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MemoryBlock is port(
    address		: in std_logic_vector;
	clock		: in std_logic  := '1';
	data		: in std_logic_vector;
	wren		: in std_logic ;
	q           : out std_logic_vector
);
end MemoryBlock;

architecture Behavioral of MemoryBlock is
    -- define the new type for the NxM RAM 
    type ram_array is array (0 to (2**address'length)-1) of std_logic_vector (q'range);
    -- initial values in the RAM
    signal ram: ram_array;

begin
    process(clock)
    begin
        if (rising_edge(clock) and wren='1') then
            -- write input data into RAM at the provided address
            ram(to_integer(unsigned(address))) <= data;
        end if;
    end process;
    
    -- Data to be read out 
    q <= ram(to_integer(unsigned(address)));
end Behavioral;