library ieee;
use ieee.std_logic_1164.all;


entity sub7bitUnit is port 
				(
					i_A, i_B : in std_logic_vector(6 downto 0);
					o_out : out std_logic_vector(6 downto 0)
				);

end sub7bitUnit;

architecture structural of sub7bitUnit is 
signal mid_B : std_logic_vector(6 DOWNTO 0);
signal mid_CARRY : std_logic;


component fullAdder7bit is 
	port 
		(
			i_A : in std_logic_vector(6 downto 0);
			i_B : in std_logic_vector(6 downto 0);
			i_Carry : in std_logic;
			o_Sum : out std_logic_vector(6 downto 0)
		);
		
end component; 

begin 
	mid_B(0) <= '1' XOR i_B(0);
	mid_B(1) <= '1' XOR i_B(1);
	mid_B(2) <= '1' XOR i_B(2);
	mid_B(3) <= '1' XOR i_B(3);
	mid_B(4) <= '1' XOR i_B(4);
	mid_B(5) <= '1' XOR i_B(5);
	mid_B(6) <= '1' XOR i_B(6);
	
	
instance_adder7bit  : fullAdder7bit  
	port map
		(
			i_A => i_A, 
			i_B => mid_B, 
			i_Carry => '1', 
			o_Sum => o_out
		);
end structural;

	
