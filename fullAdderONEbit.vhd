library ieee;
use ieee.std_logic_1164.ALL;

entity fullAdderONEbit is port(
	i_a, i_b, i_c : in std_logic;
	o_sum, o_c : out std_logic
	);
	
end fullAdderONEbit;
architecture structural of fullAdderONEbit is 
signal temp_s, temp_c : std_logic;

begin 
-- STANDARD formulas for output generation.
temp_s <= (i_a XOR i_b) XOR i_c;
temp_c <= (i_a and i_b) or (i_a  and i_c) or (i_b and i_c);

-- DRIVING THE OUTPUT.
o_sum <= temp_s;
o_c <= temp_c;

end structural;