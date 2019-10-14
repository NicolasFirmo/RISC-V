--* @author Cefas Rodrigues Freire <cefas@ufrn.edu.br>
--* @author José Arilton Pereira Filho <arilton@ufrn.edu.br>
--* @date $Date$
--* @id $Id$
--* @version $Rev$
--*
--* This entity represents the division and remainder calculation of two 64 bits inputs.
--*
--* To do so, is used a modified version of Non-Restoring Division Algorithm to uperate
--* with both signed and unsigned inputs.
--*
--* References:
--*
--* - https://people.cs.pitt.edu/~cho/cs0447/currentsemester/handouts/lect-ch3p2_4up.pdf
--*
--* - https://www.youtube.com/watch?v=f6A3ySUdT80

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv.all;

entity Div is port(

    --* Dividend
    X : in std_logic_vector(63 downto 0);
    --* Divisor
    Y : in std_logic_vector(63 downto 0);
    --* Quotient
	Q : out std_logic_vector(63 downto 0);
    --* Remainder
    R : out std_logic_vector(63 downto 0);

    -- Signed(1) / Unsigned(0) division
    s : in std_logic := '1'
);
end Div;

--* @brief Implements the modified Non-Restoring Division Algorithm
architecture Behavioral of Div is

    constant MINUS_ONE          : std_logic_vector := x"FFFFFFFFFFFFFFFF";
    constant SMALLEST_INTEGER   : std_logic_vector := x"8000000000000000";
    constant ZERO               : std_logic_vector := x"0000000000000000";

    -- Definition of utility arrays
    type ArrayOfA is array (64 downto 0) of std_logic_vector(64 downto 0);
    type ArrayOfM is array (64 downto 0) of std_logic_vector(63 downto 0);

    -- A_aux and A arrays (that store the remainder value throughout iteriation process)
    signal A_aux, A     : ArrayOfA := (others => (others => '0'));

    -- M array (that stores the quotient value throughout iteriation process)
    signal M            : ArrayOfM := (others => (others => '0'));

    -- Absolute value of remainder rerulted after Non-Restoring Division Algorithm
    signal R_abs        : std_logic_vector(63 downto 0) := (others => '0');

    -- Absolute values of X and Y
    signal X_abs, Y_abs : std_logic_vector(63 downto 0) := (others => '0');

begin
    
    -- Since the Non-Restoring Division Algorithm is defined only with unsigned values,
    -- we first peform the absolute value of operands in case of signed division
    X_abs <= absolute(X) when s = '1' else X;
    Y_abs <= absolute(Y) when s = '1' else Y;

    -- The first M is equal to dividend
    M(0) <= X_abs;

    -- Generator of Non-Restoring Division Algorithm
    NRDAGenerator: for i in 1 to 64 generate

        -- The current M is equal to previous left shifted
        M(i)(63 downto 1) <= M(i - 1)(62 downto 0);
        -- The LSB of M is the NOT of current A sign 
        M(i)(0) <= sign(A(i)) xor '1';

        -- Left shit the previous A
        A_aux(i)(64 downto 1) <= A(i - 1)(63 downto 0);
        -- The LSB of A_aux is MSB of previous M
        A_aux(i)(0) <= sign(M(i - 1));

        -- A = A_aux + Y_abs, if the sign of the previuos A is 1, otherwise A = A_aux - Y_abs
        A(i) <= A_aux(i) - Y_abs when sign(A(i - 1)) = '0' else A_aux(i) + Y_abs;
    
    end generate NRDAGenerator;

    -- If sign of last A is negative, the remainder is equal A + Y_abs
    R_abs <= A(64)(63 downto 0) when sign(A(64)) = '0' else A(64)(63 downto 0) + Y_abs;

    -- Ensure RISC-V division exception convention and place the complement of M in Q if necessary
    Q <= ( M(64) xor ( Q'range => ((sign(X) xor sign(Y)) and s) ) ) + ((sign(X) xor sign(Y)) and s)
        when Y /= ZERO and (X /= SMALLEST_INTEGER or Y /= MINUS_ONE or s = '0') 
        else MINUS_ONE;

    -- Place the complement of R_abs in R (if the dividend is negative) or R_abs (if divident is positive) and
    -- ensure RISC-V division exception convention
    R <= (R_abs xor (R'range => (sign(X) and s))) + (sign(X) and s)
        when ( X /= SMALLEST_INTEGER or Y /= MINUS_ONE or s = '0') 
        else ZERO;
end Behavioral;