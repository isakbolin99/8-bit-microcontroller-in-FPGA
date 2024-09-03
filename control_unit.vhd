library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;
use work.decoder_package.all;

entity control_unit is

	port
	(	D : in std_logic_vector(7 downto 0);
		STAT_UPD : in std_logic_vector(1 downto 0);
		CLK, RES : in std_logic;
		control_bus : buffer std_logic_vector(24 downto 0);
		Z, GT : out std_logic);
		
end entity;

architecture behavioral of control_unit is
signal STATUS : std_logic_vector(1 downto 0);
signal INSTR_REG : std_logic_vector(7 downto 0);
signal FETCH : std_logic := '0';


begin
	process(CLK,RES)
	begin
		if RES = '1' then
				control_bus <= "1000000000000000110000000"; --first two bits is RD and WR. bit 7 is PC_OE, bit 8 is PC_INC
				FETCH <= '1';
				
		elsif rising_edge(CLK) then

			if FETCH = '1' then
				control_bus <= decoder(D);
			else
				if control_bus(17) = '1' then
					control_bus <= "1000000000000000010000000"; --increment PC if double length instruction and prepare to read next instruction
				else
					control_bus <= "1000000000000000110000000"; --just prepare to read instruction again. PC_OE = '1'
				end if;
			end if;
		FETCH <= not FETCH;
		end if;
		
	end process;
	Z <= STAT_UPD(1);
	GT <= STAT_UPD(0);

	
end behavioral;