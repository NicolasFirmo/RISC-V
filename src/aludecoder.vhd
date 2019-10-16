library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv.all;

entity AluDecoder is port (
	inst		: in  std_logic_vector(31 downto 0);
	alu_fun     : out std_logic_vector(3 downto 0)
);
end AluDecoder;

architecture Behavioral of AluDecoder is 

    alias func3     : std_logic_vector(2 downto 0) is inst(14 downto 12);
    alias func7     : std_logic_vector(6 downto 0) is inst(31 downto 25);
    alias opcode    : std_logic_vector(6 downto 0) is inst(6 downto 0);

begin
	
    process (inst)

    begin

        if (opcode = OP_IMM and func3 = F3_SLLI and func7 = F7_SLLI) then
            alu_fun <= ALU_SLL;
        elsif (opcode = OP_IMM and func3 = F3_SRLI and func7 = F7_SRLI) then
            alu_fun <= ALU_SRL;
        elsif (opcode = OP_IMM and func3 = F3_SRAI and func7 = F7_SRAI) then
            alu_fun <= ALU_SRA;
        elsif (opcode = OP and func3 = F3_ADD and func7 = F7_ADD) then
            alu_fun <= ALU_ADD;
        elsif (opcode = OP and func3 = F3_SLT and func7 = F7_SLT) then
            alu_fun <= ALU_SLT;
        elsif (opcode = OP and func3 = F3_SLTU and func7 = F7_SLTU) then
            alu_fun <= ALU_SLTU;
        elsif (opcode = OP and func3 = F3_AND and func7 = F7_AND) then
            alu_fun <= ALU_AND;
        elsif (opcode = OP and func3 = F3_OR and func7 = F7_OR) then
            alu_fun <= ALU_OR;
        elsif (opcode = OP and func3 = F3_XOR and func7 = F7_XOR) then
            alu_fun <= ALU_XOR;
        elsif (opcode = OP and func3 = F3_SLL and func7 = F7_SLL) then
            alu_fun <= ALU_SLL;
        elsif (opcode = OP and func3 = F3_SRL and func7 = F7_SRL) then
            alu_fun <= ALU_SRL;
        elsif (opcode = OP and func3 = F3_SUB and func7 = F7_SUB) then
            alu_fun <= ALU_SUB;
        elsif (opcode = OP and func3 = F3_SRA and func7 = F7_SRA) then
            alu_fun <= ALU_SRA;
        elsif (opcode = OP_IMM_32 and func3 = F3_ADDIW) then
            alu_fun <= ALU_ADDW;
        elsif (opcode = OP_IMM_32 and func3 = F3_SLLIW and func7 = F7_SLLIW) then
            alu_fun <= ALU_SLLW;
        elsif (opcode = OP_IMM_32 and func3 = F3_SRLIW and func7 = F7_SRLIW) then
            alu_fun <= ALU_SRLW;
        elsif (opcode = OP_IMM_32 and func3 = F3_SRAIW and func7 = F7_SRAIW) then
            alu_fun <= ALU_SRAW;
        elsif (opcode = OP_32 and func3 = F3_SLLW and func7 = F7_SLLW) then
            alu_fun <= ALU_SLLW;
        elsif (opcode = OP_32 and func3 = F3_SRLW and func7 = F7_SRLW) then
            alu_fun <= ALU_SRLW;
        elsif (opcode = OP_32 and func3 = F3_SUBW and func7 = F7_SUBW) then
            alu_fun <= ALU_SUBW;
        elsif (opcode = OP_32 and func3 = F3_SRAW and func7 = F7_SRAW) then
            alu_fun <= ALU_SRAW;
        else -- LUI, AUIPC
            alu_fun <= ALU_ADD;
        end if;

    end process;

end Behavioral;