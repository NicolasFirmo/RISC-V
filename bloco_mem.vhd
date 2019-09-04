library ieee ;
use ieee . std_logic_1164 .all;
entity bloco_mem is
port (
		wr, clk : in std_logic;
		frmt: in std_logic_vector(2 downto 0);
		ad, d: in std_logic_vector(63 downto 0);
		q: out std_logic_vector(63 downto 0)
);
end bloco_mem ;

architecture ckt of bloco_mem is

component mem_p IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END component;

signal d0, d1, d2, d3, d4, d5, d6, d7 : std_logic_vector(7 downto 0);
signal q0, q1, q2, q3, q4, q5, q6, q7 : std_logic_vector(7 downto 0);
signal wraux : std_logic_vector(7 downto 0) := (others => '0');
signal wrin : std_logic_vector(7 downto 0) := (others => '0');

begin

mem0 : mem_p
	port map(
	address => ad(18 downto 3),
	clock => clk,
	data => d0,
	wren => wr0,
	q => q0
	);
	
mem1 : mem_p
	port map(
	address => ad(18 downto 3),
	clock => clk,
	data => d1,
	wren => wr1,
	q => q1
	);
	
mem2 : mem_p
	port map(
	address => ad(18 downto 3),
	clock => clk,
	data => d2,
	wren => wr2,
	q => q2
	);
	
mem3 : mem_p
	port map(
	address => ad(18 downto 3),
	clock => clk,
	data => d3,
	wren => wr3,
	q => q3
	);
	
mem4 : mem_p
	port map(
	address => ad(18 downto 3),
	clock => clk,
	data => d4,
	wren => wr4,
	q => q4
	);
	
mem5 : mem_p
	port map(
	address => ad(18 downto 3),
	clock => clk,
	data => d5,
	wren => wr5,
	q => q5
	);
	
mem6 : mem_p
	port map(
	address => ad(18 downto 3),
	clock => clk,
	data => d6,
	wren => wr6,
	q => q6
	);
	
mem7 : mem_p
	port map(
	address => ad(18 downto 3),
	clock => clk,
	data => d7,
	wren => wr7,
	q => q7
	);
	
process (clk, wr , ad, d, frmt)
begin
	case frmt is
      when "000" => wraux <= "00000001";
      when '1' => s <= e1;
    end case;
end process;

end ckt ;