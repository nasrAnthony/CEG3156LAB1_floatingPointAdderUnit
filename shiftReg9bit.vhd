library ieee;
USE ieee.std_logic_1164.ALL;

entity shiftReg9bit is 
	port 
		(
			i_clk, i_clr,  i_resetNot, i_load, i_enShift : in std_logic;
			i_bitStream : in std_logic_vector(8 downto 0);
			o_shiftedStream : out std_logic_vector(8 downto 0);
			out_enable  : out std_logic
		);
end shiftReg9bit;

architecture structural of shiftReg9bit is 

--declaring components..
--DFF. 
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
-- intermediate middle signal declaration.
signal mid_inp, mid_outp : std_logic_vector(8 downto 0);
signal mid_latchEn : std_logic;
begin 
mid_latchEn <= i_clr xor i_load xor i_enShift;

mid_inp <= (i_bitStream and (i_load & i_load & i_load & i_load & i_load & i_load & i_load & i_load & i_load)) or ((mid_latchEn & mid_latchEn & mid_latchEn & mid_latchEn & mid_latchEn & mid_latchEn 
& mid_latchEn & mid_latchEn & mid_latchEn) and ('0' & mid_outp(8) & mid_outp(7) & mid_outp(6) & mid_outp(5) & mid_outp(4) & mid_outp(3) & mid_outp(2) & mid_outp(1))) or
((i_clr & i_clr & i_clr & i_clr & i_clr & i_clr & i_clr & i_clr & i_clr) and "000000000");

dff8: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_resetNot,
			i_d			=> 	mid_inp(8),
			i_enable	=> mid_latchEn,
			i_clock		=> i_clk,
			o_q 		=> mid_outp(8)
			);
dff7: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_resetNot,
			i_d			=> 	mid_inp(7),
			i_enable	=> mid_latchEn,
			i_clock		=> i_clk,
			o_q 		=> mid_outp(7)
			);
dff6: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_resetNot,
			i_d			=> 	mid_inp(6),
			i_enable	=> mid_latchEn,
			i_clock		=> i_clk,
			o_q 		=> mid_outp(6)
			);
dff5: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_resetNot,
			i_d			=> 	mid_inp(5),
			i_enable	=> mid_latchEn,
			i_clock		=> i_clk,
			o_q 		=> mid_outp(5)
			);
dff4: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_resetNot,
			i_d			=> 	mid_inp(4),
			i_enable	=> mid_latchEn,
			i_clock		=> i_clk,
			o_q 		=> mid_outp(4)
			);
dff3: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_resetNot,
			i_d			=> 	mid_inp(3),
			i_enable	=> mid_latchEn,
			i_clock		=> i_clk,
			o_q 		=> mid_outp(3)
			);		
dff2: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_resetNot,
			i_d			=> 	mid_inp(2),
			i_enable	=> mid_latchEn,
			i_clock		=> i_clk,
			o_q 		=> mid_outp(2)
			);
dff1: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_resetNot,
			i_d			=> 	mid_inp(1),
			i_enable	=> mid_latchEn,
			i_clock		=> i_clk,
			o_q 		=> mid_outp(1)
			);
dff0: enARdFF_2 
	port map			
			(
			i_resetBar	=> i_resetNot,
			i_d			=> 	mid_inp(0),
			i_enable	=> mid_latchEn,
			i_clock		=> i_clk,
			o_q 		=> mid_outp(0)
			);
	out_enable <= mid_latchEn;
	o_shiftedStream <= mid_inp;
end structural;
