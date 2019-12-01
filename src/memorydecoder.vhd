library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv.all;

entity MemoryDecoder is port (
	inst		: in  std_logic_vector(31 downto 0);
	frmt        : out std_logic_vector(2 downto 0);
    wren        : out std_logic
);
end MemoryDecoder;

architecture Behavioral of MemoryDecoder is 

    alias func3     : std_logic_vector(2 downto 0) is inst(14 downto 12);
    alias func7     : std_logic_vector(6 downto 0) is inst(31 downto 25);
    alias opcode    : std_logic_vector(6 downto 0) is inst(6 downto 0);

begin
	
    process (inst)

    begin

        if (opcode = LOAD) then
            frmt <= func3;
            wren <= '0';
        elsif (OPCODE = STORE) then
            frmt <= func3;
            wren <= '1';
        else
            wren <= '0';
        end if;

    end process;

end Behavioral;