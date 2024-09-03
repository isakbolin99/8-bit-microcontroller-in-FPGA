library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity programcounter is

	port
	(	CLK, RES, PC_INC, PC_OE, JUMP_LD, JPF, JPB, JPF_GT, JPF_Z, Z, GT, ENABLE : in std_logic;
		D : in std_logic_vector(7 downto 0);
		A : out std_logic_vector(7 downto 0));
		
end entity;

architecture behavioral of programcounter is
signal JUMP_REG : std_logic_vector(7 downto 0);
signal PC : std_logic_vector(7 downto 0) := "00000000";
signal PC_BUF : std_logic_vector(7 downto 0) := "00000000";
signal enablesignal : std_logic := '1';


begin
	process(CLK,RES)
	begin
		if RES = '0' then
			A <= PC_BUF; --initiate PC=1 on Address bus
			PC <= "00000000";
			enablesignal <= '1';
		elsif rising_edge(CLK) then
			if ENABLE = '0' and enablesignal = '1' then
				enablesignal <= '0';
				if PC_INC = '1' then
					PC <= PC + 1;
				end if;
		
				
				--JUMP load
				if JUMP_LD = '1' then
					JUMP_REG <= D;
				end if;
				
				--JUMP instructions
				if JPF = '1' then
					PC <= PC + JUMP_REG;
				elsif JPB = '1' then
					PC <= PC - JUMP_REG;
				elsif JPF_GT = '1' then
					if GT = '1' then
						PC <= PC + JUMP_REG;
					end if;
				elsif JPF_Z = '1' then
					if Z = '1' then
						PC <= PC + JUMP_REG;
					end if;
				end if;
			elsif ENABLE = '1' then
				enablesignal <= '1';
			end if;
		end if;
	end process;
	
	PC_BUF <= PC;
	A <= PC_BUF when PC_OE='1' else "ZZZZZZZZ";
	
end behavioral;