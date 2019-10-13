library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Referências 
-- https://people.cs.pitt.edu/~cho/cs0447/currentsemester/handouts/lect-ch3p2_4up.pdf
-- https://www.youtube.com/watch?v=f6A3ySUdT80
entity Div is port(
    A, B		: in std_logic_vector(63 downto 0);
	C, D        : out std_logic_vector(63 downto 0);

    -- Indica se a divisão é unsigned (0) ou signed (1)
    s           : in std_logic := '1'
);
end Div;

architecture Behavioral of Div is

    type r_array is array (64 downto 0) of std_logic_vector(64 downto 0);
    type q_array is array (64 downto 0) of std_logic_vector(63 downto 0);

    signal r_a, r                  : r_array := (others => (others => '0'));
    signal q                       : q_array := (others => (others => '0'));
    signal A_abs, B_abs, 
           inv_a, inv_b, 
           aux_s_a, aux_s_b, D_abs : std_logic_vector(63 downto 0) := (others => '0');

begin

    inv_a <= (others => A(63) and s);
    inv_b <= (others => B(63) and s);
    
    aux_s_a(0) <= A(63) and s;
    aux_s_b(0) <= B(63) and s;

    A_abs <= std_logic_vector(unsigned(A xor inv_a) + unsigned(aux_s_a));
    B_abs <= std_logic_vector(unsigned(B xor inv_b) + unsigned(aux_s_b));

    q(0) <= A_abs;

    div_gen: for i in 1 to 64 generate
        q(i)(63 downto 1) <= q(i - 1)(62 downto 0);
        q(i)(0) <= r(i)(64) xor '1';

        r_a(i)(64 downto 1) <= r(i - 1)(63 downto 0);
        r_a(i)(0) <= q(i - 1)(63);

        r(i) <= std_logic_vector(unsigned(r_a(i)) - unsigned(B)) when r(i - 1)(64) = '0' else
                std_logic_vector(unsigned(r_a(i)) + unsigned(B));
    end generate div_gen;

    C <= std_logic_vector(
        unsigned(q(64) xor inv_a xor inv_b) + 
        unsigned(aux_s_a xor aux_s_b)
    ) when unsigned(B) /= 0 and (A /= x"8000000000000000" or B /= x"FFFFFFFFFFFFFFFF" or s = '0') 
    else (63 downto 0 => '1');

    D_abs <= r(64)(63 downto 0) when r(64)(64) = '0' else
             std_logic_vector(unsigned(r(64)(63 downto 0)) + unsigned(B));
    D <= std_logic_vector(
        unsigned(D_abs xor inv_a) + unsigned(aux_s_a)
    ) when A /= x"8000000000000000" or B /= x"FFFFFFFFFFFFFFFF" or s = '0' else (63 downto 0 => '0');
end Behavioral;