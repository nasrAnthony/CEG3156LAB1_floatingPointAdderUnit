LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

--Function 		: Write/Decrement a 7bit unsigned number. 
--Input 		: 7bit unsigned number and an operation(Dec/Write)
--Internal Execution	: converts 7bit unsigned to 8bit signed then performs given operation
--		   OP = in_write_dec
--		   if(OP=1) : write 
--		   if(OP=0) : decrement 	 
--Output		: always outputs a 7 bit unsigned number

ENTITY Timer_7bit IS
	PORT (
		in_Time	  			 : IN STD_LOGIC_VECTOR (6 downto 0);
		in_write_dec			 : IN STD_LOGIC;
		in_clk, in_en, in_resetbar	 : IN STD_LOGIC;
		o_Result			 : OUT STD_LOGIC_VECTOR (6 downto 0) );
END;

ARCHITECTURE struct OF Timer_7bit IS

	SIGNAL int_A, int_SR, int_d, int_R	: STD_LOGIC_VECTOR (7 downto 0);
	
	-- Component Declarations

	COMPONENT enARdFF_2 IS
	PORT(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;


	COMPONENT MUX_2x1_8bit IS
	PORT (
		input0, input1  : IN STD_LOGIC_VECTOR (7 downto 0);
		SEL 		: IN STD_LOGIC;
		output 		: OUT STD_LOGIC_VECTOR (7 downto 0) );
	END COMPONENT;

	COMPONENT Subtractor_8bit IS
	PORT (
		in_A, in_B 		 : IN STD_LOGIC_VECTOR (7 downto 0);
		o_Result		 : OUT STD_LOGIC_VECTOR(7 downto 0);
		o_Overflow		 : OUT STD_LOGIC	 );
	END COMPONENT;

BEGIN
	--Signal Assigment
	int_A(6 downto 0) <= in_Time;
	int_A(7) 	  <='0';
	
	--Component Setup
	Sub_8bit: Subtractor_8bit
	PORT MAP(
		in_A => int_R, 
		in_B => "00000001", 		
		o_Result   => int_SR,
		o_Overflow => open );


	Mux: MUX_2x1_8bit
	PORT MAP(
		input0	=>int_SR,
		input1	=>int_A,
		sel 	=>in_write_dec,
		output 	=>int_d );

	DFF_0 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=>int_d(0),
		i_enable	=>in_en,
		i_clock		=>in_clk,
		o_q		=>int_R(0),
		o_qBar		=>open);

	DFF_1 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=>int_d(1),
		i_enable	=>in_en,
		i_clock		=>in_clk,
		o_q		=>int_R(1),
		o_qBar		=>open);

	DFF_2 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=>int_d(2),
		i_enable	=>in_en,
		i_clock		=>in_clk,
		o_q		=>int_R(2),
		o_qBar		=>open);

	DFF_3 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=>int_d(3),
		i_enable	=>in_en,
		i_clock		=>in_clk,
		o_q		=>int_R(3),
		o_qBar		=>open);

	DFF_4 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=>int_d(4),
		i_enable	=>in_en,
		i_clock		=>in_clk,
		o_q		=>int_R(4),
		o_qBar		=>open);

	DFF_5 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=>int_d(5),
		i_enable	=>in_en,
		i_clock		=>in_clk,
		o_q		=>int_R(5),
		o_qBar		=>open);

	DFF_6 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=>int_d(6),
		i_enable	=>in_en,
		i_clock		=>in_clk,
		o_q		=>int_R(6),
		o_qBar		=>open);
	
	DFF_7 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=>int_d(7),
		i_enable	=>in_en,
		i_clock		=>in_clk,
		o_q		=>int_R(7),
		o_qBar		=>open);
	

	--output assignment
	o_Result 	<= int_R(6 downto 0);

END struct;



















