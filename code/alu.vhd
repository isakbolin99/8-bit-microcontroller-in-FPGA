library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is

	port
	(	CLK, RES, TEMP_LD, ACC_LD, ACC_OE, SUB, ADD, CMP, ENABLE : in std_logic;
		STAT : out std_logic_vector(1 downto 0);
		D : inout std_logic_vector(7 downto 0));
		
end entity;

architecture behavioral of alu is
signal TEMP_REG : signed(7 downto 0);
signal ACC : signed(7 downto 0);
signal ACC_BUF : signed(7 downto 0);
signal enablesignal : std_logic := '1';

begin
	process(CLK,RES)
	begin
		if RES = '0' then
			D <= "ZZZZZZZZ";
			enablesignal <= '1';
		elsif rising_edge(CLK) then
			if ENABLE = '0' and enablesignal = '1' then
				enablesignal <= '0';
				--Load register
				if ACC_LD = '1' then
					ACC <= signed(D);
				elsif TEMP_LD ='1' then
					TEMP_REG <= signed(D);
				end if;
				
				--Operations
				if SUB = '1' then
					ACC <= ACC - TEMP_REG;
				elsif ADD = '1' then
					ACC <= ACC + TEMP_REG;
				end if;
				if CMP = '1' then
					if ACC = TEMP_REG then
						STAT <= "10";
					elsif ACC > TEMP_REG then
						STAT <= "01";
					end if;
				end if;
			elsif ENABLE = '1' then
				enablesignal <= '1';
			end if;
		end if;
	end process;
	
	ACC_BUF <= ACC;
	D <= std_logic_vector(ACC_BUF) when ACC_OE = '1' else "ZZZZZZZZ";
	
	
end behavioral;