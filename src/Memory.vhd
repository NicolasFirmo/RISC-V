library ieee ;
use ieee.std_logic_1164.all;

entity Memory is port (
	wren, clk 	: in std_logic;
	frmt		: in std_logic_vector(2 downto 0);
	address		: in std_logic_vector(63 downto 0);
	data		: in std_logic_vector(63 downto 0);
	q			: out std_logic_vector(63 downto 0)
);
end Memory;

architecture Behavioral of Memory is

component MemoryBlock is
	port
	(
		address		: in std_logic_vector (15 downto 0);
		clock		: in std_logic := '1';
		data		: in std_logic_vector (7 downto 0);
		wren		: in std_logic;
		q			: in std_logic_vector (7 downto 0)
	);
end component;

component Shift8L1 is port(
	en:			in std_logic;
	entrada:	in std_logic_vector(7 downto 0);
	saida: 		out std_logic_vector(7 downto 0)
);
end component;

component Shift8L2 is port(
	en:			in std_logic;
	entrada:	in std_logic_vector(7 downto 0);
	saida: 		out std_logic_vector(7 downto 0)
);
end component;

component Shift8L4 is port(
	en:			in std_logic;
	entrada:	in std_logic_vector(7 downto 0);
	saida: 		out std_logic_vector(7 downto 0)
);
end component;

component Shift64L8 is port(
	en:			in std_logic;
	entrada:	in std_logic_vector(63 downto 0);
	saida: 		out std_logic_vector(63 downto 0)
);
end component;

component Shift64L16 is port(
	en:			in std_logic;
	entrada:	in std_logic_vector(63 downto 0);
	saida: 		out std_logic_vector(63 downto 0)
);
end component;

component Shift64L32 is port(
	en:			in std_logic;
	entrada:	in std_logic_vector(63 downto 0);
	saida: 		out std_logic_vector(63 downto 0)
);
end component;

component Shift64R8 is port(
	en:			in std_logic;
	entrada:	in std_logic_vector(63 downto 0);
	saida: 		out std_logic_vector(63 downto 0)
);
end component;

component Shift64R16 is port(
	en:			in std_logic;
	entrada:	in std_logic_vector(63 downto 0);
	saida: 		out std_logic_vector(63 downto 0)
);
end component;

component Shift64R32 is port(
	en:			in std_logic;
	entrada:	in std_logic_vector(63 downto 0);
	saida: 		out std_logic_vector(63 downto 0)
);
end component;

-- Sinal auxiliar para habilitar a escrita de cada um dos 8 blocos
signal wren_aux_0, wren_aux : std_logic_vector(7 downto 0);
-- Sinal auxiliar para os dados que serão escritos na memória
signal data_aux 		: std_logic_vector(63 downto 0) := (others => '0');
-- Sinais auxiliar para os dados lidos da memória
signal q_aux_0, q_aux_1 : std_logic_vector(63 downto 0) := (others => '0');
-- Sinal auxiliar para montar adequadamente os enable
signal aux				: std_logic_vector(7 downto 0); 

-- Sinais dos blocos de deslocamento de bits
signal s8l1_out, s8l2_out : std_logic_vector(7 downto 0); 
signal s64l8_out, s64l16_out : std_logic_vector(63 downto 0);
signal s64r8_out, s64r16_out : std_logic_vector(63 downto 0);

begin

-- Palavra de enable a ser deslocada
aux <= 	"00000001" when (frmt(1 downto 0) = "00") else 
		"00000011" when (frmt(1 downto 0) = "01") else
		"00001111" when (frmt(1 downto 0) = "10") else
		"11111111";

wren_aux <= wren_aux_0 and (others => wren);

s8l1 : Shift8L1 port map(
	en		=> addr(0),
	entrada => aux,
	saida 	=> s8l1_out
);

s8l2 : Shift8L1 port map(
	en		=> addr(1),
	entrada => s8l1_out,
	saida 	=> s8l2_out
);

s8l4 : Shift8L1 port map(
	en		=> addr(2),
	entrada => s8l2_out,
	saida 	=> wren_aux_0
);

s64l8 : Shift64L8 port map(
	en		=> addr(0),
	entrada => data,
	saida 	=> s64l8_out
);

s64l16 : Shift64L16 port map(
	en		=> addr(1),
	entrada => s64l8_out,
	saida 	=> s64l16_out
);

s64l32 : Shift64L32 port map(
	en		=> addr(2),
	entrada => s64l16_out,
	saida 	=> data_aux
);

s64r8 : Shift64R8 port map(
	en		=> addr(0),
	entrada => q_aux_0,
	saida 	=> s64r8_out
);

s64r16 : Shift64R16 port map(
	en		=> addr(1),
	entrada => s64r8_out,
	saida 	=> s64r16_out
);

s64r32 : Shift64R32 port map(
	en		=> addr(2),
	entrada => s64r16_out,
	saida 	=> q_aux_1
);

b0 : mem_p port map(
	address => addr(18 downto 3),
	clock 	=> clk,
	data 	=> data_aux(7 downto 0),
	wren 	=> wren_aux(0),
	q 		=> q_aux_0(7 downto 0)
);
	
b1 : MemoryBlock port map(
	address => addr(18 downto 3),
	clock 	=> clk,
	data 	=> data_aux(15 downto 8),
	wren 	=> wren_aux(1),
	q 		=> q_aux_0(15 downto 8)
);
	
b2 : MemoryBlock port map(
	address => addr(18 downto 3),
	clock 	=> clk,
	data 	=> data_aux(23 downto 16),
	wren 	=> wren_aux(2),
	q 		=> q_aux_0(23 downto 16)
);
	
b3 : MemoryBlock port map(
	address => addr(18 downto 3),
	clock 	=> clk,
	data 	=> data_aux(31 downto 24),
	wren 	=> wren_aux(1),
	q 		=> q_aux_0(31 downto 24)
);

b4 : MemoryBlock port map(
	address => addr(18 downto 3),
	clock 	=> clk,
	data 	=> data_aux(39 downto 32),
	wren 	=> wren_aux(4),
	q 		=> q_aux_0(39 downto 32)
);

b5 : MemoryBlock port map(
	address => addr(18 downto 3),
	clock 	=> clk,
	data 	=> data_aux(47 downto 40),
	wren 	=> wren_aux(5),
	q 		=> q_aux_0(47 downto 40)
);

b6 : MemoryBlock port map(
	address => addr(18 downto 3),
	clock 	=> clk,
	data 	=> data_aux(55 downto 48),
	wren 	=> wren_aux(6),
	q 		=> q_aux_0(55 downto 48)
);

b7 : MemoryBlock port map(
	address => addr(18 downto 3),
	clock 	=> clk,
	data 	=> data_aux(63 downto 56),
	wren 	=> wren_aux(7),
	q 		=> q_aux_0(63 downto 56)
);

-- Lidando corretamente com a extensão de sinal
q(7 downto 0) <= q_aux_1(7 downto 0);
q(15 downto 8) <= (15 downto 8 => '0') 			when (frmt = "000") else
				 (15 downto 8 => q_aux_1(7)) 	when (frmt = "100") else
				 q_aux_1(15 downto 8);
q(31 downto 16) <= (31 downto 16 => '0') 		when (frmt = "000" or 
													  frmt = "001") else
				  (31 downto 16 => q_aux_1(7)) 	when (frmt = "100") else
				  (31 downto 16 => q_aux_1(15)) when (frmt = "101") else
				  q_aux_1(31 downto 16);
q(63 downto 32) <= (63 downto 32 => '0') 		when (frmt = "000" or 
													  frmt = "001" or 
													  frmt = "010") else
				  (63 downto 32 => q_aux_1(7)) 	when (frmt = "100") else
				  (63 downto 32 => q_aux_1(15)) when (frmt = "101") else
				  (63 downto 32 => q_aux_1(31)) when (frmt = "110") else
				  q_aux_1(63 downto 32);

end Behavioral;