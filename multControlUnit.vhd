library ieee;
use ieee.std_logic_1164.all;


entity multControlUnit  is 
	port 
		(
			i_clk : in std_logic;
			i_resetNot : in std_logic;
			i_resCarryOut  : in std_logic; -- coutFz
			o_loadExpA : out std_logic; --laodREx
			o_loadExpB : out std_logic; --laodRExy
			o_loadExpRes : out std_logic; --loadREz
			o_loadManA : out std_logic; --loadRFx
			o_loadManB : out std_logic; --loadRFy
			o_loadManRes : out std_logic; --loadRFz
			o_assertCountUp : out std_logic; --o_countUREz
			o_shiftManRes : out std_logic; --o_shiftRFz
			o_stateVector : out std_logic_vector(0 to 3);
			o_finish : out std_logic
		);
end entity;


architecture struct of multControlUnit is 
signal mid_stateVector : std_logic_vector(0 to 3);
signal mid_hold : std_logic_vector(0 to 3);
component enARdFF_2 port
	(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC
	);
end component;
component reg1bit port
	(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC
	);
end component;

begin 
mid_hold(3) <= mid_stateVector(3) or mid_stateVector(2) or (not(i_resCarryOut) and mid_stateVector(1));
mid_hold(2) <= i_resCarryOut and mid_stateVector(1);
mid_hold(1) <= mid_stateVector(0);
mid_hold(0) <= '0';
--State FFS instances:
state_0 : reg1bit 
	port 
		map 
			(
			i_resetBar => i_resetNot,
			i_d		=> mid_hold(0), 
			i_enable	=> '1',
			i_clock	=> i_clk,
			o_q => mid_stateVector(0)
			);
state_1 : enARdFF_2 
	port 
		map 
			(
			i_resetBar => i_resetNot,
			i_d		=> mid_hold(1), 
			i_enable	=> '1',
			i_clock	=> i_clk,
			o_q => mid_stateVector(1)
			);
state_2 : enARdFF_2 
	port 
		map 
			(
			i_resetBar => i_resetNot,
			i_d		=> mid_hold(2), 
			i_enable	=> '1',
			i_clock	=> i_clk,
			o_q => mid_stateVector(2)
			);
state_3 : enARdFF_2 
	port 
		map 
			(
			i_resetBar => i_resetNot,
			i_d		=> mid_hold(3), 
			i_enable	=> '1',
			i_clock	=> i_clk,
			o_q => mid_stateVector(3)
			);
o_stateVector <= mid_stateVector; 
o_assertCountUp <=  mid_stateVector(2);
o_shiftManRes <= mid_stateVector(2);
o_loadExpA <= mid_stateVector(0); 
o_loadExpB <= mid_stateVector(0); 
o_loadManA <= mid_stateVector(0); 
o_loadManB <= mid_stateVector(0); 
o_loadManRes <= mid_stateVector(1);
o_loadExpRes <= mid_stateVector(1);
o_finish <= mid_stateVector(3);


end struct;
