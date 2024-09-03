library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity address1 is

	port
	(	CLK, RES, ADR1_LD, ADR1_OE : in std_logic;
		D : in std_logic_vector(7 downto 0);
		A : out std_logic_vector(7 downto 0));
		
end entity;

architecture behavioral of address1 is
signal ADR1 : std_logic_vector(7 downto 0);
signal ADR1_BUF : std_logic_vector(7 downto 0);

begin
	
	process(CLK,RES)
	begin
		if RES = '1' then
			A <= "ZZZZZZZZ";
		elsif rising_edge(CLK) then
			if ADR1_LD = '1' then
				ADR1 <= D;
			end if;
			--if ADR1_OE = '1' then
				--A <= ADR1_BUF;
			--else
				--A <= "ZZZZZZZZ";
			--end if;
		end if;
	end process;
	ADR1_BUF <= ADR1;
	A <= ADR1_BUF when ADR1_OE='1' else "ZZZZZZZZ";
	
end behavioral;