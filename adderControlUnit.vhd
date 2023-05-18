library ieee;
use ieee.std_logic_1164.all;

entity adderControlUnit is 
	port 
		(
			i_global_clk, i_global_rst : in std_logic;
			signFlag, less9flag, zeroFlag, i_carryFlag : in std_logic;
			o_loadEa, o_loadEb, o_loadMaS, o_loadMbS  : out std_logic; -- o_loadMaS/MbS correspond to the load signal into the 9 bit shift reg. 
			o_loadMr, o_loadEr, o_loadCounter6, o_carryFlag : out std_logic;
			o_complA22, o_complB21, o_bflag, o_aflag : out std_logic;
			o_clearA, o_clearB, o_shiftB, o_shiftA : out std_logic;
			o_countDown1, o_countUp1, o_shiftRes, o_finish : out std_logic;		
			stateVector  : out std_logic_vector(0 to 9)
		);
end adderControlUnit;


architecture structural of adderControlUnit is
component enARdFF_2
	port	
		(
			i_resetBar	:  in std_logic;
			i_d		:  in std_logic;
			i_enable	: in std_logic;
			i_clock		:  in std_logic;
			o_q, o_qBar	:  out std_logic
		);
end component;
component reg1bit 
	port(
			i_resetBar	: in std_logic;
			i_d		:  in std_logic;
			i_enable	: in std_logic;
			i_clock		:  in std_logic;
			o_q, o_qBar	:  out std_logic
		);
end component;
--signal declaration:
signal temp_state, temp_stateinput : std_logic_vector(0 to 9);
begin 
--state equation inputs:
temp_stateinput(0) <= '0'; --State S0 input
temp_stateinput(1) <= temp_state(0);
temp_stateinput(2) <= signFlag and temp_state(1);
temp_stateinput(3) <= temp_state(1) and less9flag and not(signFlag);
temp_stateinput(4) <= (not(zeroFlag) and temp_state(4)) or (temp_state(1) and not(signFlag) and not(less9flag) and not(zeroFlag));
temp_stateinput(5) <= less9flag and temp_state(2);
temp_stateinput(6) <= (temp_state(6) and not(zeroFlag)) or (temp_state(2) and not(less9flag) and not(zeroFlag));
temp_stateinput(7) <= temp_state(3) or (temp_state(4) and zeroFlag) or (temp_state(2) and not(less9flag and zeroFlag)) or (temp_state(1) and not(signFlag) and not(less9flag) and zeroFlag);
temp_stateinput(8) <= temp_state(7) and i_carryFlag;
temp_stateinput(9) <= (temp_state(7) and not(i_carryFlag)) or temp_state(8);

--instantiating the dFFs for each state. 
state0: reg1bit 
		port map
				(
					i_resetBar =>  i_global_rst,
					i_d => temp_stateinput(0),
					i_enable => '1', 
					i_clock => i_global_clk, 
					o_q => temp_state(0)
				);
				
state1: enARdFF_2 
		port map
				(
					i_resetBar =>  i_global_rst,
					i_d => temp_stateinput(1),
					i_enable => '1', 
					i_clock => i_global_clk, 
					o_q => temp_state(1)
				);
state2: enARdFF_2 
		port map
				(
					i_resetBar =>  i_global_rst,
					i_d => temp_stateinput(2),
					i_enable => '1', 
					i_clock => i_global_clk, 
					o_q => temp_state(2)
				);
state3: enARdFF_2 
		port map
				(
					i_resetBar =>  i_global_rst,
					i_d => temp_stateinput(3),
					i_enable => '1', 
					i_clock => i_global_clk, 
					o_q => temp_state(3)
				);
state4: enARdFF_2 
		port map
				(
					i_resetBar =>  i_global_rst,
					i_d => temp_stateinput(4),
					i_enable => '1', 
					i_clock => i_global_clk, 
					o_q => temp_state(4)
				);
state5: enARdFF_2 
		port map
				(
					i_resetBar =>  i_global_rst,
					i_d => temp_stateinput(5),
					i_enable => '1', 
					i_clock => i_global_clk, 
					o_q => temp_state(5)
				);
state6: enARdFF_2 
		port map
				(
					i_resetBar =>  i_global_rst,
					i_d => temp_stateinput(6),
					i_enable => '1', 
					i_clock => i_global_clk, 
					o_q => temp_state(6)
				);
state7: enARdFF_2 
		port map
				(
					i_resetBar =>  i_global_rst,
					i_d => temp_stateinput(7),
					i_enable => '1', 
					i_clock => i_global_clk, 
					o_q => temp_state(7)
				);
state8: enARdFF_2 
		port map
				(
					i_resetBar =>  i_global_rst,
					i_d => temp_stateinput(8),
					i_enable => '1', 
					i_clock => i_global_clk, 
					o_q => temp_state(8)
				);
state9: enARdFF_2 
		port map
				(
					i_resetBar =>  i_global_rst,
					i_d => temp_stateinput(9),
					i_enable => '1', 
					i_clock => i_global_clk, 
					o_q => temp_state(9)
				);
--driving the outputs and the control signals:
	stateVector <= temp_state;
	o_loadEa <= temp_state(0);
	o_loadEb <= temp_state(0);
	o_loadMaS <= temp_state(0);
	o_loadMbS <= temp_state(0);
	o_carryFlag <= temp_state(1) or temp_state(2);
	o_loadCounter6 <= temp_state(1) or temp_state(2);
	o_complB21 <= temp_state(1);
	o_aflag <= temp_state(1);
	o_complA22 <= temp_state(2);
	o_bflag <= temp_state(2);
	o_clearB <= temp_state(3);
	o_shiftB <= temp_state(4);
	o_countDown1 <= temp_state(4) or temp_state(6);
	o_clearA <= temp_state(5);
	o_shiftA <= temp_state(6);
	o_loadMr <= temp_state(7);
	o_loadEr <= temp_state(7);
	o_shiftRes <= temp_state(8);
	o_countUp1 <= temp_state(8); 
	o_finish <= temp_state(9);
				
end architecture;
