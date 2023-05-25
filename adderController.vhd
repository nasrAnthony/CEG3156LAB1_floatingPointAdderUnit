library ieee;
use ieee.std_logic_1164.all;

entity adderController is 
	port 
		(
			i_global_clk, i_global_rst : in std_logic;
			i_sign, i_notLess9, i_zero, i_coutFz : in std_logic;
			o_load1, o_load2, o_load3, o_load4  : out std_logic; --o_loadMaS/MbS correspond to the load signal into the 9 bit shift reg. 
			o_load5, o_load7, o_load6, o_cin : out std_logic;
			o_on22, o_on21, o_flag0, o_flag1 : out std_logic;
			o_clear4, o_clear3, o_shiftR4, o_shiftR3 : out std_logic;
			o_countD6, o_countU7, o_shiftR5, o_finish : out std_logic;		
			stateVector  : out std_logic_vector(0 to 9)
		);
end adderController;


architecture structural of adderController is
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
temp_stateinput(2) <= i_sign and temp_state(1);
temp_stateinput(3) <= temp_state(1) and i_notLess9 and not(i_sign);
temp_stateinput(4) <= (not(i_zero) and temp_state(4)) or (temp_state(1) and not(i_sign) and not(i_notLess9) and not(i_zero));
temp_stateinput(5) <= i_notLess9 and temp_state(2);
temp_stateinput(6) <= (temp_state(6) and not(i_zero)) or (temp_state(2) and not(i_notLess9) and not(i_zero));
temp_stateinput(7) <= temp_state(3) or (temp_state(4) and i_zero) or (temp_state(2) and not(i_notLess9 and i_zero)) or (temp_state(1) and not(i_sign) and not(i_notLess9) and i_zero);
temp_stateinput(8) <= temp_state(7) and i_coutFz;
temp_stateinput(9) <= (temp_state(7) and not(i_coutFz)) or temp_state(8);

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
	o_load1 <= temp_state(0);
	o_load2 <= temp_state(0);
	o_load3 <= temp_state(0);
	o_load4 <= temp_state(0);
	o_cin <= temp_state(1) or temp_state(2);
	o_load7 <= temp_state(1) or temp_state(2);
	o_on21 <= temp_state(1);
	o_flag1 <= temp_state(1);
	o_on22 <= temp_state(2);
	o_flag0 <= temp_state(2);
	o_clear3 <= temp_state(3);
	o_shiftR4 <= temp_state(4);
	o_countD6 <= temp_state(4) or temp_state(6);
	o_clear4 <= temp_state(5);
	o_shiftR3 <= temp_state(6);
	o_load5 <= temp_state(7);
	o_load6 <= temp_state(7);
	o_shiftR5 <= temp_state(8);
	o_countU7 <= temp_state(8); 
	o_finish <= temp_state(9);
				
end architecture;
