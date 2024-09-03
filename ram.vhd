library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;
use work.code_package.all;

entity ram is

	port
	(	CLK, WR, RD : in std_logic;
		A : in std_logic_vector(7 downto 0);
		D : inout std_logic_vector(7 downto 0));
		
end entity;

architecture behavioral of ram is
signal ram_array : ram_type := code4;

begin
	process(CLK)
	begin
		if rising_edge(CLK) then
			if WR='1' then
				ram_array(conv_integer(A)) <= D;
			end if;
		end if;
	end process;
	
	D <= ram_array(conv_integer(A)) when RD='1' else "ZZZZZZZZ";
	
end behavioral;