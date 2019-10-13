library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mul is port(
    A, B		: in std_logic_vector(63 downto 0);
	C, D        : out std_logic_vector(63 downto 0);

    -- Se A e B são signed (1) ou unsigned(0)
    sa, sb      : in std_logic := '1'
);
end Mul;

architecture Behavioral of Mul is

    type mul_array is array (63 downto 0) of std_logic_vector(126 downto 0);
    type sum_array is array (63 downto 0) of std_logic_vector(127 downto 0);

    signal A_aux, 
           s_aux_a, inv_aux_a, 
           s_aux_b, inv_aux_b       : std_logic_vector(63 downto 0) := (others => '0');
    signal mul_aux                  : mul_array := (others => (others => '0'));
    signal summation                : sum_array := (others => (others => '0'));

begin
    s_aux_a(0) <= sa and A(63);
    s_aux_b(0) <= sb and B(63);

    inv_aux_a <= (63 downto 0 => (sa and A(63)));
    inv_aux_b <= (63 downto 0 => (sb and B(63)));

    A_aux <= std_logic_vector(
        unsigned(A xor inv_aux_a) + unsigned(s_aux_a)
    );

    gen_mul: for i in 0 to 63 generate
        mul_aux(i)((63 + i) downto i) <= A_aux and ((63 + i) downto i => B(i));
    end generate gen_mul;

    summation(0) <= '0' & mul_aux(0);

    gen_sum: for i in 1 to 63 generate
        summation(i) <= std_logic_vector(unsigned('0' & mul_aux(i)) + unsigned(summation(i - 1)));
    end generate gen_sum;

    C <= std_logic_vector(
        unsigned(summation(63)(63 downto 0) xor inv_aux_a) + unsigned(s_aux_a)
    );
    D <= summation(63)(127 downto 64) xor inv_aux_a xor inv_aux_b xor s_aux_b;
end Behavioral;