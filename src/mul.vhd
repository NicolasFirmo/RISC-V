--* @author Cefas Rodrigues Freire <cefas@ufrn.edu.br>
--* @author José Arilton Pereira Filho <arilton@ufrn.edu.br>
--* @date $Date$
--* @id $Id$
--* @version $Rev$
--*
--* This entity represents the multiplication of two 64 bits inputs.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv.all;

entity Mul is port(

    --* First operand
    X           : in std_logic_vector(63 downto 0);

    --* Second operand
    Y           : in std_logic_vector(63 downto 0);

    --* 64 lower bits of multiplication result
	Z0          : out std_logic_vector(63 downto 0);

    --* 64 upper bits of multiplication result
    Z1          : out std_logic_vector(63 downto 0);

    --* If the first input (X) is signed (1) or unsigned (0)
    sX          : in std_logic := '1';

    --* If the second input (Y) s signed (1) or unsigned (0)
    sY          : in std_logic := '1'
);
end Mul;

architecture Behavioral of Mul is

    -- Definition of utility arrays
    type ArrayOfMul is array (63 downto 0) of std_logic_vector(126 downto 0);
    type ArrayOfSum is array (63 downto 0) of std_logic_vector(127 downto 0);

    signal X_abs, aux: std_logic_vector(63 downto 0) := (others => '0');
    
    -- Bitwise multiplication array (that stores the multiplication of A for B(i))
    signal mul          : ArrayOfMul := (others => (others => '0'));

    -- Summation array (that stores the summation of bitwise multiplication results 
    -- throughout iteriation process)
    signal summation    : ArrayOfSum := (others => (others => '0'));

Begin
    aux(0) <= sign(Y) and sY;

    X_abs <= absolute(X) when sX = '1' else X;

    MulGenerator: for i in 0 to 63 generate
        -- Perform bitwise multiplication and store result
        mul(i)((63 + i) downto i) <= X_abs * Y(i);
    end generate MulGenerator;

    summation(0) <= '0' & mul(0);

    SumGenerator: for i in 1 to 63 generate
        -- Perform summation of the mul array
        summation(i) <= ('0' & mul(i)) + summation(i - 1);
    end generate SumGenerator;

    Z0 <= (summation(63)(63 downto 0) xor (63 downto 0 => (sign(X) and sX))) + (sign(X) and sX);

    Z1 <= summation(63)(127 downto 64) xor (63 downto 0 => ((sign(X) and sX) xor (sign(Y) and sY))) xor aux;
end Behavioral;