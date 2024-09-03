	library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity address2 is

	port
	(	CLK, RES, ADR2_LD, ADR2_OE, ENABLE : in std_logic;
		D : in std_logic_vector(7 downto 0);
		A : out std_logic_vector(7 downto 0));
		
end entity;

architecture behavioral of address2 is
signal ADR2 : std_logic_vector(7 downto 0);
signal ADR2_BUF : std_logic_vector(7 downto 0);
signal enablesignal : std_logic := '1';

begin
	
	process(CLK,RES)
	begin
		if RES = '0' then
			A <= "ZZZZZZZZ";
			enablesignal <= '1';
		elsif rising_edge(CLK) then
			if ENABLE = '0' and enablesignal = '1' then
				enablesignal <= '0';
				if ADR2_LD = '1' then
					ADR2 <= D;
				end if;
			elsif ENABLE = '1' then
				enablesignal <= '1';
			end if;
		end if;
	end process;
	ADR2_BUF <= ADR2;
	A <= ADR2_BUF when ADR2_OE='1' else "ZZZZZZZZ";
	
end behavioral;