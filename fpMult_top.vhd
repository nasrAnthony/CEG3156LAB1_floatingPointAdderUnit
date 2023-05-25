library ieee;
use ieee.std_logic_1164.all;

entity fpMult_top is 
	port 
		(
			glob_clk : in std_logic;
			glob_reset : in std_logic;
			signA : in std_logic;
			signB : in std_logic;
			mA : in std_logic_vector(7 downto 0);
			mB : in std_logic_vector(7 downto 0);
			eA : in std_logic_vector(6 downto 0);
			eB : in std_logic_vector(6 downto 0);
			overFlowFlag : out std_logic;
			signRes : out std_logic;
			eRes : out std_logic_vector(6 downto 0);
			mRes : out std_logic_vector(7 downto 0);
			state : out std_logic_vector(0 to 3);
			test, adder_out: out std_logic_vector(8 downto 0)
		
		);
end entity;
architecture struct of fpMult_top is 

component fullAdder9bit_MULT is
	port 
		(
			i_A : in std_logic_vector(8 downto 0);
			i_B : in std_logic_vector(8 downto 0);
			i_Carry : in std_logic;
			o_Carry: out std_logic;
			o_Sum : out std_logic_vector(8 downto 0)
		);
end component; 

component interfaceReg7bit is port 
	( 
		i_clk : in std_logic;
		i_en : in std_logic;
		i_bitStream : in std_logic_vector(6 downto 0);
		i_clearBar : in std_logic;
		o_bitStream : out std_logic_vector(6 downto 0)
	);
end component;

component shiftReg9bit is 
	port 
		(
			i_clk, i_clr,  i_resetNot, i_load, i_enShift : in std_logic;
			i_bitStream : in std_logic_vector(8 downto 0);
			o_shiftedStream : out std_logic_vector(8 downto 0)
		);
end component;

component multiplier9bitUnit is 
	port 
		(
			in_A : in std_logic_vector(8 downto 0);
			in_B : in std_logic_vector(8 downto 0);
			o_genCarry : out std_logic;
			o_res : out std_logic_vector(8 downto 0)
		);
end component;

component fullAdder8bit_MULT is port(
	i_A : in std_logic_vector(7 downto 0);
	i_B : in std_logic_vector(7 downto 0);
	i_Carry : in std_logic;
	o_Sign, o_Carry: out std_logic;
	o_Sum : out std_logic_vector(7 downto 0)
	);
		
end component;

component upCounter7bit -- 7 bit up counter unit
	port 	
		(
			i_resetNot : in std_logic;
			i_load : in std_logic;
			i_countUP : in std_logic;
			i_clk : in std_logic;
			i_input : in std_logic_vector(6 downto 0);
			o_output : out std_logic_vector(6 downto 0)
		);
end component;
component multControlUnit  is 
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
end component;
signal mid_resCarryOut : std_logic;
signal mid_loadMA, mid_loadMB, mid_loadEA, mid_loadEB, mid_loadMRES, mid_loadERES: std_logic;
signal assert_countUP, mid_assertShiftRES : std_logic;
signal mid_finish : std_logic;
signal mid_stateVector : std_logic_vector(0 to 3);
--control signals done 
signal mid_elongEA, mid_elongEB : std_logic_vector(7 downto 0);
signal mid_expSign : std_logic;
signal mid_mA, mid_mB, mid_mRes, mid_fMA, mid_fMB, mid_fMRes: std_logic_vector(8 downto 0);
signal mid_eA, mid_eB, mid_eRes: std_logic_vector(6 downto 0);
signal mid_sumEXP : std_logic_vector(8 downto 0);
signal mid_sumEXPunb : std_logic_vector(7 downto 0);
signal mid_sumEXPsignedunb : std_logic_vector(8 downto 0);

begin
--padding
mid_sumEXPsignedunb <= '0' & mid_sumEXPunb;
mid_elongEA <= '0' & mid_eA;
mid_elongEB <= '0' & mid_eB;
mid_mA <= '1' & mA;
mid_mB <= '1' & mB;
FSM_CONTROLLER : multControlUnit 
	port 
		map 
			(
				i_clk => glob_clk,
				i_resetNot => glob_reset,
				i_resCarryOut => mid_resCarryOut,  
				o_loadExpA => mid_loadEA, 
				o_loadExpB => mid_loadEB,
				o_loadExpRes => mid_loadERES,
				o_loadManA => mid_loadMA, 
				o_loadManB => mid_loadMB, 
				o_loadManRes => mid_loadMRES, 
				o_assertCountUp => assert_countUP, 
				o_shiftManRes => mid_assertShiftRES, 
				o_stateVector => mid_stateVector, 
				o_finish => mid_finish
			);
		
eAcontainer : interfaceReg7bit
	port 
		map 
			(
				i_clk => glob_clk, 
				i_clearBar => glob_reset, 
				i_en => mid_loadEA, 
				i_bitStream => eA, 
				o_bitStream => mid_eA
				
			);
eBcontainer : interfaceReg7bit
	port 
		map 
			(
				i_clk => glob_clk, 
				i_clearBar => glob_reset, 
				i_en => mid_loadEB, 
				i_bitStream => eB, 
				o_bitStream => mid_eB
			);
exp_sum_unit : fullAdder8bit_MULT
	port 
		map 
			(
				i_A => mid_elongEA, 
				i_B => mid_elongEB, 
				i_Carry => '0',
				o_Sum => mid_sumEXPunb
			);
			
excess_sub : fullAdder9bit_MULT -- this will subtract 63 from the exponent, hence respecting hte excess 63 format. 
	port 
		map 
			(
				i_A => mid_sumEXPsignedunb, 
				i_B => "111000000", --represents -63, as the i_carry is set hence creating the 2's complement. 
				i_Carry => '1',
				o_Carry => open, 
				o_Sum => mid_sumEXP
			);
counter : upCounter7bit 
	port 
		map 
			(
				i_resetNot => glob_reset,
				i_load => mid_loadERES,
				i_countUP => assert_countUP, 
				i_clk => glob_clk, 
				i_input => mid_sumEXP(6 downto 0), 
				o_output => mid_eRes
			);
		
shift_mantissaA : shiftReg9bit  
	port
		map 
			(
				i_clk => glob_clk, 
				i_clr => '0', 
				i_load => mid_loadMA,
				i_enShift => '0', 
				i_resetNot => glob_reset, 
				i_bitStream => mid_mA, 
				o_shiftedStream => mid_fMA
				
			);
shift_mantissaB : shiftReg9bit 
	port 
		map 
			(
				i_clk => glob_clk, 
				i_clr => '0', 
				i_load => mid_loadMB,
				i_enShift => '0', 
				i_resetNot => glob_reset, 
				i_bitStream => mid_mB, 
				o_shiftedStream => mid_fMB
			);
multip9bit :  multiplier9bitUnit 
	port 
		map 
			(
				in_A => mid_fMA, 
				in_B => mid_fMB, 
				o_genCarry => mid_resCarryOut, 
				o_res => mid_mRes
			);
			
shift_mantissaRes : shiftReg9bit 
	port 
		map 
			(
				i_clk => glob_clk, 
				i_clr => '0', 
				i_load => mid_loadMRES,
				i_enShift => '0', 
				i_resetNot => glob_reset, 
				i_bitStream => mid_mRes, 
				o_shiftedStream => mid_fMRes
			);
eRes <= mid_eRes;
mRes <= mid_fMRes(7 downto 0);
signRes <= signB xor signA;
overFlowFlag <= (mid_stateVector(3) or mid_stateVector(2)) and (mid_sumEXP(7) or mid_sumEXP(8));
state <= mid_stateVector;
test <= mid_sumEXPsignedunb;
adder_out <=mid_sumEXP;
			

end struct;