library ieee;
use ieee.std_logic_1164.all;


entity fullAdder8bit is port(
	i_A : in std_logic_vector(7 downto 0);
	i_B : in std_logic_vector(7 downto 0);
	i_Carry : in std_logic;
	o_Sign, o_Carry: out std_logic;
	o_Sum : out std_logic_vector(7 downto 0)
	);
		
end fullAdder8bit;


architecture structural of fullAdder8bit is 

component fullAdderONEbit   -- Defining the 1 bit full adder component. 
	port(		i_a, i_b, i_c : in std_logic;
				o_sum, o_c : out std_logic
		);
		 
end component;

signal mid_Carry :  std_logic_vector(7 downto 0);

begin
--INSTANTIATING the 1 bit adders:
OneBitadder7: fullAdderONEbit
	port map(
			i_a => i_A(7),
			i_b => i_B(7),
			i_c => mid_carry(6),
			o_c => mid_Carry(7),
			o_sum => o_Sign
		);
OneBitadder6: fullAdderONEbit
	port map(
			i_a => i_A(6),
			i_b => i_B(6),
			i_c => mid_carry(5),
			o_c => mid_Carry(6),
			o_sum => o_Sum(6)
		);
OneBitadder5: fullAdderONEbit
	port map(
			i_a => i_A(5),
			i_b => i_B(5),
			i_c => mid_carry(4),
			o_c => mid_Carry(5),
			o_sum => o_Sum(5)
		);
OneBitadder4: fullAdderONEbit
	port map(
			i_a => i_A(4),
			i_b => i_B(4),
			i_c => mid_carry(3),
			o_c => mid_Carry(4),
			o_sum => o_Sum(4)
		);
OneBitadder3: fullAdderONEbit
	port map(
			i_a => i_A(3),
			i_b => i_B(3),
			i_c => mid_carry(2),
			o_c => mid_Carry(3),
			o_sum => o_Sum(3)
		);	
OneBitadder2: fullAdderONEbit
	port map(
			i_a => i_A(2),
			i_b => i_B(2),
			i_c => mid_carry(1),
			o_c => mid_Carry(2),
			o_sum => o_Sum(2)
		);		
OneBitadder1: fullAdderONEbit
	port map(
			i_a => i_A(1),
			i_b => i_B(1),
			i_c => mid_carry(0),
			o_c => mid_Carry(1),
			o_sum => o_Sum(1)
		);
OneBitadder0: fullAdderONEbit
	port map(
			i_a => i_A(0),
			i_b => i_B(0),
			i_c => i_Carry,
			o_c => mid_Carry(0),
			o_sum => o_Sum(0)
		);
end structural;