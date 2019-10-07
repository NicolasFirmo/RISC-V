library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity RegFile64TB is
end RegFile64TB;
 
architecture Behavior of RegFile64TB is
 
    -- Component Declaration
 
    component RegFile64 is port (
        -- Clock e sinal de load
        clk, ld			: in std_logic;
        -- Endereços dos registradores
        addr0, addr1 	: in std_logic_vector(4 downto 0);
        -- Dados de entrada do registro referenciado por addr0
        d 				: in std_logic_vector(63 downto 0);
        -- Saídas dos registradores referenciados por addr0 e addr1
        q0, q1 			: out std_logic_vector(63 downto 0)
    );
    end component;

    --Inputs
    signal ld, clk      : std_logic := '0';
    signal addr0, addr1 : std_logic_vector(4 downto 0) := (others => '0');
    signal d            : std_logic_vector(63 downto 0) := (others => '0');

    --Outputs
    signal q0, q1 : std_logic_vector(63 downto 0);

    -- Clock period definitions
    constant CLOCK_PERIOD : time := 10 ns;
 
begin
    uut: RegFile64 port map (clk, ld, addr0, addr1, d, q0, q1);

    -- Clock process definitions
    clock_process : process
    begin
        clk <= '0';
        wait for CLOCK_PERIOD / 2;
        clk <= '1';
        wait for CLOCK_PERIOD / 2;
    end process;

    stim_proc: process
    begin
        addr0   <= "00001";
        addr1   <= "00001";
        ld      <= '1';
        d       <= x"000000000000000A";

        wait for CLOCK_PERIOD;
        assert q0 = 10;
        assert q1 = 10;

        addr0   <= "00010";
        addr1   <= "00010";
        d       <= x"000000000000000F";

        wait for CLOCK_PERIOD;
        assert q0 = 15;
        assert q1 = 15;
    end process;

end architecture Behavior;