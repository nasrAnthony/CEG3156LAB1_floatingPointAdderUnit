LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

--Bit inputs (8 bits) :  in_A, in_B
--Carry in  	      :  in_C

ENTITY FullAdder_8bit IS
	PORT (
		in_A, in_B 		 : IN STD_LOGIC_VECTOR(7 downto 0);
		in_C	 	 	 : IN STD_LOGIC;
		o_Result		 : OUT STD_LOGIC_VECTOR(7 downto 0);
		o_CarryOut, o_Overflow	 : OUT STD_LOGIC  );
END;

ARCHITECTURE struct OF FullAdder_8bit IS

SIGNAL int_R, int_C : STD_LOGIC_VECTOR(7 downto 0);

COMPONENT FullAdder_1bit IS
	PORT(
		in_A, in_B 		 : IN STD_LOGIC;
		in_C	 	 	 : IN STD_LOGIC;
		o_Result, o_CarryOut	 : OUT STD_LOGIC );
END COMPONENT;

	--Component Setup
BEGIN
	FA_0: FullAdder_1bit
	PORT MAP(
		in_A => in_A(0), 
		in_B => in_B(0), 		
		in_C => in_C,
		o_Result => int_R(0),
	 	o_CarryOut =>int_C(0) );

	FA_1: FullAdder_1bit
	PORT MAP(
		in_A => in_A(1), 
		in_B => in_B(1), 		
		in_C => int_C(0),
		o_Result => int_R(1),
	 	o_CarryOut =>int_C(1) );

	FA_2: FullAdder_1bit
	PORT MAP(
		in_A => in_A(2), 
		in_B => in_B(2), 		
		in_C => int_C(1),
		o_Result => int_R(2),
	 	o_CarryOut =>int_C(2) );

	FA_3: FullAdder_1bit
	PORT MAP(
		in_A => in_A(3), 
		in_B => in_B(3), 		
		in_C => int_C(2),
		o_Result => int_R(3),
	 	o_CarryOut =>int_C(3) );
	
	FA_4: FullAdder_1bit
	PORT MAP(
		in_A => in_A(4), 
		in_B => in_B(4), 		
		in_C => int_C(3),
		o_Result => int_R(4),
	 	o_CarryOut =>int_C(4) );

	FA_5: FullAdder_1bit
	PORT MAP(
		in_A => in_A(5), 
		in_B => in_B(5), 		
		in_C => int_C(4),
		o_Result => int_R(5),
	 	o_CarryOut =>int_C(5) );

	FA_6: FullAdder_1bit
	PORT MAP(
		in_A => in_A(6), 
		in_B => in_B(6), 		
		in_C => int_C(5),
		o_Result => int_R(6),
	 	o_CarryOut =>int_C(6) );

	FA_7: FullAdder_1bit
	PORT MAP(
		in_A => in_A(7), 
		in_B => in_B(7), 		
		in_C => int_C(6),
		o_Result => int_R(7),
	 	o_CarryOut =>int_C(7) );

	--Output Assignment
	o_Result   <= int_R;
	o_CarryOut <= int_C(7);
	o_Overflow <= int_C(7) XOR int_C(6);
END struct;
