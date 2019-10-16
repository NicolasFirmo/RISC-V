library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Declaração de constantes

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

entity ula is port (
	opcode: in std_logic_vector(4 downto 0);
	a, b: in std_logic_vector(63 downto 0);
	c: out std_logic_vector(63 downto 0)
);
end ula;

architecture ckt of ula is 

component Shift64L64 is port(
	en: 			in std_logic_vector(5 downto 0);
	entrada:		in std_logic_vector(63 downto 0);
	saida: 			out std_logic_vector(63 downto 0)
);
end component;
component Shift64R64 is port(
	en: 			in std_logic_vector(5 downto 0);
	entrada:		in std_logic_vector(63 downto 0);
	saida: 			out std_logic_vector(63 downto 0)
);
end component;

signal s_a, s_b, s_c: signed(63 downto 0);
signal sll64_out, srl64_out: std_logic_vector(63 downto 0);
signal sll32_out, srl32_out: std_logic_vector(63 downto 0);

signal select_shift_32: std_logic_vector(5 downto 0):= (others => '0');

begin
	s_a <= signed(a);
	s_b <= signed(b);
	
	sll64: Shift64L64 port map (b(5 downto 0), a, sll64_out);
	srl64: Shift64R64 port map (b(5 downto 0), a, srl64_out);
	
	select_shift_32(4 downto 0) <= b(4 downto 0);
	
	sll32: Shift64L64 port map (select_shift_32, a, sll32_out);
	srl32: Shift64R64 port map (select_shift_32, a, srl32_out);
	
	s_c <= s_a + s_b when opcode = "00000" else 
	       s_a - s_b when opcode = "01000" else 
	       signed(sll64_out) when opcode = "10001" else 
	       signed(srl64_out) when opcode = "10101" else 
	       signed(sll32_out) when opcode = "10001" else 
	       signed(srl32_out) when opcode = "10101" else 
	       s_a - s_b when opcode = "1000" else 
	       s_a - s_b when opcode = "1000" else 
	       s_a - s_b when opcode = "1000" else 
	       s_a - s_b when opcode = "1000" else 
	       s_a - s_b when opcode = "1000" else 
	       s_a - s_b when opcode = "1000";
		
end ckt;