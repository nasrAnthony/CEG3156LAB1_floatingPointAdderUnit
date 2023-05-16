library ieee;
use ieee.std_logic_1164.all;


entity reg7Bit is port(
						i_rstG, i_clk, i_load : in std_logic;
						i_inBits : in std_logic_vector(6 downto 0);
						o_outBits : out std_logic_vector(6 downto 0)
						);
end reg7Bit;

architecture structural of reg7Bit is 
	
signal mid_outBits : std_logic_vector(6 downto 0);
	 
--COMPONENT declaration of the DFF given by prof.. 
component enARdFF_2 port
	(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC
	);
end component;
--INSTANTIATING THE DFFS (7 total) one per bit. 
BEGIN
DFF6: enARdFF_2
		port map
			(
				i_resetBar	=> i_rstG ,
				i_d			=> i_inBits(6),
				i_enable	=> i_load,
				i_clock		=> i_clk ,
				o_q     	=> mid_outBits(6)
			);
DFF5: enARdFF_2
		port map
			(
				i_resetBar	=> i_rstG ,
				i_d			=> i_inBits(5),
				i_enable	=> i_load,
				i_clock		=> i_clk ,
				o_q     	=> mid_outBits(5)
			);
DFF4: enARdFF_2
		port map
			(
				i_resetBar	=> i_rstG ,
				i_d			=> i_inBits(4),
				i_enable	=> i_load,
				i_clock		=> i_clk,
				o_q     	=> mid_outBits(4)
			);
DFF3: enARdFF_2
		port map
			(
				i_resetBar	=> i_rstG,
				i_d			=> i_inBits(3),
				i_enable	=> i_load,
				i_clock		=> i_clk,
				o_q     	=> mid_outBits(3)
			);
DFF2: enARdFF_2
		port map
			(
				i_resetBar	=> i_rstG ,
				i_d			=> i_inBits(2),
				i_enable	=> i_load,
				i_clock		=> i_clk,
				o_q     	=> mid_outBits(2)
			);
DFF1: enARdFF_2
		port map
			(
				i_resetBar	=> i_rstG,
				i_d			=> i_inBits(1),
				i_enable	=> i_load,
				i_clock		=> i_clk,
				o_q     	=> mid_outBits(1)
			);
DFF0: enARdFF_2
		port map
			(
				i_resetBar	=> i_rstG,
				i_d			=> i_inBits(0),
				i_enable	=> i_load,
				i_clock		=> i_clk,
				o_q     	=> mid_outBits(0)
			);
-- drive the output from the middle signal to the outpout signal:
o_outBits <= mid_outBits;

end architecture;
