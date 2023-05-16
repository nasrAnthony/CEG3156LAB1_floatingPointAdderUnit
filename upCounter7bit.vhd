library ieee;
USE ieee.std_logic_1164.ALL;

entity upCounter7bit is 
	port	
		(
			i_resetNot : in std_logic;
			i_load : in std_logic;
			i_countUP : in std_logic;
			i_clk : in std_logic;
			i_input : in std_logic_vector(6 downto 0);
			o_output : out std_logic_vector(6 downto 0)
			
		);
		
end upCounter7bit;


architecture structural of upCounter7bit is 

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
signal mid_sum, mid_d, mid_out : std_logic_vector(6 downto 0);
signal mid_En : std_logic;
begin 
--DRIVING the en bit :

mid_En <= i_countUP XOR i_load;
mid_d <= ((i_load & i_load & i_load & i_load & i_load & i_load & i_load) and i_input) or ((i_countUP & i_countUP & i_countUP & i_countUP & i_countUP & i_countUP & i_countUP) and mid_sum);

instanceOFadder : fullAdder7bit
	port map
			(
				i_A => mid_out, 
				i_B => "0000001", --ADDING one to the LSB for increment (UP count)
				i_Carry => '0', 
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
	o_output <= mid_out;
end structural;