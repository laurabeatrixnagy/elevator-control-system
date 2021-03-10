library ieee	 ;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity and_gate is 
	port (A, B, C, D: in std_logic;
	y : out std_logic);
end and_gate;

architecture gate of and_gate is
begin
	y <= A and B and not C and D;	--a,b,c, and d will be the weight sensor, person in door sensor, open/closed doors
end gate;
