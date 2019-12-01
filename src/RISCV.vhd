library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package RISCV is 

    constant PROGRAM_MEMNORY_ADDR_SIZE : integer := 11;

    -- Array type definitions
    type ArrayOfAddress is array (7 downto 0) of std_logic_vector(PROGRAM_MEMNORY_ADDR_SIZE downto 0);
    type ArrayOfData is array (7 downto 0) of std_logic_vector(7 downto 0);

    -- OP codes
    constant OP_IMM 	: std_logic_vector := "0010011";
    constant OP_IMM_32  : std_logic_vector := "0011011";
    constant LUI		: std_logic_vector := "0110111";
    constant AUIPC		: std_logic_vector := "0010111";
    constant OP			: std_logic_vector := "0110011";
    constant OP_32      : std_logic_vector := "0111011";
    constant JAL		: std_logic_vector := "1101111";
    constant JALR		: std_logic_vector := "1100111";
    constant BRANCH 	: std_logic_vector := "1100011";
    constant LOAD		: std_logic_vector := "0000011";
    constant STORE		: std_logic_vector := "0100011";
    constant MISC_MEM	: std_logic_vector := "0001111";
    constant SYSTEM		: std_logic_vector := "1110011";

    -- Func3 codes
    constant F3_ADDI, F3_ADD, F3_SUB, F3_ZERO, F3_BEQ, F3_FENCE, 
             F3_ADDIW, F3_SUBW 	                                            : std_logic_vector := "000";
    constant F3_SLLI, F3_SLL, F3_BNE, F3_FENCEI, F3_CSRRW, F3_SLLIW, 
             F3_SLLW			                                            : std_logic_vector := "001";
    constant F3_SLTI, F3_SLT, F3_CSRRS								        : std_logic_vector := "010";
    constant F3_SLTU, F3_CSRRC										        : std_logic_vector := "011";
    constant F3_XORI, F3_XOR, F3_BLT								        : std_logic_vector := "100";
    constant F3_SRLI, F3_SRAI, F3_SRL, F3_SRA, F3_BGE, F3_CSRRWI, 
             F3_SRLIW, F3_SRAIW, F3_SRLW, F3_SRAW                           : std_logic_vector := "101";
    constant F3_ORI, F3_OR, F3_CSRRSI								        : std_logic_vector := "110";
    constant F3_ANDI, F3_AND, F3_CSRRCI								        : std_logic_vector := "111";

    -- Func7 codes
    constant F7_SLLI, F7_SRLI, F7_ADD, F7_SLL, F7_SLT, 
             F7_SLTU, F7_XOR, F7_SRL, F7_OR, F7_AND, 
             F7_ADDIW, F7_SRLW, F7_SLLW, F7_SLLIW, F7_SRLIW	        : std_logic_vector := "0000000";
    constant F7_SRAI, F7_SUB, F7_SRA, F7_SRAW, F7_SUBW, F7_SRAIW    : std_logic_vector := "0100000";

    -- ALU Functions
    constant ALU_ADD	: std_logic_vector := "0000";
    constant ALU_SLT	: std_logic_vector := "0001";
    constant ALU_SLTU	: std_logic_vector := "0010";
    constant ALU_XOR	: std_logic_vector := "0011";
    constant ALU_OR	    : std_logic_vector := "0100";
    constant ALU_AND	: std_logic_vector := "0101";
    constant ALU_SLL	: std_logic_vector := "0110";
    constant ALU_SRL	: std_logic_vector := "0111";
    constant ALU_SRA	: std_logic_vector := "1000";
    constant ALU_SUB	: std_logic_vector := "1001";
    constant ALU_SLLW	: std_logic_vector := "1010";
    constant ALU_SRLW	: std_logic_vector := "1011";
    constant ALU_SRAW	: std_logic_vector := "1100";
    constant ALU_ADDW   : std_logic_vector := "1101";
    constant ALU_SUBW   : std_logic_vector := "1110";

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

    function "rol" (X: std_logic_vector; Y: std_logic_vector) return std_logic_vector;

    function "ror" (X: std_logic_vector; Y: std_logic_vector) return std_logic_vector;

end package RISCV;

package body RISCV is

    function "rol" (X: std_logic_vector; Y: std_logic_vector) return std_logic_vector is 

    begin
        return X rol to_integer(Y);
    end "rol";

    function "ror" (X: std_logic_vector; Y: std_logic_vector) return std_logic_vector is 

    begin
        return X ror to_integer(Y);
    end "ror";

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