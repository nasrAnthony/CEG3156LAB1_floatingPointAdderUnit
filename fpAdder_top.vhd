library ieee;
use ieee.std_logic_1164.all;

entity fpAdder_top is 
	port
		(
			glob_clk, glob_reset, signA, signB : in std_logic;
			mA, mB : in std_logic_vector(7 downto 0);
			eA, eB : in std_logic_vector(6 downto 0);
			signRes, exceptionOverflow : out std_logic;
			mRes : out std_logic_vector(7 downto 0);
			eRes : out std_logic_vector(6 downto 0)
		);
end fpAdder_top;

architecture structural of fpAdder_top is 
--Defining all the components of the fpAdder

component adderControlUnit --Control unit for the top lvl fpAdder
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
end component;

component srlatch --sr latch 
	port	
		( 
			i_set, i_reset		: IN	STD_LOGIC;
			o_q, o_qBar		: OUT	STD_LOGIC
		);
end component;
component complementer8Bit --8 bit complementer unit
	port 
		( 
			i_en : in std_logic;
			i_in : in std_logic_vector(7 downto 0);
			o_out : out std_logic_vector(7 downto 0)
		);
end component;

component fullAdder8bit --8 bit FA unit
	port 
		( 
			i_A : in std_logic_vector(7 downto 0);
			i_B : in std_logic_vector(7 downto 0);
			i_Carry : in std_logic;
			o_Sign, o_Carry: out std_logic;
			o_Sum : out std_logic_vector(6 downto 0)
		);
end component;

component mux7bit2x1 --7 bit 2 by 1 Mux7bit2x1
	port	
		( 
			i_X, i_Y : in std_logic_vector(6 downto 0);
			sel : in std_logic;
			output : out std_logic_vector(6 downto 0)
		);
end component;

component fullAdder9bit -- 9 bit FA unit
	port 
		(
			i_clk, i_rstnot : in std_logic;
			i_A : in std_logic_vector(8 downto 0);
			i_B : in std_logic_vector(8 downto 0);
			i_Carry : in std_logic;
			o_Carry: out std_logic;
			o_Sum : out std_logic_vector(8 downto 0)
		);
end component;

component reg7bit --7 bit register unit
	port	
		(
			i_rstG, i_clk, i_load : in std_logic;
			i_inBits : in std_logic_vector(6 downto 0);
			o_outBits : out std_logic_vector(6 downto 0)
		);
end component;

component fullAdder7bit -- 7 bit FA unit
	port 	
		(
			i_A : in std_logic_vector(6 downto 0);
			i_B : in std_logic_vector(6 downto 0);
			i_Carry : in std_logic;
			o_Sum : out std_logic_vector(6 downto 0)
		);
end component;

component comparator7bit --7 bit comparator unit
	port
		(
			ein1, ein2 : in std_logic_vector(6 downto 0);
			o_GT, o_LT, o_EQ : out std_logic
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

component downCounter7bit -- 7 bit down counter unit
	port 	
		(
			i_resetNot : in std_logic;
			i_load : in std_logic;
			i_countDOWN : in std_logic;
			i_clk : in std_logic;
			i_input : in std_logic_vector(6 downto 0);
			o_output : out std_logic_vector(6 downto 0);
			zeroFlag : out std_logic
		);
end component;

component shiftReg9bit -- 9 bit shift register unit
	port 	
		(
			i_clk, i_clr,  i_resetNot, i_load, i_enShift : in std_logic;
			i_bitStream : in std_logic_vector(8 downto 0);
			o_shiftedStream : out std_logic_vector(8 downto 0)
		);
end component;

-- inner signal declarations section:
signal state_vector : std_logic_vector(0 to 9);
signal temp_less9Flag, temp_zeroFlag, temp_carryOut, temp_signFlag, temp_finish: std_logic;--control status signals
signal temp_loadMa, temp_loadMb, temp_loadEa, temp_loadEb, temp_loadMres, temp_loadEres: std_logic; --Asserted/set in state 0 and the state 7 for the load result M and E. 
signal temp_complB, temp_aflag : std_logic;--Asserted/set in state 1
signal temp_complA, temp_bflag, temp_inCarry, temp_loadEdiff: std_logic; --Asserted/set in state 2/1
signal temp_clearA, temp_clearB : std_logic; --Asserted in states 3 and 5 respectively. 
signal temp_shiftB, temp_shiftA, temp_shiftRes, temp_clearRes: std_logic; --Asserted in states 4, 6 and 8 respectively.
signal temp_assertCountDown, temp_assertCountUp : std_logic; --Asserted in states 4/6 and 8 respectively.

--DATA signals: t = "temporary"
signal tMa, tMb,tMres, tMsum, tMaShifted, tMbShifted, tMsumShifted: std_logic_vector(8 downto 0); --Mantissas and their sum
signal tEa, tEb, tEres, tEresFin, tExponentDiff: std_logic_vector(6 downto 0); -- Exponents and difference [Ea - Eb]
signal tAcomp, tBcomp, tEaComp, tEbcomp, tEacompIN, tEbcompIN: std_logic_vector(7 downto 0); -- complement of all values. 
signal tGreater, tLess, tEqual, tFlag: std_logic; -- logic signal for bool operators. 1 -> true, 0 -> False 
signal tEcomparator : std_logic_vector(6 downto 0);

--start of process:
begin
temp_less9Flag <= not(tEqual) and not(tLess) and tGreater;
tEacompIN <= '0' & tEa;
tEbcompIN <= '0' & tEb;
temp_signFlag <= '0' when (eB < eA) else '1';
tMa <= '1' & mA;
tMb <= '1' & mB;
temp_clearRes <= '0';
--Instance of controller:
topControlUnit : adderControlUnit
	port 
		map	
			(
				i_global_clk => glob_clk, 
				i_global_rst => glob_reset, 
				signFlag => temp_signFlag,
				less9flag => temp_less9Flag, 
				zeroFlag => temp_zeroFlag, 
				i_carryFlag => temp_carryOut, 
				o_loadEa => temp_loadEa, 
				o_loadEb => temp_loadEb, 
				o_loadMaS => temp_loadMa, 
				o_loadMbS => temp_loadMb, 
				o_loadMr => temp_loadMres, 
				o_loadEr => temp_loadEres, 
				o_loadCounter6 => temp_loadEdiff,
				o_carryFlag => temp_inCarry, 
				o_complA22 => temp_complA, 
				o_complB21 => temp_complB, 
				o_bflag => temp_bflag, 
				o_aflag => temp_aflag, 
				o_clearA => temp_clearA, 
				o_clearB => temp_clearB, 
				o_shiftA => temp_shiftA, 
				o_shiftB => temp_shiftB, 
				o_shiftRes => temp_shiftRes, 
				o_countDown1 => temp_assertCountDown, 
				o_countUp1 => temp_assertCountUp, 
				stateVector => state_vector,
				o_finish => temp_finish
			);
reg_ExpA : reg7bit --Exponent A reg. 
	port	
		map
			(
				i_clk => glob_clk, 
				i_rstG => glob_reset,
				i_load => temp_loadEa, 
				i_inBits => eA,
				o_outBits => tEa
			);
reg_ExpB : reg7bit --Exponent B reg. 
	port	
		map
			(
				i_clk => glob_clk, 
				i_rstG => glob_reset,
				i_load => temp_loadEb, 
				i_inBits => eA,
				o_outBits => tEb
			);
ExpAcomplement : complementer8Bit
	port 
		map	
			(
				i_en => temp_complA,
				i_in => tEacompIN, 
				o_out => tEacomp
			);
ExpBcomplement : complementer8Bit
	port 
		map	
			(
				i_en => temp_complB,
				i_in => tEbcompIN, 
				o_out => tEbcomp
			);
adderSubUnit : fullAdder8bit --by default performs Ea - Eb or Ea +[compl(Eb)]
	port	
		map
			(
				i_A => tEacomp, 
				i_B => tEbcomp,
				i_Carry => temp_inCarry,
				o_Sign => open,
				o_Sum => tExponentDiff
			);
DCounter7bit : downCounter7bit 
	port	
		map	
			(
				i_resetNot => glob_reset, 
				i_load => temp_loadEdiff,
				i_countDOWN => temp_assertCountDown, 
				i_clk => glob_clk,
				i_input => tExponentDiff, 
				o_output => tEcomparator, 
				zeroFlag => temp_zeroFlag
			);
UCounter7bit : upCounter7bit
	port 
		map	
			( 
				i_resetNot => glob_reset, 
				i_load => temp_loadEres,
				i_countUP => temp_assertCountUp, 
				i_clk => glob_clk,
				i_input => tEres, 
				o_output => tEresFin
				
			);

			
comparatorSevBits : comparator7bit
	port 
		map
			(
				ein1 => tEcomparator, 
				ein2 => "0001000", --compare to see if less than 8.
				o_GT => tGreater, 
				o_LT => tLess, 
				o_EQ => tEqual
			);
			
latch : srlatch
	port
		map
			(
				i_set => temp_aflag, 
				i_reset => temp_bflag,
				o_q  => tFlag
			);
muxEXP : mux7bit2x1
	port 
		map 
			(
				i_X => tEa, 
				i_Y => tEb,
				sel  => tFlag,
				output  => tEres 
			);
shiftRegisterMa : shiftReg9bit
	port
		map 
			(
				i_clk => glob_clk, 
				i_clr => temp_clearA,  
				i_resetNot =>glob_reset , 
				i_load => temp_loadMa, 
				i_enShift => temp_shiftA ,
				i_bitStream => tMa,
				o_shiftedStream => tMaShifted
			);
shiftRegisterMb : shiftReg9bit
		port
			map 
				(
					i_clk => glob_clk, 
					i_clr => temp_clearB,  
					i_resetNot =>glob_reset , 
					i_load => temp_loadMb, 
					i_enShift => temp_shiftB ,
					i_bitStream => tMb,
					o_shiftedStream => tMbShifted
				);
adder9bitMantissa: fullAdder9bit
	port
		map 
			( 
				i_clk => glob_clk,
				i_rstnot => glob_reset,
				i_A => tMaShifted,
				i_B => tMbShifted,
				i_Carry => '0' ,
				o_Carry => temp_CarryOut,
				o_Sum => tMsum
			);
			
shiftRegisterMres : shiftReg9bit -- Normalizer. 
		port
			map 
				(
					i_clk => glob_clk, 
					i_clr => temp_clearRes,  
					i_resetNot =>glob_reset , 
					i_load => temp_loadMres, 
					i_enShift => temp_shiftRes ,
					i_bitStream => tMsum,
					o_shiftedStream => tMsumShifted
				);
		signRes <= '1';
		exceptionOverflow <= '0';
		mRes <= tMsumShifted(7 downto 0);
		eRes <= tEresFin;

end structural;



