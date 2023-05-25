library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity testDownCounter is port 
	(
		i_clk : in std_logic;
		i_countDown : in std_logic;
		i_in  : in std_logic_vector(6 downto 0);
		load_en : in std_logic;
		o_out : out std_logic_vector(6 downto 0)
	);
	
end entity;

architecture struct of testDownCounter is 
signal temp : std_logic_vector(6 downto 0);
signal count : std_logic;
begin
process(i_clk, i_countDown, load_en, count)
begin
if(rising_edge(i_clk) and (i_countDown = '1'))then
	if(load_en = '1')then 
		temp <= i_in;
		count <= '1';
	else
		temp <= temp - 1;
	end if;
end if;
end process;
o_out <= temp;
end struct;


