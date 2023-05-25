library ieee;
use ieee.std_logic_1164.all;


entity multiplier9bitUnit is 
	port 
		(
			in_A : in std_logic_vector(8 downto 0);
			in_B : in std_logic_vector(8 downto 0);
			o_genCarry : out std_logic;
			o_res : out std_logic_vector(8 downto 0)
		);
end entity;

architecture struct of multiplier9bitUnit is 
signal int_carry : std_logic_vector(7 downto 0);
signal int_b0, int_b1, int_b2, int_b3, int_b4, int_b5, int_b6, int_b7 : std_logic_vector(8 downto 0);
signal int_res0, int_res1, int_res2, int_res3, int_res4, int_res5, int_res6, int_res7 : std_logic_vector(8 downto 0);
signal int_a0, int_a1, int_a2, int_a3, int_a4, int_a5, int_a6, int_a7 : std_logic_vector(8 downto 0);
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
begin
--pp1 : 
int_b0 <= (in_B(1) & in_B(1) & in_B(1) & in_B(1) & in_B(1) & in_B(1) & in_B(1) & in_B(1) & in_B(1)) and in_A;
int_a0 <= (in_A(8 downto 1) & '0') and (in_B(0) & in_B(0) & in_B(0) & in_B(0) & in_B(0) & in_B(0) & in_B(0) & in_B(0) & in_B(0));

fa9bitUNIT0 : fullAdder9bit_MULT 
	port 
		map	
			(
				i_A => int_a0, 
				i_B => int_b0, 
				i_Carry => '0',
				o_Carry => int_carry(0), 
				o_Sum => int_res0
			);
--pp2 : 
int_b1 <= (in_B(2) & in_B(2) & in_B(2) & in_B(2) & in_B(2) & in_B(2) & in_B(2) & in_B(2) & in_B(2)) and in_A;
int_a1 <= int_carry(0) & int_res0(8 downto 1);

fa9bitUNIT1 : fullAdder9bit_MULT 
	port 
		map	
			(
				i_A => int_a1, 
				i_B => int_b1, 
				i_Carry => '0',
				o_Carry => int_carry(1), 
				o_Sum => int_res1
			);
--pp3 : 
int_b2 <= (in_B(3) & in_B(3) & in_B(3) & in_B(3) & in_B(3) & in_B(3) & in_B(3) & in_B(3) & in_B(3)) and in_A;
int_a2 <= int_carry(1) & int_res1(8 downto 1);

fa9bitUNIT2 : fullAdder9bit_MULT 
	port 
		map	
			(
				i_A => int_a2, 
				i_B => int_b2, 
				i_Carry => '0',
				o_Carry => int_carry(2), 
				o_Sum => int_res2
			);
--pp4 : 
int_b3 <= (in_B(4) & in_B(4) & in_B(4) & in_B(4) & in_B(4) & in_B(4) & in_B(4) & in_B(4) & in_B(4)) and in_A;
int_a3 <= int_carry(2) & int_res2(8 downto 1);

fa9bitUNIT3 : fullAdder9bit_MULT 
	port 
		map	
			(
				i_A => int_a3, 
				i_B => int_b3, 
				i_Carry => '0',
				o_Carry => int_carry(3), 
				o_Sum => int_res3
			);
--pp5 : 
int_b4 <= (in_B(5) & in_B(5) & in_B(5) & in_B(5) & in_B(5) & in_B(5) & in_B(5) & in_B(5) & in_B(5)) and in_A;
int_a4 <= int_carry(3) & int_res3(8 downto 1);

fa9bitUNIT4 : fullAdder9bit_MULT 
	port 
		map	
			(
				i_A => int_a4, 
				i_B => int_b4, 
				i_Carry => '0',
				o_Carry => int_carry(4), 
				o_Sum => int_res4
			);
--pp6 : 
int_b5 <= (in_B(6) & in_B(6) & in_B(6) & in_B(6) & in_B(6) & in_B(6) & in_B(6) & in_B(6) & in_B(6)) and in_A;
int_a5 <= int_carry(4) & int_res4(8 downto 1);

fa9bitUNIT5 : fullAdder9bit_MULT 
	port 
		map	
			(
				i_A => int_a5, 
				i_B => int_b5, 
				i_Carry => '0',
				o_Carry => int_carry(5), 
				o_Sum => int_res5
			);
--pp7 : 
int_b6 <= (in_B(7) & in_B(7) & in_B(7) & in_B(7) & in_B(7) & in_B(7) & in_B(7) & in_B(7) & in_B(7)) and in_A;
int_a6 <= int_carry(5) & int_res5(8 downto 1);

fa9bitUNIT6 : fullAdder9bit_MULT 
	port 
		map	
			(
				i_A => int_a6, 
				i_B => int_b6, 
				i_Carry => '0',
				o_Carry => int_carry(6), 
				o_Sum => int_res6
			);
--pp8 : 
int_b7 <= (in_B(8) & in_B(8) & in_B(8) & in_B(8) & in_B(8) & in_B(8) & in_B(8) & in_B(8) & in_B(8)) and in_A;
int_a7 <= int_carry(6) & int_res6(8 downto 1);

fa9bitUNIT7 : fullAdder9bit_MULT 
	port 
		map	
			(
				i_A => int_a7, 
				i_B => int_b7, 
				i_Carry => '0',
				o_Carry => int_carry(7), 
				o_Sum => int_res7
			);
	o_res <= int_res7;	
	o_genCarry <= int_carry(7);
end struct;