library ieee ;
use ieee.std_logic_1164.all;
use work.riscv.all;

entity MemoryController is port (
	clk, wren 	: in std_logic;
	frmt		: in std_logic_vector(2 downto 0);
	address		: in std_logic_vector(63 downto 0);
	data		: in std_logic_vector(63 downto 0);
	block_addr  : out ArrayOfAddress;
    block_data  : in ArrayOfData;
    block_wren  : out std_logic_vector(7 downto 0);
    q           : out std_logic_vector
);
end MemoryController;

architecture Behavioral of MemoryController is

-- Sinal auxiliar para os dados que serão escritos na memória
signal data_aux 		: std_logic_vector(63 downto 0) := (others => '0');
-- Sinais auxiliar para os dados lidos da memória
signal q_aux_0, q_aux_1 : std_logic_vector(63 downto 0) := (others => '0');
-- Sinal auxiliar para montar adequadamente os enable
signal aux				: std_logic_vector(7 downto 0); 

signal addr_aux		    : std_logic_vector(15 downto 0);

signal q_aux : std_logic_vector(63 downto 0);

begin

    data_aux <= data rol address(2 downto 0);

    -- Palavra de enable a ser deslocada
    aux <= 	"00000001" when (frmt(1 downto 0) = "00") else 
            "00000011" when (frmt(1 downto 0) = "01") else
            "00001111" when (frmt(1 downto 0) = "10") else
            "11111111";

    addr_aux <= ("00000000" & aux) rol address(2 downto 0);
    block_wren <= (aux rol address(2 downto 0)) * wren;
    q_aux_1 <= q_aux_0 ror address(2 downto 0);

    AddressGenerator : for i in 0 to 7 generate
        block_addr(i) <= ("000" & address(block_addr(i)'length - 1 downto 3)) + addr_aux(i + 7);
    end generate AddressGenerator;

    MemoryDataGenerator : for i in 0 to 7 generate
        q_aux_0((8 * i + 7) downto (8 * i)) <= block_data(i);
    end generate MemoryDataGenerator;

    -- Lidando corretamente com a extensão de sinal
    q(7 downto 0) <= q_aux_1(7 downto 0);
    q(15 downto 8) <= (15 downto 8 => '0') 			when (frmt = "000") else
                    (15 downto 8 => q_aux_1(7)) 	when (frmt = "100") else
                    q_aux_1(15 downto 8);
    q(31 downto 16) <= (31 downto 16 => '0') 		when (frmt = "000" or 
                                                        frmt = "001") else
                    (31 downto 16 => q_aux_1(7)) 	when (frmt = "100") else
                    (31 downto 16 => q_aux_1(15)) when (frmt = "101") else
                    q_aux_1(31 downto 16);
    q(63 downto 32) <= (63 downto 32 => '0') 		when (frmt = "000" or 
                                                        frmt = "001" or 
                                                        frmt = "010") else
                    (63 downto 32 => q_aux_1(7)) 	when (frmt = "100") else
                    (63 downto 32 => q_aux_1(15)) when (frmt = "101") else
                    (63 downto 32 => q_aux_1(31)) when (frmt = "110") else
                    q_aux_1(63 downto 32);
end Behavioral;