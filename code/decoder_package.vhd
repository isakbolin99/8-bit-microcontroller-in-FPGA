library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

package decoder_package is

	function decoder(instruction : std_logic_vector(7 downto 0)) 
	return std_logic_vector;
	
end decoder_package;


package body decoder_package is

		function decoder(instruction : std_logic_vector(7 downto 0)) 
		return std_logic_vector is
			variable temp_control_bus : std_logic_vector(24 downto 0) 
			:= (others => '0');
			
		begin
			
		--control_bus: 24 RD, 23 WR, 22 Z, 21 GT, 20 DOUBLE_INS,
		--19 ADR2_LD, 18 ADR2_OE, 17 STOP, ADR1_LD, 15 ADR1_OE, 
		--14 JUMP_LD, 13 JPF, 12 JPB, 11 JPF_GT, 10 JPF_Z, 9 -, 
		--8 PC_INC, 7 PC_OE, 6 TEMP_LD, 5 CMP, 4 SUB, 3 ADD,
		--2 ACC_LD, 1 -, 0 ACC_OE
		--Double-length instructions start with 11 
		--and single-length with 10.
	case instruction is 

		when "11000000" => --LD_ADR1 hxC0, RD, ADR1_LD, PC_INC, PC_OE
			temp_control_bus := "1000100010000000110000000"; 
		when "11000001" => --LD_ADR2 hxC1, RD, ADR2_LD, PC_INC, PC_OE
			temp_control_bus := "1000110000000000110000000"; --
		when "11000010" => --LD_JUMPREG hxC2, RD, JUMP_LD, PC_INC, PC_OE
			temp_control_bus := "1000100000100000110000000"; 
			
		when "10000000" => --LD_ACC hx80, RD, ADR1_OE, ACC_LD
			temp_control_bus := "1000000001000000000000100";  
		when "10000001" => --LD_TEMP hx81, RD, ADR2_OE, TEMP_LD
			temp_control_bus := "1000001000000000001000000"; 
		when "10000010" => --ST_ACC1 hx82, WR, ADR1_OE, ACC_OE
			temp_control_bus := "0100000001000000000000001"; 
		when "10000011" => --ST_ACC2 hx83, WR, ADR2_OE, ACC_OE
			temp_control_bus := "0100001000000000000000001"; 
		when "10000100" => --JPF hx84, (RD), JPF, PC_OE
			temp_control_bus := "1000000000010000010000000"; 
		when "10000101" => --JPB hx85, (RD), JPB, PC_OE
			temp_control_bus := "1000000000001000010000000"; 
		when "10000110" => --JPF_G hx86, (RD), JPF_GT, PC_OE
			temp_control_bus := "1000000000000100010000000"; 
		when "10000111" => --JPF_Z hx87, (RD), JPF_Z, PC_OE
			temp_control_bus := "1000000000000010010000000"; 
		when "10001000" => --CMP hx88, (RD), PC_OE, CMP
			temp_control_bus := "1000000000000000010100000"; 
		when "10001001" => --ADD hx89, (RD), PC_OE, ADD
			temp_control_bus := "1000000000000000010001000"; 	
		when "10001010" => --SUB hx8A, (RD), PC_OE, SUB
			temp_control_bus := "1000000000000000010010000"; 
			
		when others => --code loops when done
			temp_control_bus := "1000000100000000010000000"; 
	end case;
										
				return temp_control_bus;
		end function;
		
end decoder_package;