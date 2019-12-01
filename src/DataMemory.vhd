library ieee ;
use ieee.std_logic_1164.all;
use work.riscv.all;

entity DataMemory is port (
	clk, wren 	: in std_logic;
	frmt		: in std_logic_vector(2 downto 0);
	address		: in std_logic_vector(63 downto 0);
	data		: in std_logic_vector(63 downto 0);
	q			: out std_logic_vector
);
end DataMemory;

architecture Behavioral of DataMemory is

    component MemoryBlock is
        port
        (
            address		: in std_logic_vector (PROGRAM_DATA_ADDR_SIZE downto 0);
            clock		: in std_logic := '1';
            data		: in std_logic_vector (7 downto 0);
            wren		: in std_logic;
            q			: out std_logic_vector (7 downto 0)
        );
    end component;

    component MemoryController is port (
        clk, wren 	: in std_logic;
        frmt		: in std_logic_vector(2 downto 0);
        address		: in std_logic_vector(63 downto 0);
        data		: in std_logic_vector(63 downto 0);
        block_addr  : out ArrayOfAddress;
        block_data  : in ArrayOfData;
        block_wren  : out std_logic_vector(7 downto 0);
        q           : out std_logic_vector(63 downto 0)
    );
    end component;

    signal block_data : ArrayOfData;
    signal block_addr : ArrayOfAddress;
    signal block_wren : std_logic_vector(7 downto 0);
begin

    mc : MemoryController port map(
        clk, wren, frmt, address, data, block_addr, block_data, block_wren, q
    );
	
    MemoryBlockGenerator : for i in 0 to 7 generate
        b : MemoryBlock port map(
            address => block_addr(i),
            clock 	=> clk,
            data 	=> data((8 * i + 7) downto (8 * i)),
            wren 	=> block_wren(i),
            q 		=> block_data(i)
        );
    end generate MemoryBlockGenerator;

end Behavioral;