library ieee;
use ieee.std_logic_1164.all;

entity RegFile64 is port (
	-- Clock e sinal de load
	clk, ld			: in std_logic;
	-- Endereços dos registradores
	addr0, addr1 	: in std_logic_vector(4 downto 0);
	-- Dados de entrada do registro referenciado por addr0
	d 				: in std_logic_vector(63 downto 0);
	-- Saídas dos registradores referenciados por addr0 e addr1
	q0, q1 			: out std_logic_vector(63 downto 0)
);
end RegFile64;

architecture bhv of RegFile64 is

	type q_array is array (31 downto 0) of std_logic_vector(63 downto 0);

	signal qx	: q_array;
	signal ldx	: std_logic_vector(31 downto 0) := (others => '0');

	component Reg64 is port (
		clk, ld	: in std_logic;
		d		: in std_logic_vector(63 downto 0);
		q 		: out std_logic_vector(63 downto 0)
	);
	end component;

	component mux32x64 is port (
		e0,  e1,  e2,  e3,
		e4,  e5,  e6,  e7,
		e8,  e9,  e10, e11,
		e12, e13, e14, e15,
		e16, e17, e18, e19,
		e20, e21, e22, e23,
		e24, e25, e26, e27,
		e28, e29, e30, e31  : in std_logic_vector(63 downto 0);
		sw                  : in std_logic_vector(4 downto 0);
		s                   : out std_logic_vector(63 downto 0)
	);
	end component;

	component Demux32 is port (
		addr    : in std_logic_vector(4 downto 0);
		en      : in std_logic;
		q       : out std_logic_vector(31 downto 0)
	);
	end component;

begin

	demux : Demux32 port map(
		addr 	=> addr0,
		en		=> ld,
		q		=> ldx
	);

	rx0  : Reg64 port map(clk, '0',     d,  qx(0));
	rx1  : Reg64 port map(clk, ldx(1),  d,  qx(1));
	rx2  : Reg64 port map(clk, ldx(2),  d,  qx(2));
	rx3  : Reg64 port map(clk, ldx(3),  d,  qx(3));
	rx4  : Reg64 port map(clk, ldx(4),  d,  qx(4));
	rx5  : Reg64 port map(clk, ldx(5),  d,  qx(5));
	rx6  : Reg64 port map(clk, ldx(6),  d,  qx(6));
	rx7  : Reg64 port map(clk, ldx(7),  d,  qx(7));
	rx8  : Reg64 port map(clk, ldx(8),  d,  qx(8));
	rx9  : Reg64 port map(clk, ldx(9),  d,  qx(9));
	rx10 : Reg64 port map(clk, ldx(10), d, qx(10));
	rx11 : Reg64 port map(clk, ldx(11), d, qx(11));
	rx12 : Reg64 port map(clk, ldx(12), d, qx(12));
	rx13 : Reg64 port map(clk, ldx(13), d, qx(13));
	rx14 : Reg64 port map(clk, ldx(14), d, qx(14));
	rx15 : Reg64 port map(clk, ldx(15), d, qx(15));
	rx16 : Reg64 port map(clk, ldx(16), d, qx(16));
	rx17 : Reg64 port map(clk, ldx(17), d, qx(17));
	rx18 : Reg64 port map(clk, ldx(18), d, qx(18));
	rx19 : Reg64 port map(clk, ldx(19), d, qx(19));
	rx20 : Reg64 port map(clk, ldx(20), d, qx(20));
	rx21 : Reg64 port map(clk, ldx(21), d, qx(21));
	rx22 : Reg64 port map(clk, ldx(22), d, qx(22));
	rx23 : Reg64 port map(clk, ldx(23), d, qx(23));
	rx24 : Reg64 port map(clk, ldx(24), d, qx(24));
	rx25 : Reg64 port map(clk, ldx(25), d, qx(25));
	rx26 : Reg64 port map(clk, ldx(26), d, qx(26));
	rx27 : Reg64 port map(clk, ldx(27), d, qx(27));
	rx28 : Reg64 port map(clk, ldx(28), d, qx(28));
	rx29 : Reg64 port map(clk, ldx(29), d, qx(29));
	rx30 : Reg64 port map(clk, ldx(30), d, qx(30));
	rx31 : Reg64 port map(clk, ldx(31), d, qx(31));

	mux0 : mux32x64 port map (
		qx(0),  qx(1),  qx(2),  qx(3),
		qx(4),  qx(5),  qx(6),  qx(7),
		qx(8),  qx(9),  qx(10), qx(11),
		qx(12), qx(13), qx(14), qx(15),
		qx(16), qx(17), qx(18), qx(19),
		qx(20), qx(21), qx(22), qx(23),
		qx(24), qx(25), qx(26), qx(27),
		qx(28), qx(29), qx(30), qx(31),
		addr0, q0
	);

	mux1 : mux32x64 port map (
		qx(0),  qx(1),  qx(2),  qx(3),
		qx(4),  qx(5),  qx(6),  qx(7),
		qx(8),  qx(9),  qx(10), qx(11),
		qx(12), qx(13), qx(14), qx(15),
		qx(16), qx(17), qx(18), qx(19),
		qx(20), qx(21), qx(22), qx(23),
		qx(24), qx(25), qx(26), qx(27),
		qx(28), qx(29), qx(30), qx(31),
		addr1, q1
	);
end bhv;