library ieee; 
use ieee.std_logic_1164.all;

entity mux7bit2x1 is 
	port 
		( 
			i_X, i_Y : in std_logic_vector(6 downto 0);
			sel : in std_logic;
			output : out std_logic_vector(6 downto 0)
		);
end mux7bit2x1;


architecture RTL of mux7bit2x1 is 
begin  
with sel select	
	output <= i_X when '0', 
			  i_Y when '1', 
			  "0000000" when others;
end RTL;
	