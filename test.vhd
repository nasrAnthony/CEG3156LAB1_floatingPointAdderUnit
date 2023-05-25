library ieee;

use ieee.std_logic_1164.all;

entity test is 
	port 
		(
		i_in : in std_logic_vector(3 downto 0);
		o_out :  out std_logic_vector(3 downto 0)
		);
end test;

architecture struct of test is 
begin
o_out <= i_in;
end struct;