LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

--Bit inputs :  in_A, in_B
--Carry in   :  in_C

ENTITY FullAdder_1bit IS
	PORT (
		in_A, in_B 		 : IN STD_LOGIC;
		in_C	 	 	 : IN STD_LOGIC;
		o_Result, o_CarryOut	 : OUT STD_LOGIC );
END;

ARCHITECTURE struct OF FullAdder_1bit IS

SIGNAL int_R, int_C : STD_LOGIC;

	--Signal Assigment
BEGIN
	int_R <= (not(in_A) AND not(in_B) AND in_C) OR (not(in_A) AND in_B AND not(in_C)) OR (in_A AND not(in_B) AND not(in_C)) OR (in_A AND in_B AND in_C);
	int_C <= (in_B AND in_C) OR (in_A AND in_C) OR (in_A AND in_B) ;

	--Output Assignment
	o_Result   <= int_R;
	o_CarryOut <= int_C;
END struct;