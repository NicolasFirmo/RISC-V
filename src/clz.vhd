library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CLZ is port(
    s : in std_logic_vector(63 downto 0);
	q : out std_logic_vector(6 downto 0)
);
end CLZ;

-- Referência: https://electronics.stackexchange.com/questions/196914/verilog-synthesize-high-speed-leading-zero-count
architecture Behavioral of CLZ is

    signal encoding   : std_logic_vector(63 downto 0) := (others => '0');
    signal assemble_0 : std_logic_vector(47 downto 0) := (others => '0');
    signal assemble_1 : std_logic_vector(31 downto 0) := (others => '0');
    signal assemble_2 : std_logic_vector(19 downto 0) := (others => '0');
    signal assemble_3 : std_logic_vector(11 downto 0) := (others => '0');

begin
    
    gen_encoding : for i in 0 to 31 generate
        encoding(2 * i + 1 downto 2 * i) <= "10" when s(2 * i + 1 downto 2 * i) = "00" else
                                            "01" when s(2 * i + 1 downto 2 * i) = "01" else "00";
    end generate gen_encoding;

    gen_assemble_0 : for i in 0 to 15 generate
        assemble_0(3 * i + 2 downto 3 * i) <= "100" when encoding(4 * i + 3) = '1' and encoding(4 * i + 1) = '1' else
                                              "01" & encoding(4 * i) when encoding(4 * i + 3) = '1' else 
                                              "0" & encoding(4 * i + 3 downto 4 * i + 2);
    end generate gen_assemble_0;

    gen_assemble_1 : for i in 0 to 7 generate
        assemble_1(4 * i + 3 downto 4 * i) <= "1000" when assemble_0(6 * i + 5) = '1' and assemble_0(6 * i + 2) = '1' else
                                              "01" & assemble_0(6 * i + 1 downto 6 * i) when assemble_0(6 * i + 5) = '1' else 
                                              "0" & assemble_0(6 * i + 5 downto 6 * i + 3);
    end generate gen_assemble_1;

    gen_assemble_2 : for i in 0 to 3 generate
        assemble_2(5 * i + 4 downto 5 * i) <= "10000" when assemble_1(8 * i + 7) = '1' and assemble_1(8 * i + 3) = '1' else
                                              "01" & assemble_1(8 * i + 2 downto 8 * i) when assemble_1(8 * i + 7) = '1' else 
                                              "0" & assemble_1(8 * i + 7 downto 8 * i + 4);
    end generate gen_assemble_2;

    gen_assemble_3 : for i in 0 to 1 generate
        assemble_3(6 * i + 5 downto 6 * i) <= "100000" when assemble_2(10 * i + 9) = '1' and assemble_2(10 * i + 4) = '1' else
                                              "01" & assemble_2(10 * i + 3 downto 10 * i) when assemble_2(10 * i + 9) = '1' else 
                                              "0" & assemble_2(10 * i + 9 downto 10 * i + 5);
    end generate gen_assemble_3;

    q(6 downto 0) <= "1000000" when assemble_3(11) = '1' and assemble_3(5) = '1' else
                                              "01" & assemble_3(4 downto 0) when assemble_3(11) = '1' else 
                                              "0" & assemble_3(11 downto 6);

end Behavioral;