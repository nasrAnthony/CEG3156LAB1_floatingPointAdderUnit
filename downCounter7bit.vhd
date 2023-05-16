library ieee;
USE ieee.std_logic_1164.ALL;

entity downCounter7bit is 
	port	
		(
			i_resetNot : in std_logic;
			i_load : in std_logic;
			i_countDOWN : in std_logic;
			i_clk : in std_logic;
			i_input : in std_logic_vector(6 downto 0);
			o_output : out std_logic_vector(6 downto 0);
			zeroFlag : out std_logic --This flag is a one bit trigger to be set when the counter reaches 0 -> [0000000]	
		);
end downCounter7bit;

architecture structural of downCounter7bit is

component enARdFF_2 
	port
		(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC
		);
end component;

component fullAdder7bit 
	port 
		(
			i_A : in std_logic_vector(6 downto 0);
			i_B : in std_logic_vector(6 downto 0);
			i_Carry : in std_logic;
			o_Sum : out std_logic_vector(6 downto 0)
		);
end component;

--intermediate signal declarations: middle signals
signal mid_sum, mid_d, mid_out : std_logic_vector(6 downto 0); --same signals as used in the upCounter7bit.vhd
signal mid_En : std_logic;
begin 
mid_En <= i_load xor i_countDOWN;
mid_d <= ((i_load & i_load & i_load & i_load & i_load & i_load & i_load) and i_input) or ((i_countDOWN & i_countDOWN & i_countDOWN & i_countDOWN & i_countDOWN & i_countDOWN & i_countDOWN) and mid_sum);
--Instance of the 7 bit adder to perform the count down through +-.
instanceOFadder : fullAdder7bit
	port map
			(
				i_A => mid_out, 
				i_B => "1111110", --count down from this -> set carry in to mimic -1. 
				i_Carry => '1', 
				o_Sum => mid_sum
			);
dff6: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_resetNot,
			i_d			=> 	mid_d(6),
			i_enable	=> mid_En,
			i_clock		=> i_clk,
			o_q 		=> mid_out(6)
			);
dff5: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_resetNot,
			i_d			=> 	mid_d(5),
			i_enable	=> mid_En,
			i_clock		=> i_clk,
			o_q 		=> mid_out(5)
			);
dff4: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_resetNot,
			i_d			=> 	mid_d(4),
			i_enable	=> mid_En,
			i_clock		=> i_clk,
			o_q 		=> mid_out(4)
			);
dff3: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_resetNot,
			i_d			=> 	mid_d(3),
			i_enable	=> mid_En,
			i_clock		=> i_clk,
			o_q 		=> mid_out(3)
			);		
dff2: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_resetNot,
			i_d			=> 	mid_d(2),
			i_enable	=> mid_En,
			i_clock		=> i_clk,
			o_q 		=> mid_out(2)
			);
dff1: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_resetNot,
			i_d			=> 	mid_d(1),
			i_enable	=> mid_En,
			i_clock		=> i_clk,
			o_q 		=> mid_out(1)
			);
dff0: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_resetNot,
			i_d			=> 	mid_d(0),
			i_enable	=> mid_En,
			i_clock		=> i_clk,
			o_q 		=> mid_out(0)
			);
--DRIVE THE OUTPUT MIDDLE SIGNAL TO THE O_SUM OF THE COUNTER. 
--SET THE zero Flag in case the counter hits 0000000. 
	zeroFlag <= '1' when (mid_out = "0000000") else '0';
	o_output <= mid_d when(i_load = '1') else mid_out ;
end structural;



