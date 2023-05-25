LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- 7 bit subtractor in the format of A - B = results
-- implemented through full adders, where B is complimented and Carry input is on
-- to represent B negative value in 2's compliment form

 
ENTITY Subtractor_8bit IS
	PORT (
		in_A, in_B 		 : IN STD_LOGIC_VECTOR (7 downto 0);
		o_Result		 : OUT STD_LOGIC_VECTOR (7 downto 0);
		o_Overflow		 : OUT STD_LOGIC	 );
END;

ARCHITECTURE struct OF Subtractor_8bit IS

SIGNAL int_B : STD_LOGIC_VECTOR (7 downto 0);
SIGNAL int_C : STD_LOGIC;

COMPONENT FullAdder_8bit IS
	PORT(
		in_A, in_B 		 : IN STD_LOGIC_VECTOR(7 downto 0);
		in_C	 	 	 : IN STD_LOGIC;
		o_Result		 : OUT STD_LOGIC_VECTOR(7 downto 0);
		o_CarryOut, o_Overflow	 : OUT STD_LOGIC  );
END COMPONENT;
	--Signal Assigment
BEGIN
	int_B(0) <= in_B(0) XOR '1';
	int_B(1) <= in_B(1) XOR '1';
	int_B(2) <= in_B(2) XOR '1';
	int_B(3) <= in_B(3) XOR '1';
	int_B(4) <= in_B(4) XOR '1';
	int_B(5) <= in_B(5) XOR '1';
	int_B(6) <= in_B(6) XOR '1';
	int_B(7) <= in_B(7) XOR '1';

	FA_8bit: FullAdder_8bit
	PORT MAP(
		in_A => in_A, 
		in_B => int_B, 		
		in_C => '1',
		o_Result   => o_Result,
	 	o_CarryOut => int_C,
		o_Overflow => o_Overflow );

END struct;