library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity address1 is

	port
	(	CLK, RES, ADR1_LD, ADR1_OE, ENABLE : in std_logic;
		D : in std_logic_vector(7 downto 0);
		A : out std_logic_vector(7 downto 0));
		
end entity;

architecture behavioral of address1 is
signal ADR1 : std_logic_vector(7 downto 0);
signal ADR1_BUF : std_logic_vector(7 downto 0);
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
				if ADR1_LD = '1' then
					ADR1 <= D;
				end if;
			elsif ENABLE = '1' then
				enablesignal <= '1';
			end if;
		end if;
	end process;
	ADR1_BUF <= ADR1;
	A <= ADR1_BUF when ADR1_OE='1' else "ZZZZZZZZ";
	
end behavioral;