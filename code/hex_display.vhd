library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

PACKAGE SevenSegmentDecoding is
	function to_SevenSegment (symbol: in std_logic_vector(3 downto 0)) return std_logic_vector;
end PACKAGE SevenSegmentDecoding;

PACKAGE BODY SevenSegmentDecoding is
	function to_SevenSegment (symbol: in std_logic_vector(3 downto 0)) return std_logic_vector is
		variable input : std_logic_vector(3 downto 0);
		variable output: std_logic_vector(6 downto 0);
	begin
	input := symbol;
		case input is
		
			when "0000" => output := "1000000";
			when "0001" => output := "1111001";
         when "0010" => output := "0100100";
         when "0011" => output := "0110000";
         when "0100" => output := "0011001";
         when "0101" => output := "0010010";
         when "0110" => output := "0000010";
         when "0111" => output := "1111000";
         when "1000" => output := "0000000";
         when "1001" => output := "0010000";
         when "1010" => output := "0001000";
         when "1011" => output := "0000011";
         when "1100" => output := "1000110";
         when "1101" => output := "0100001";
         when "1110" => output := "0000110";
         when "1111" => output := "0001110";
			when others => output := "0110110";
		
		end case;
		
		return output;
	end function;

end PACKAGE BODY SevenSegmentDecoding;




library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.SevenSegmentDecoding.to_SevenSegment;

entity hex_display is

	port
	(	counts : in std_logic_vector(3 downto 0);
		displayout : out std_logic_vector(6 downto 0));
		
end entity;

architecture rtl of hex_display is
begin
	
	displayout <= to_SevenSegment(counts);
	
end rtl;