library ieee;
use ieee.std_logic_1164.all;

entity comparator7bit is 
	port
		( 
			ein1, ein2 : in std_logic_vector(6 downto 0);
			o_GT, o_LT, o_EQ, temp_less9Flag: out std_logic

		);
end comparator7bit;

architecture structural of comparator7bit is 
signal zero : std_logic;
signal temp_GT, temp_LT : std_logic_vector(6 downto 0);
component comparator1bit 
	port	
		( 	
			i_GTPrevious, i_LTPrevious	: IN	STD_LOGIC;
			i_Ai, i_Bi			: IN	STD_LOGIC;
			o_EQ, o_GT, o_LT			: OUT	STD_LOGIC
			
		);
end component;

begin 
	
	
-- set the zerosignal as 0:
zero <= '0';

--instantiate the 1 bit comparators to compare the 7 bit number inputs:
bit6 : comparator1bit
	port	
		map
			(
				i_GTPrevious => '0',
				i_LTPrevious => '0',
				i_Ai => ein1(6), 
				i_Bi => ein2(6), 
				o_GT => temp_GT(6), 
				o_LT => temp_LT(6)
			);
bit5 : comparator1bit
	port	
		map
			(
				i_GTPrevious => temp_GT(6),
				i_LTPrevious => temp_LT(6),
				i_Ai => ein1(5), 
				i_Bi => ein2(5), 
				o_GT => temp_GT(5), 
				o_LT =>temp_LT(5)
			);
bit4 : comparator1bit
	port	
		map
			(
				i_GTPrevious => temp_GT(5),
				i_LTPrevious => temp_LT(5),
				i_Ai => ein1(4), 
				i_Bi => ein2(4), 
				o_GT => temp_GT(4), 
				o_LT =>temp_LT(4)
			);
bit3 : comparator1bit
	port	
		map
			(
				i_GTPrevious => temp_GT(4),
				i_LTPrevious => temp_LT(4),
				i_Ai => ein1(3), 
				i_Bi => ein2(3), 
				o_GT => temp_GT(3), 
				o_LT =>temp_LT(3)
			);
bit2 : comparator1bit
	port	
		map
			(
				i_GTPrevious => temp_GT(3),
				i_LTPrevious => temp_LT(3),
				i_Ai => ein1(2),
				i_Bi => ein2(2), 
				o_GT => temp_GT(2), 
				o_LT =>temp_LT(2)
			);
bit1 : comparator1bit
	port	
		map
			(
				i_GTPrevious => temp_GT(2),
				i_LTPrevious => temp_LT(2),
				i_Ai => ein1(1),
				i_Bi => ein2(1), 
				o_GT => temp_GT(1), 
				o_LT =>temp_LT(1)
			);
bit0 : comparator1bit
	port	
		map
			(
				i_GTPrevious => temp_GT(1),
				i_LTPrevious => temp_LT(1),
				i_Ai => ein1(0),
				i_Bi => ein2(0), 
				o_GT => temp_GT(0), 
				o_LT =>temp_LT(0)
			);

	o_EQ <= temp_GT(0) nor temp_LT(0);
	o_GT <= temp_GT(0);
	o_LT <= temp_LT(0);
	temp_less9Flag <= not(temp_GT(0) nor temp_LT(0)) and not(temp_LT(0)) and temp_GT(0);
end structural;