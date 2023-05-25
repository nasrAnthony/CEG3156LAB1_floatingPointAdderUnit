library ieee;
use ieee.std_logic_1164.all;

entity interfaceReg7bit is port 
	( 
		i_clk : in std_logic;
		i_en : in std_logic;
		i_bitStream : in std_logic_vector(6 downto 0);
		i_clearBar : in std_logic;
		o_bitStream : out std_logic_vector(6 downto 0)
	);
end entity;

architecture RTL of interfaceReg7bit is 
signal int_outStream  : std_logic_vector(6 downto 0);

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
begin 
dff0: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_clearBar,
			i_d			=> i_bitStream(0)	,
			i_enable	=> i_en,
			i_clock		=> i_clk,
			o_q 		=> int_outStream(0)
			);
dff1: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_clearBar,
			i_d			=> i_bitStream(1)	,
			i_enable	=> i_en,
			i_clock		=> i_clk,
			o_q 		=> int_outStream(1)
			);
dff2: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_clearBar,
			i_d			=> i_bitStream(2)	,
			i_enable	=> i_en,
			i_clock		=> i_clk,
			o_q 		=> int_outStream(2)
			);
dff4: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_clearBar,
			i_d			=> i_bitStream(4)	,
			i_enable	=> i_en,
			i_clock		=> i_clk,
			o_q 		=> int_outStream(4)
			);
dff5: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_clearBar,
			i_d			=> i_bitStream(5)	,
			i_enable	=> i_en,
			i_clock		=> i_clk,
			o_q 		=> int_outStream(5)
			);
dff6: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_clearBar,
			i_d			=> i_bitStream(6)	,
			i_enable	=> i_en,
			i_clock		=> i_clk,
			o_q      => int_outStream(6)
			);
o_bitStream <= int_outStream;
end RTL;