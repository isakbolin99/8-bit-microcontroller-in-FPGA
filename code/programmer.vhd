library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity programmer is

	port
	(	CLK : in std_logic;
		
		D, A : out std_logic_vector(7 downto 0));
		
end entity;

architecture behavioral of programmer is
signal ADR1 : std_logic_vector(7 downto 0);
signal ADR1_BUF1 : std_logic_vector(7 downto 0);

begin
	
	
	
end behavioral;