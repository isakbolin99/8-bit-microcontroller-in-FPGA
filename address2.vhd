	library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity address2 is

	port
	(	CLK, RES, ADR2_LD, ADR2_OE : in std_logic;
		D : in std_logic_vector(7 downto 0);
		A : out std_logic_vector(7 downto 0));
		
end entity;

architecture behavioral of address2 is
signal ADR2 : std_logic_vector(7 downto 0);
signal ADR2_BUF : std_logic_vector(7 downto 0);

begin
	
	process(CLK,RES)
	begin
		if RES = '1' then
			A <= "ZZZZZZZZ";
		elsif rising_edge(CLK) then
			if ADR2_LD = '1' then
				ADR2 <= D;
			end if;
			--if ADR2_OE = '1' then
				--A <= ADR2_BUF;
			--else
				--A <= "ZZZZZZZZ";
			--end if;
		end if;
	end process;
	ADR2_BUF <= ADR2;
	A <= ADR2_BUF when ADR2_OE='1' else "ZZZZZZZZ";
	
end behavioral;