library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity loopcounter is

	port
	(	CLK, LC_DEC, LC_LD : in std_logic;
		LC_ZERO : out std_logic;
		D : in std_logic_vector(7 downto 0));
		
end entity;

architecture behavioral of loopcounter is
signal LC : std_logic_vector(7 downto 0);

begin
	process(CLK)
	begin
		if rising_edge(CLK) then
			
		end if;
	end process;
	
	
end behavioral;