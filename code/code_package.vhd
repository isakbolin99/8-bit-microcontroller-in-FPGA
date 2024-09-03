library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


package code_package is

	type ram_type is array(63 downto 0) of std_logic_vector(7 downto 0); --arbitrary deep memory
	constant code1 : ram_type;
	constant code2 : ram_type;
	constant code3 : ram_type;
	constant code4 : ram_type;

end code_package;

package body code_package is

	--Code testing all instructions except the JUMP instructions
	constant code1 : ram_type := 
	  (0 => x"C0", --Load ADR1 with adress 32
		1 => x"20", 
		2 => x"C1", --Load ADR2 with adress 33
		3 => x"21",
		4 => x"C2", --Load JUMP_REG with 3
		5 => x"03",
		6 => x"80", --Load ACC with value on adress 32
		7 => x"81",	--Load TEMP with value on adress 33
		8 => x"89", --ACC = ACC + TEMP (should be 11 = 00001011)
		9 => x"8A", --ACC = ACC - TEMP (should be 6 = 00000110)
		10 => x"88", --CMP ACC,TEMP. GT should be 1
		11 => x"C1", --Load ADR2 with adress 32
		12 => x"20",
		13 => x"81", --Load TEMP with value on adress 32 (6)
		14 => x"88", --CMP. Z should be 1
		15 => x"C0", --Load ADR1 with adress 34
		16 => x"22",
		17 => x"C1", --Load ADR2 with adress 35
		18 => x"23",
		19 => x"82", --ST ACC on adress 34
		20 => x"83", --ST ACC on adress 35
		
		32 => x"06",
		33 => x"05",
		others => (others => '0'));
		
		
	--Code testing JUMP instructions
	constant code2 : ram_type :=
	  (0 => x"C2", --Load JUMP_REG with 3
	   1 => x"03",
		2 => x"84", --JUMP FWD 3
		3 => x"C2", --Load JUMP_REG with 3
		4 => x"03",
		5 => x"84", --JUMP FWD 3
		6 => x"C2", --Load JUMP_REG with 6
		7 => x"06",
		8 => x"85", --JUMP BWD 6
		
		--Code that uses JMP FWD conditional. Start with A = 1. Increment by 1 until A = 4.
		9 => x"C0", --Load ADR1 with adress 32
		10 => x"20", 
		11 => x"80", --Load ACC with value on adress 32 ACC = 1
		
		12 => x"C1", --Load ADR2 with adress 33
		13 => x"21",
		14 => x"81", --Load TEMP with value on adress 33 TEMP = 6
		15 => x"C2", --Load JUMP_REG with 7
		16 => x"07",
		17 => x"88", --CMP. 
		18 => x"87", --JPF_Z
		19 => x"C1", --Load ADR2 with adress 32
		20 => x"20",
		21 => x"81", --Load TEMP with value on adress 32 TEMP = 1
		22 => x"89", --ADD
		23 => x"C2", --Load JUMP_REG with 14
		24 => x"0E",
		25 => x"85",
		
		32 => x"01",
		33 => x"06",
		others => (others => '0'));
		
		
		--Example project 1
		constant code3 : ram_type :=
		  (0 => x"C0", --Load ADR1 with adress 32
		   1 => x"20",
			2 => x"C1", --Load ADR2 with adress 33
		   3 => x"21",
			4 => x"80", --Load ACC with value on adress 32
		   5 => x"81",	--Load TEMP with value on adress 33
			6 => x"89", --ADD
			7 => x"C0", --Load ADR1 with adress 34
		   8 => x"22",
			9 => x"82", --Store sum (A) in ram on adress 34
		   
		   32 => x"0A", --B = 10
			33 => x"0D", --C = 13
			others => (others => '0'));
			
		
		--Example project 2
		constant code4 : ram_type :=
		  (0 => x"C0", --Load ADR1 with adress 32
		   1 => x"20",
			2 => x"C1", --Load ADR2 with adress 33
		   3 => x"21",
			4 => x"80", --Load ACC with value on adress 32
		   5 => x"81",	--Load TEMP with value on adress 33
			6 => x"88", --CMP
			
			7 => x"C2", --Load JUMP_REG with 5
			8 => x"05",
			9 => x"87", --JPF_Z
			10 => x"C2", --Load JUMP_REG with 2
			11 => x"02",
			12 => x"86", --JPF_G
			
			13 => x"00",
			14 => x"00",
			
			15 => x"C0", --Load ADR1 with adress 34
		   16 => x"22",
			17 => x"C1", --Load ADR2 with adress 35 (B)
		   18 => x"23",
			19 => x"80", --Load ACC with value on adress 34 (C)
			20 => x"83", --ST ACC on adress 35 (B)
			
		   32 => x"08", --A = 8	
			33 => x"00", --Ref
			34 => x"14", --C = 20
		  
		   others => (others => '0'));
	
end code_package;
