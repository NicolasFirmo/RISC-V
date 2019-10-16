library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv.all;

entity ALU is port (
	alu_fun		: in  std_logic_vector(3 downto 0);
	a, b		: in  std_logic_vector(63 downto 0);
	c			: out std_logic_vector(63 downto 0)
);
end ALU;

architecture ckt of ALU is 

component Shift64L64 is port(
	en: 			in  std_logic_vector(5 downto 0);
	entrada:		in  std_logic_vector(63 downto 0);
	saida: 		out std_logic_vector(63 downto 0)
);
end component;

component Shift64R64 is port(
	en: 			in  std_logic_vector(5 downto 0);
	entrada:		in  std_logic_vector(63 downto 0);
	saida: 		out std_logic_vector(63 downto 0)
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
	
	s_c <= s_a  + 	s_b 		 when alu_fun = ALU_ADD 	else 
	       s_a  - 	s_b 		 when alu_fun = ALU_SUB 	else 
	       s_a xor s_b 		 when alu_fun = ALU_XOR 	else 
			 s_a or  s_b 		 when alu_fun = ALU_OR 		else 
			 s_a and s_b 		 when alu_fun = ALU_AND 	else 
	       (others => '1') 	 when s_a < s_b  and 	alu_fun = ALU_SLT  else 
	       (others => '0') 	 when s_a >= s_b and 	alu_fun = ALU_SLT  else 
	       (others => '1') 	 when s_a < s_b  and 	alu_fun = ALU_SLTU else 
	       (others => '0') 	 when s_a >= s_b and 	alu_fun = ALU_SLTU else 
			 s_a sll to_integer(s_b(5 downto 0)) when alu_fun = ALU_SLL  else 
			 s_a sll to_integer(s_b(4 downto 0)) when alu_fun = ALU_SLLW else 
			 s_a srl to_integer(s_b(5 downto 0)) when alu_fun = ALU_SRL  else 
			 s_a srl to_integer(s_b(4 downto 0)) when alu_fun = ALU_SRLW else 
			 signed (to_stdlogicvector(to_bitvector(std_logic_vector(s_a)) sra to_integer(s_b(5 downto 0)))) when alu_fun = ALU_SRA  else 
			 signed (to_stdlogicvector(to_bitvector(std_logic_vector(s_a)) sra to_integer(s_b(4 downto 0)))) when alu_fun = ALU_SRAW else 
			 s_a ;
		
	c <= std_logic_vector(s_c);
end ckt;