LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity shiftregister_8bit is port(
	i_bs : in std_logic;
	i_load, i_resetBar : in std_logic;
	i_clk : in std_logic;
	o_bs : out std_logic_vector(7 downto 0)
	);
end;

architecture structural of shiftregister_8bit is 
	--defining basic components : (dFF):
	component enARdFF_2 is port(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC);
	end component;
	
	signal b0, b1, b2, b3, b4, b5, b6, b7 : std_logic;
	signal nb0, nb1, nb2, nb3, nb4, nb5, nb6, nb7 : std_logic;
BEGIN
bit_7 : enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => i_bs, 
			  i_enable => i_load,
			  i_clock => i_clk,
			  o_q => b7,
	        o_qBar => nb7);
			  
bit_6 : enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => b7, 
			  i_enable => i_load,
			  i_clock => i_clk,
			  o_q => b6,
	        o_qBar => nb6);	
			  
bit_5 : enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => b6, 
			  i_enable => i_load,
			  i_clock => i_clk,
			  o_q => b5,
	        o_qBar => nb5);

bit_4 : enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => b5, 
			  i_enable => i_load,
			  i_clock => i_clk,
			  o_q => b4,
	          o_qBar => nb4);
			  
bit_3 : enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => b4, 
			  i_enable => i_load,
			  i_clock => i_clk,
			  o_q => b3,
	        o_qBar => nb3);
			  
bit_2 : enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => b3, 
			  i_enable => i_load,
			  i_clock => i_clk,
			  o_q => b2,
	        o_qBar => nb2);

bit_1 : enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => b2, 
			  i_enable => i_load,
			  i_clock => i_clk,
			  o_q => b1,
	        o_qBar => nb1);

bit_0 : enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => b1, 
			  i_enable => i_load,
			  i_clock => i_clk,
			  o_q => b0,
	        o_qBar => nb0);

	o_bs(0) <= nb0;
	o_bs(1) <= nb1;
	o_bs(2) <= nb2;
	o_bs(3) <= nb3;
	o_bs(4) <= nb4;
	o_bs(5) <= nb5;
	o_bs(6) <= nb6;
	o_bs(7) <= nb7;
	
	
end structural;
