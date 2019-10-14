library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package RISCV is 

    -- OP codes
    constant OP_IMM 	: bit_vector := "0010011";
    constant OP_IMM_32  : bit_vector := "0011011";
    constant LUI		: bit_vector := "0110111";
    constant AUIPC		: bit_vector := "0010111";
    constant OP			: bit_vector := "0110011";
    constant JAL		: bit_vector := "1101111";
    constant JALR		: bit_vector := "1100111";
    constant BRANCH 	: bit_vector := "1100011";
    constant LOAD		: bit_vector := "0000011";
    constant STORE		: bit_vector := "0100011";
    constant MISC_MEM	: bit_vector := "0001111";
    constant SYSTEM		: bit_vector := "1110011";

    -- Func3 codes
    constant F3_ADDI, F3_ADD, F3_SUB, F3_ZERO, F3_BEQ, F3_FENCE, F3_ADDIW 	            : bit_vector := "000";
    constant F3_SLII, F3_SLL, F3_BNE, F3_FENCEI, F3_CSRRW, F3_SLLIW			            : bit_vector := "001";
    constant F3_SLTI, F3_SLT, F3_CSRRS								                    : bit_vector := "010";
    constant F3_SLTU, F3_CSRRC										                    : bit_vector := "011";
    constant F3_XORI, F3_XOR, F3_BLT								                    : bit_vector := "100";
    constant F3_SRLI, F3_SRAI, F3_SRL, F3_SRA, F3_BGE, F3_CSRRWI, F3_SRLIW, F3_SRAIW    : bit_vector := "101";
    constant F3_ORI, F3_OR, F3_CSRRSI								                    : bit_vector := "110";
    constant F3_ANDI, F3_AND, F3_CSRRCI								                    : bit_vector := "111";

    -- Func7 codes
    constant F7_SLLI, F7_SRLI, F7_ADD, F7_SLL, F7_SLT, 
             F7_SLTU, F7_XOR, F7_SRL, F7_OR, F7_AND, F7_ADDIW	: bit_vector := "0000000";
    constant F7_SRAI, F7_SUB, F7_SRA, F7_SRAW					: bit_vector := "0100000";

    -- Function declarations

    --* @brief Computes the absolute value of X
    --* @param X signal
    --* @return The binary absolute representation of X 
    function absolute (X: std_logic_vector) return std_logic_vector;

    --* @brief Returns the sign of X
    --* @param X signal
    --* @return A std_logic with the sign ('1' for positive, '0' for negative) of X
    function sign(X: std_logic_vector) return std_logic;

    --* @brief Returns the complement of X
    --* @param X signal
    --* @return Complement of X
    function complement(X: std_logic_vector) return std_logic_vector;

    --* @brief Overload + operator to std_logic_vector
    --* @param X std_logic_vector signal
    --* @param Y std_logic_vector signal
    --* @return Adition of X with Y
    function "+" (X, Y: std_logic_vector) return std_logic_vector;

    function "+" (X: std_logic_vector; Y: std_logic) return std_logic_vector;
    function "+" (X: std_logic; Y: std_logic_vector) return std_logic_vector;

    --* @brief Overload - operator to std_logic_vector
    --* @param X std_logic_vector signal
    --* @param Y std_logic_vector signal
    --* @return Subtraction of X with Y
    function "-" (X, Y: std_logic_vector) return std_logic_vector;

    function "*" (X: std_logic_vector; Y: std_logic) return std_logic_vector;

end package RISCV;

package body RISCV is

    function "*" (X: std_logic_vector; Y: std_logic) return std_logic_vector is

    begin
        return X and (X'range => Y);
    end "*";

    function "+" (X, Y: std_logic_vector) return std_logic_vector is
    
    begin
        return std_logic_vector(unsigned(X) + unsigned(Y));
    end "+";

    function "+" (X: std_logic_vector; Y: std_logic) return std_logic_vector is
    
    begin
        return std_logic_vector(unsigned(X) + (0 downto 0 => Y));
    end "+";

    function "+" (X: std_logic; Y: std_logic_vector) return std_logic_vector is
    
    begin
        return std_logic_vector(unsigned(Y) + (0 downto 0 => X));
    end "+";

    function "-" (X, Y: std_logic_vector) return std_logic_vector is
    
    begin
        return std_logic_vector(unsigned(X) - unsigned(Y));
    end "-";

    function sign (X: std_logic_vector) return std_logic is

    begin
        -- Get the MSB of X
        return X(X'length - 1);
    end sign;

    function complement (X: std_logic_vector) return std_logic_vector is

    begin
        -- Perform the complement of X
        return std_logic_vector(
            unsigned( X xor (X'range => '1') ) + 
            (0 downto 0 => '1')
        );
    end complement;

    function absolute (X: std_logic_vector) return std_logic_vector is

    begin
        -- Perform the complement of X is it is negative
        if (sign(X) = '1') then
            return complement(X);
        else
            return X;
        end if;
    end absolute;

end package body RISCV;