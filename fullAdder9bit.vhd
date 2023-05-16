library ieee;
use ieee.std_logic_1164.all;

entity fullAdder9bit is port(
	i_clk, i_rstnot : in std_logic;
	i_A : in std_logic_vector(8 downto 0);
	i_B : in std_logic_vector(8 downto 0);
	i_Carry : in std_logic;
	o_Carry: out std_logic;
	o_Sum : out std_logic_vector(8 downto 0)
	);
		
end fullAdder9bit;


architecture structural of fullAdder9bit is 

component fullAdderONEbit   -- Defining the 1 bit full adder component. 
	port(		i_a, i_b, i_c : in std_logic;
				o_sum, o_c : out std_logic
		);
		 
end component;
--COMPONENT declaration of the DFF given by prof.. 
component enARdFF_2 port
	(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC
	);
end component;

signal mid_Carry :  std_logic_vector(7 downto 0);
signal int_Sum : std_logic_vector(8 downto 0);

begin
--INSTANTIATING the 1 bit adders:
OneBitadder8: fullAdderONEbit
	port map(
			i_a => i_A(8),
			i_b => i_B(8),
			i_c => mid_Carry(7),
			o_c => o_Carry,
			o_sum => int_Sum(8)
		);
OneBitadder7: fullAdderONEbit
	port map(
			i_a => i_A(7),
			i_b => i_B(7),
			i_c => mid_Carry(6),
			o_c => mid_Carry(7),
			o_sum => int_Sum(7)
		);
OneBitadder6: fullAdderONEbit
	port map(
			i_a => i_A(6),
			i_b => i_B(6),
			i_c => mid_Carry(5),
			o_c => mid_Carry(6),
			o_sum => int_Sum(6)
		);
OneBitadder5: fullAdderONEbit
	port map(
			i_a => i_A(5),
			i_b => i_B(5),
			i_c => mid_Carry(4),
			o_c => mid_Carry(5),
			o_sum => int_Sum(5)
		);
OneBitadder4: fullAdderONEbit
	port map(
			i_a => i_A(4),
			i_b => i_B(4),
			i_c => mid_Carry(3),
			o_c => mid_Carry(4),
			o_sum => int_Sum(4)
		);	
OneBitadder3: fullAdderONEbit
	port map(
			i_a => i_A(3),
			i_b => i_B(3),
			i_c => mid_Carry(2),
			o_c => mid_Carry(3),
			o_sum => int_Sum(3)
		);	
OneBitadder2: fullAdderONEbit
	port map(
			i_a => i_A(2),
			i_b => i_B(2),
			i_c => mid_Carry(1),
			o_c => mid_Carry(2),
			o_sum => int_Sum(2)
		);
OneBitadder1: fullAdderONEbit
	port map(
			i_a => i_A(1),
			i_b => i_B(1),
			i_c => mid_Carry(0),
			o_c => mid_Carry(1),
			o_sum => int_Sum(1)
		);
OneBitadder0: fullAdderONEbit
	port map(
			i_a => i_A(0),
			i_b => i_B(0),
			i_c => i_Carry,
			o_c => mid_Carry(0),
			o_sum => int_Sum(0)
		);

--CREATING DFF instances for latching of the sum output:

out8: enARdFF_2
	PORT MAP (	i_resetBar => i_rstnot,
				i_clock => i_clk,
				i_d => int_Sum(8),
				i_enable => '1',
				o_q => o_Sum(8)
			);
out7: enARdFF_2
	PORT MAP (	i_resetBar => i_rstnot,
				i_clock => i_clk,
				i_d => int_Sum(7),
				i_enable => '1',
				o_q => o_Sum(7)
			);
out6: enARdFF_2
	PORT MAP (	i_resetBar => i_rstnot,
				i_clock => i_clk,
				i_d => int_Sum(6),
				i_enable => '1',
				o_q => o_Sum(6)
			);
out5: enARdFF_2
	PORT MAP (	i_resetBar => i_rstnot,
				i_clock => i_clk,
				i_d => int_Sum(5),
				i_enable => '1',
				o_q => o_Sum(5)
			);
out4: enARdFF_2
	PORT MAP (	i_resetBar => i_rstnot,
				i_clock => i_clk,
				i_d => int_Sum(4),
				i_enable => '1',
				o_q => o_Sum(4)
			);
out3: enARdFF_2
	PORT MAP (	i_resetBar => i_rstnot,
				i_clock => i_clk,
				i_d => int_Sum(3),
				i_enable => '1',
				o_q => o_Sum(3)
			);
out2: enARdFF_2
	PORT MAP (	i_resetBar => i_rstnot,
				i_clock => i_clk,
				i_d => int_Sum(2),
				i_enable => '1',
				o_q => o_Sum(2)
			);
out1: enARdFF_2
	PORT MAP (	i_resetBar => i_rstnot,
				i_clock => i_clk,
				i_d => int_Sum(1),
				i_enable => '1',
				o_q => o_Sum(1)
			);
out0: enARdFF_2
	PORT MAP (	i_resetBar => i_rstnot,
				i_clock => i_clk,
				i_d => int_Sum(0),
				i_enable => '1',
				o_q => o_Sum(0)
			);
end structural;