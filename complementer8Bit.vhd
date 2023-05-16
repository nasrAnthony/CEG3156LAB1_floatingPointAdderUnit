Library ieee;
use ieee.std_logic_1164.all;

entity complementer8Bit is port (
	i_en : in std_logic;
	i_in : in std_logic_vector(7 downto 0);
	o_out : out std_logic_vector(7 downto 0)
	);
	
end complementer8Bit;

architecture RTL of complementer8Bit is
signal mid : std_logic_vector(7 downto 0);
begin 	
	mid <= (i_en & i_en & i_en & i_en & i_en & i_en & i_en & i_en) XOR i_in;
	o_out <= mid;
	
end RTL;