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
-- CREATED		"Fri Apr 21 09:30:50 2023"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY main IS 
	PORT
	(
		CLK :  IN  STD_LOGIC;
		RES :  IN  STD_LOGIC;
		STATUS :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END main;

ARCHITECTURE bdf_type OF main IS 

COMPONENT control_unit
	PORT(CLK : IN STD_LOGIC;
		 RES : IN STD_LOGIC;
		 D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 STAT_UPD : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 Z : OUT STD_LOGIC;
		 GT : OUT STD_LOGIC;
		 control_bus : OUT STD_LOGIC_VECTOR(24 DOWNTO 0)
	);
END COMPONENT;

COMPONENT address2
	PORT(CLK : IN STD_LOGIC;
		 RES : IN STD_LOGIC;
		 ADR2_LD : IN STD_LOGIC;
		 ADR2_OE : IN STD_LOGIC;
		 D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 A : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ram
	PORT(CLK : IN STD_LOGIC;
		 WR : IN STD_LOGIC;
		 RD : IN STD_LOGIC;
		 A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 D : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT alu
	PORT(CLK : IN STD_LOGIC;
		 RES : IN STD_LOGIC;
		 TEMP_LD : IN STD_LOGIC;
		 ACC_LD : IN STD_LOGIC;
		 ACC_OE : IN STD_LOGIC;
		 SUB : IN STD_LOGIC;
		 ADD : IN STD_LOGIC;
		 CMP : IN STD_LOGIC;
		 D : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 STAT : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT address1
	PORT(CLK : IN STD_LOGIC;
		 RES : IN STD_LOGIC;
		 ADR1_LD : IN STD_LOGIC;
		 ADR1_OE : IN STD_LOGIC;
		 D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 A : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT programcounter
	PORT(CLK : IN STD_LOGIC;
		 RES : IN STD_LOGIC;
		 PC_INC : IN STD_LOGIC;
		 PC_OE : IN STD_LOGIC;
		 JUMP_LD : IN STD_LOGIC;
		 JPF : IN STD_LOGIC;
		 JPB : IN STD_LOGIC;
		 JPF_GT : IN STD_LOGIC;
		 JPF_Z : IN STD_LOGIC;
		 Z : IN STD_LOGIC;
		 GT : IN STD_LOGIC;
		 D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 A : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	A :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	control_bus :  STD_LOGIC_VECTOR(24 DOWNTO 0);
SIGNAL	D :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;


BEGIN 



b2v_inst : control_unit
PORT MAP(CLK => CLK,
		 RES => RES,
		 D => D,
		 STAT_UPD => SYNTHESIZED_WIRE_0,
		 Z => SYNTHESIZED_WIRE_1,
		 GT => SYNTHESIZED_WIRE_2,
		 control_bus => control_bus);


b2v_inst1 : address2
PORT MAP(CLK => CLK,
		 RES => RES,
		 ADR2_LD => control_bus(19),
		 ADR2_OE => control_bus(18),
		 D => D,
		 A => A);


b2v_inst2 : ram
PORT MAP(CLK => CLK,
		 WR => control_bus(23),
		 RD => control_bus(24),
		 A => A,
		 D => D);


b2v_inst3 : alu
PORT MAP(CLK => CLK,
		 RES => RES,
		 TEMP_LD => control_bus(6),
		 ACC_LD => control_bus(2),
		 ACC_OE => control_bus(0),
		 SUB => control_bus(4),
		 ADD => control_bus(3),
		 CMP => control_bus(5),
		 D => D,
		 STAT => SYNTHESIZED_WIRE_0);


b2v_inst4 : address1
PORT MAP(CLK => CLK,
		 RES => RES,
		 ADR1_LD => control_bus(16),
		 ADR1_OE => control_bus(15),
		 D => D,
		 A => A);


b2v_inst5 : programcounter
PORT MAP(CLK => CLK,
		 RES => RES,
		 PC_INC => control_bus(8),
		 PC_OE => control_bus(7),
		 JUMP_LD => control_bus(14),
		 JPF => control_bus(13),
		 JPB => control_bus(12),
		 JPF_GT => control_bus(11),
		 JPF_Z => control_bus(10),
		 Z => SYNTHESIZED_WIRE_1,
		 GT => SYNTHESIZED_WIRE_2,
		 D => D,
		 A => A);


END bdf_type;