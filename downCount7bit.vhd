library ieee;
use ieee.std_logic_1164.all;

entity downCount7bit is 
	port (
			in_bits : in std_logic_vector(6 downto 0);
			in_count_down : in std_logic;
			i_clk : in std_logic;
			i_en :  in std_logic;
			i_resetNot : in std_logic;
			out_bits : out std_logic_vector(6 downto 0);
			zero_flag : out std_logic;
			out_temp :  out std_logic_vector(6 downto 0);
			out_test  : out std_logic
	);
	
end entity ;


architecture structural of downCount7bit is 

signal mid_inBits : std_logic_vector(6 downto 0);
signal mid_outBits : std_logic_vector(6 downto 0);
signal mid_temp : std_logic_vector(6 downto 0);
signal mid_d : std_logic_vector(6 downto 0);

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
component sub7bitUnit is 
	port 
		(
			i_A, i_B : in std_logic_vector(6 downto 0);
			o_out : out std_logic_vector(6 downto 0)
		);
end component;

component mux7bit2x1 is 
	port 
		(
			i_X, i_Y : in std_logic_vector(6 downto 0);
			sel : in std_logic;
			output : out std_logic_vector(6 downto 0)
		);
end component;

begin
mid_inBits <= in_bits;

decrementer_instance : sub7bitUnit
	port 
		map (
				i_A => mid_outBits,
				i_B => "0000001", 
				o_out => mid_temp
				
		);
		
muxSelect: mux7bit2x1 
	port 
		map 
			( 
				i_X => mid_temp, 
				i_Y => mid_inBits,
				sel => in_count_down, 
				output => mid_d
			);

bit0: enARdFF_2 
	port 
		map 
			( 
				i_resetBar	=> i_resetNot,
				i_d =>  mid_d(0) , 
				i_enable => i_en, 
				i_clock	=> i_clk, 
				o_q => mid_outBits(0)
			);
bit1: enARdFF_2 
	port 
		map 
			( 
				i_resetBar	=> i_resetNot,
				i_d =>  mid_d(1) , 
				i_enable => i_en, 
				i_clock	=> i_clk, 
				o_q => mid_outBits(1)
			);
bit2: enARdFF_2 
	port 
		map 
			( 
				i_resetBar	=> i_resetNot,
				i_d =>  mid_d(2) , 
				i_enable => i_en, 
				i_clock	=> i_clk, 
				o_q => mid_outBits(2)
			);
bit3: enARdFF_2 
	port 
		map 
			( 
				i_resetBar	=> i_resetNot,
				i_d =>  mid_d(3) , 
				i_enable => i_en, 
				i_clock	=> i_clk, 
				o_q => mid_outBits(3)
			);
bit4: enARdFF_2 
	port 
		map 
			( 
				i_resetBar	=> i_resetNot,
				i_d =>  mid_d(4) , 
				i_enable => i_en, 
				i_clock	=> i_clk, 
				o_q => mid_outBits(4)
			);
bit5: enARdFF_2 
	port 
		map 
			( 
				i_resetBar	=> i_resetNot,
				i_d =>  mid_d(5), 
				i_enable => i_en, 
				i_clock	=> i_clk, 
				o_q => mid_outBits(5)
			);
bit6: enARdFF_2 
	port 
		map 
			( 
				i_resetBar	=> i_resetNot,
				i_d =>  mid_d(6), 
				i_enable => i_en, 
				i_clock	=> i_clk, 
				o_q => mid_outBits(6)
			);
	out_bits <= mid_outBits;
	zero_flag <= '1' when (mid_outBits = "0000000") else '0';
	out_temp <= mid_temp;
	out_test <= '1';

end structural;

