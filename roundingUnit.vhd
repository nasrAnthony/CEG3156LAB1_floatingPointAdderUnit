library IEEE;
use ieee.std_logic_1164.all;


entity roundingUnit is port 
		(
			i_bitStream : in std_logic_vector(2 downto 0);
			i_resetNot , i_en : in std_logic;
			i_clk : in std_logic;
			o_bitStream : out std_logic_vector(2 downto 0)
			
		);
		
end roundingUnit;


architecture structural of roundingUnit  is 
signal temp_bitStream : std_logic_vector( 2 downto 0);
component enARdFF_2 is
	port 
		(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC
		);
end component;
begin 
G :  enARdFF_2
	port
		map 
			(
				i_resetBar => i_resetNot,
				i_d => i_bitStream(2),
				i_enable => i_en, 
				i_clock => i_clk, 
				o_q => temp_bitStream(2)
			
			);
			
R :  enARdFF_2
	port
		map 
			(
				i_resetBar => i_resetNot,
				i_d => i_bitStream(1),
				i_enable => i_en, 
				i_clock => i_clk, 
				o_q => temp_bitStream(1)
			
			);
S :  enARdFF_2
	port
		map 
			(
				i_resetBar => i_resetNot,
				i_d => i_bitStream(0),
				i_enable => i_en, 
				i_clock => i_clk, 
				o_q => temp_bitStream(0)
			
			);
			
	--Drive the output: 
	o_bitStream <= temp_bitStream;
end structural;


