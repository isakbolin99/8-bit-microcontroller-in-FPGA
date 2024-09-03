library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

package decoder_package is

	function decoder(instruction : std_logic_vector(7 downto 0)) return std_logic_vector;
	
end decoder_package;


package body decoder_package is

		function decoder(instruction : std_logic_vector(7 downto 0)) return std_logic_vector is
			variable temp_control_bus : std_logic_vector(24 downto 0) := (others => '0');
			
		begin
			
				--					24  23  22	21		20			  19			18			17			 16			15
				--control_bus: RD, WR,  Z, GT, DOUBLE_INS, ADR2_LD, ADR2_OE, STOP,     ADR1_LD, ADR1_OE,
				
				--		14		13	  12	 11		10		  9		8		  7	 6        5
				--JUMP_LD, JPF, JPB, JPF_GT, JPF_Z, PC_LD, PC_INC, PC_OE, TEMP_LD, CMP, 
				-- 4    3     2        1       0
				--SUB, ADD, ACC_LD, ACC_INC, ACC_OE 
				
				--Double-length instructions start with 11 and single-length with 10.
			case instruction is 
			
				when "11000000" => --LD_ADR1 hxC0
					temp_control_bus := "1000100010000000110000000"; --RD, ADR1_LD, PC_INC, PC_OE
				when "11000001" => --LD_ADR2 hxC1
					temp_control_bus := "1000110000000000110000000"; --RD, ADR2_LD, PC_INC, PC_OE
				when "11000010" => --LD_JUMPREG hxC2
					temp_control_bus := "1000100000100000110000000"; --RD, JUMP_LD, PC_INC, PC_OE
					
				when "10000000" => --LD_ACC hx80
					temp_control_bus := "1000000001000000000000100"; --RD, ADR1_OE, ACC_LD 
				when "10000001" => --LD_TEMP hx81
					temp_control_bus := "1000001000000000001000000"; --RD, ADR2_OE, TEMP_LD
				when "10000010" => --ST_ACC1 hx82
					temp_control_bus := "0100000001000000000000001"; --WR, ADR1_OE, ACC_OE
				when "10000011" => --ST_ACC2 hx83
					temp_control_bus := "0100001000000000000000001"; --WR, ADR2_OE, ACC_OE
				when "10000100" => --JPF hx84
					temp_control_bus := "0000000000010000000000001"; --(RD), JPF
				when "10000101" => --JPB hx85
					temp_control_bus := "0000000000001000000000001"; --(RD), JPB
				when "10000110" => --JPF_G hx86
					temp_control_bus := "0000000000000100000000001"; --(RD), JPF_GT
				when "10000111" => --JPF_Z hx87
					temp_control_bus := "0000000000000010000000001"; --(RD), JPF_Z
				when "10001000" => --CMP hx88
					temp_control_bus := "0000000000000000000100000"; --(RD), CMP
				when "10001001" => --ADD hx89
					temp_control_bus := "0000000000000000000001000"; --(RD), ADD	
				when "10001010" => --SUB hx8A
					temp_control_bus := "0000000000000000000010000"; --(RD), SUB
					
				when others => 
					temp_control_bus := "1000000100000000010000000"; --code loops when done
			end case;
										
				return temp_control_bus;
		end function;
		
end decoder_package;