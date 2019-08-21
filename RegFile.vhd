library ieee ;
use ieee . std_logic_1164 .all;
entity RegFile is
port (clk,c,wr: in std_logic ;
		wrA, rd0, rd1 : in std_logic_vector(5 downto 0);
		d : in std_logic_vector(31 downto 0);
		q0, q1 : out std_logic_vector(31 downto 0));
end RegFile;

architecture Banco of RegFile is

signal qx1, qx2, qx3, qx4, qx5, qx6, qx7, qx8, qx9, qx10, qx11, qx12, qx13, qx14, qx15, qx16, qx17, qx18, qx19, qx20, qx21, qx22, qx23, qx24, qx25, qx26, qx27, qx28, qx29, qx30, qx31: std_logic_vector(31 downto 0);
signal ldx1, ldx2, ldx3, ldx4, ldx5, ldx6, ldx7, ldx8, ldx9, ldx10, ldx11, ldx12, ldx13, ldx14, ldx15, ldx16, ldx17, ldx18, ldx19, ldx20, ldx21, ldx22, ldx23, ldx24, ldx25, ldx26, ldx27, ldx28, ldx29, ldx30, ldx31: std_logic;

component Reg32 is
port (clk,c,ld: in std_logic ;
		d: in std_logic_vector(31 downto 0);
		q : out std_logic_vector(31 downto 0));
end component;

begin

Rx1 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx1,
	d => d,
	q => qx1
	);
	
Rx2 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx2,
	d => d,
	q => qx2
	);
	
Rx3 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx3,
	d => d,
	q => qx3
	);
	
Rx4 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx4,
	d => d,
	q => qx4
	);
	
Rx5 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx5,
	d => d,
	q => qx5
	);
	
Rx6 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx6,
	d => d,
	q => qx6
	);
	
Rx7 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx7,
	d => d,
	q => qx7
	);
	
Rx8 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx8,
	d => d,
	q => qx8
	);
	
Rx9 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx9,
	d => d,
	q => qx9
	);
	
Rx10 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx10,
	d => d,
	q => qx10
	);
	
Rx11 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx11,
	d => d,
	q => qx11
	);
	
Rx12 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx12,
	d => d,
	q => qx12
	);
	
Rx13 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx13,
	d => d,
	q => qx13
	);
	
Rx14 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx14,
	d => d,
	q => qx14
	);
	
Rx15 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx15,
	d => d,
	q => qx15
	);
	
Rx16 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx16,
	d => d,
	q => qx16
	);
	
Rx17 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx17,
	d => d,
	q => qx17
	);
	
Rx18 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx18,
	d => d,
	q => qx18
	);
	
Rx19 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx19,
	d => d,
	q => qx19
	);
	
Rx20 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx20,
	d => d,
	q => qx20
	);
	
Rx21 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx21,
	d => d,
	q => qx21
	);
	
Rx22 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx22,
	d => d,
	q => qx22
	);
	
Rx23 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx23,
	d => d,
	q => qx23
	);
	
Rx24 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx24,
	d => d,
	q => qx24
	);
	
Rx25 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx25,
	d => d,
	q => qx25
	);
	
Rx26 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx26,
	d => d,
	q => qx26
	);
	
Rx27 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx27,
	d => d,
	q => qx27
	);
	
Rx28 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx28,
	d => d,
	q => qx28
	);
	
Rx29 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx29,
	d => d,
	q => qx29
	);
	
Rx30 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx30,
	d => d,
	q => qx30
	);
	
Rx31 : Reg
	port map(
	clk => clk,
	c => c,
	ld => ldx31,
	d => d,
	q => qx31
	);
	
case rd0 is
	when "00000" => q0 <= "00000000000000000000000000000000";
	when "00001" => q0 <= qx1;
	when "00010" => q0 <= qx2;
	when "00011" => q0 <= qx3;
	when "00100" => q0 <= qx4;
	when "00101" => q0 <= qx5;
	when "00110" => q0 <= qx6;
	when "00111" => q0 <= qx7;
	when "01000" => q0 <= qx8;
	when "01001" => q0 <= qx9;
	when "01010" => q0 <= qx10;
	when "01011" => q0 <= qx11;
	when "01100" => q0 <= qx12;
	when "01101" => q0 <= qx13;
	when "01110" => q0 <= qx14;
	when "01111" => q0 <= qx15;
	when "10000" => q0 <= qx16;
	when "10001" => q0 <= qx17;
	when "10010" => q0 <= qx18;
	when "10011" => q0 <= qx19;
	when "10100" => q0 <= qx20;
	when "10101" => q0 <= qx21;
	when "10110" => q0 <= qx22;
	when "10111" => q0 <= qx23;
	when "11000" => q0 <= qx24;
	when "11001" => q0 <= qx25;
	when "11010" => q0 <= qx26;
	when "11011" => q0 <= qx27;
	when "11100" => q0 <= qx28;
	when "11101" => q0 <= qx29;
	when "11110" => q0 <= qx30;
	when "11111" => q0 <= qx31;
end case;
		
	
case rd1 is
	when "00000" => q1 <= "00000000000000000000000000000000";
	when "00001" => q1 <= qx1;
	when "00010" => q1 <= qx2;
	when "00011" => q1 <= qx3;
	when "00100" => q1 <= qx4;
	when "00101" => q1 <= qx5;
	when "00110" => q1 <= qx6;
	when "00111" => q1 <= qx7;
	when "01000" => q1 <= qx8;
	when "01001" => q1 <= qx9;
	when "01010" => q1 <= qx10;
	when "01011" => q1 <= qx11;
	when "01100" => q1 <= qx12;
	when "01101" => q1 <= qx13;
	when "01110" => q1 <= qx14;
	when "01111" => q1 <= qx15;
	when "10000" => q1 <= qx16;
	when "10001" => q1 <= qx17;
	when "10010" => q1 <= qx18;
	when "10011" => q1 <= qx19;
	when "10100" => q1 <= qx20;
	when "10101" => q1 <= qx21;
	when "10110" => q1 <= qx22;
	when "10111" => q1 <= qx23;
	when "11000" => q1 <= qx24;
	when "11001" => q1 <= qx25;
	when "11010" => q1 <= qx26;
	when "11011" => q1 <= qx27;
	when "11100" => q1 <= qx28;
	when "11101" => q1 <= qx29;
	when "11110" => q1 <= qx30;
	when "11111" => q1 <= qx31;
end case;

	
case wrA is
	when "00001" => ldx1 <= wr;
	when "00010" => ldx2 <= wr;
	when "00011" => ldx3 <= wr;
	when "00100" => ldx4 <= wr;
	when "00101" => ldx5 <= wr;
	when "00110" => ldx6 <= wr;
	when "00111" => ldx7 <= wr;
	when "01000" => ldx8 <= wr;
	when "01001" => ldx9 <= wr;
	when "01010" => ldx10 <= wr;
	when "01011" => ldx11 <= wr;
	when "01100" => ldx12 <= wr;
	when "01101" => ldx13 <= wr;
	when "01110" => ldx14 <= wr;
	when "01111" => ldx15 <= wr;
	when "10000" => ldx16 <= wr;
	when "10001" => ldx17 <= wr;
	when "10010" => ldx18 <= wr;
	when "10011" => ldx19 <= wr;
	when "10100" => ldx20 <= wr;
	when "10101" => ldx21 <= wr;
	when "10110" => ldx22 <= wr;
	when "10111" => ldx23 <= wr;
	when "11000" => ldx24 <= wr;
	when "11001" => ldx25 <= wr;
	when "11010" => ldx26 <= wr;
	when "11011" => ldx27 <= wr;
	when "11100" => ldx28 <= wr;
	when "11101" => ldx29 <= wr;
	when "11110" => ldx30 <= wr;
	when "11111" => ldx31 <= wr;
end case;

end Banco;