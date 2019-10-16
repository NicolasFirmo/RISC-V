library ieee;
use ieee.std_logic_1164.all;

entity Shift64R64 is port(
	en: 		in std_logic_vector(5 downto 0);
	entrada: in std_logic_vector(63 downto 0);
	saida: 	out std_logic_vector(63 downto 0));
end Shift64R64;

architecture bhvr of Shift64R64 is

component Shift64R1 is port(
	en:			in std_logic;
	entrada:		in std_logic_vector(63 downto 0);
	saida: 		out std_logic_vector(63 downto 0)
);
end component;
component Shift64R2 is port(
	en:			in std_logic;
	entrada:		in std_logic_vector(63 downto 0);
	saida: 		out std_logic_vector(63 downto 0)
);
end component;
component Shift64R4 is port(
	en:			in std_logic;
	entrada:		in std_logic_vector(63 downto 0);
	saida: 		out std_logic_vector(63 downto 0)
);
end component;
component Shift64R8 is port(
	en:			in std_logic;
	entrada:		in std_logic_vector(63 downto 0);
	saida: 		out std_logic_vector(63 downto 0)
);
end component;
component Shift64R16 is port(
	en:			in std_logic;
	entrada:		in std_logic_vector(63 downto 0);
	saida: 		out std_logic_vector(63 downto 0)
);
end component;
component Shift64R32 is port(
	en:			in std_logic;
	entrada:		in std_logic_vector(63 downto 0);
	saida: 		out std_logic_vector(63 downto 0)
);
end component;

signal sll0_out, sll1_out, sll2_out, sll3_out, sll4_out: std_logic_vector(63 downto 0);

begin
	
	sll0: Shift64R1 port map(en(0), entrada, sll0_out);
	sll1: Shift64R2 port map(en(1), sll0_out, sll1_out);
	sll2: Shift64R4 port map(en(2), sll1_out, sll2_out);
	sll3: Shift64R8 port map(en(3), sll2_out, sll3_out);
	sll4: Shift64R16 port map(en(4), sll3_out, sll4_out);
	sll5: Shift64R32 port map(en(5), sll4_out, saida);
	
end bhvr;