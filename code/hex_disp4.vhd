-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
-- CREATED		"Wed Apr 26 16:11:34 2023"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY hex_disp4 IS 
	PORT
	(
		A :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		D :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		hexout :  OUT  STD_LOGIC_VECTOR(27 DOWNTO 0)
	);
END hex_disp4;

ARCHITECTURE bdf_type OF hex_disp4 IS 

COMPONENT hex_display
	PORT(counts : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 displayout : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	hex :  STD_LOGIC_VECTOR(27 DOWNTO 0);


BEGIN 



b2v_inst : hex_display
PORT MAP(counts => A(7 DOWNTO 4),
		 displayout => hex(27 DOWNTO 21));


b2v_inst1 : hex_display
PORT MAP(counts => A(3 DOWNTO 0),
		 displayout => hex(20 DOWNTO 14));


b2v_inst2 : hex_display
PORT MAP(counts => D(7 DOWNTO 4),
		 displayout => hex(13 DOWNTO 7));


b2v_inst3 : hex_display
PORT MAP(counts => D(3 DOWNTO 0),
		 displayout => hex(6 DOWNTO 0));

hexout <= hex;

END bdf_type;