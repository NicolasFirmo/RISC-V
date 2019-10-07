package RISCV is 

    -- OP codes
    constant OP_IMM 	: bit_vector := "0010011";
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
    constant F3_ADDI, F3_ADD, F3_SUB, F3_ZERO, F3_BEQ, F3_FENCE 	: bit_vector := "000";
    constant F3_SLII, F3_SLL, F3_BNE, F3_FENCEI, F3_CSRRW			: bit_vector := "001";
    constant F3_SLTI, F3_SLT, F3_CSRRS								: bit_vector := "010";
    constant F3_SLTU, F3_CSRRC										: bit_vector := "011";
    constant F3_XORI, F3_XOR, F3_BLT								: bit_vector := "100";
    constant F3_SRLI, F3_SRAI, F3_SRL, F3_SRA, F3_BGE, F3_CSRRWI	: bit_vector := "101";
    constant F3_ORI, F3_OR, F3_CSRRSI								: bit_vector := "110";
    constant F3_ANDI, F3_AND, F3_CSRRCI								: bit_vector := "111";

    -- Func7 codes
    constant F7_SLLI, F7_SRLI, F7_ADD, F7_SLL, F7_SLT, 
            F7_SLTU, F7_XOR, F7_SRL, F7_OR, F7_AND		: bit_vector := "0000000";
    constant F7_SRAI, F7_SUB, F7_SRA					: bit_vector := "0100000";

end package RISCV;

package body RISCV is

end package body RISCV;