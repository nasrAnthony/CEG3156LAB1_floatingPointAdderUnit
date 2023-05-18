LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY comparator1bit IS
	PORT(
		i_GTPrevious, i_LTPrevious	: IN	STD_LOGIC;
		i_Ai, i_Bi			: IN	STD_LOGIC;
		o_EQ, o_GT, o_LT			: OUT	STD_LOGIC);
END comparator1bit;

ARCHITECTURE rtl OF comparator1bit IS

	SIGNAL int_GT, int_LT : STD_LOGIC;

BEGIN

	int_GT <= i_GTPrevious or(not(i_Bi) and not(i_LTPrevious) and i_Ai); --Greater than signal
	int_LT <= i_LTPrevious or (not(i_Ai) and not(i_GTPrevious) and i_Bi);--Less than signal 
	-- Concurrent Signal Assignment
	o_EQ <= int_LT nor int_GT;
	o_LT <= int_LT;
	o_GT <= int_GT;

END rtl;
