library ieee	 ;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity doors is	
	port (a: in std_logic; 
	y1, y2: out std_logic);  --y1 = closed_doors , y2 = open_doors
end doors;

architecture doors of doors is
begin
	process(a) -- the signal a will come from the comparator's f2 output
	begin  
		if a = '1' then y1 <='1'; y2 <='0';	 --no movement, closed doors
			else y1 <='0'; y2 <='1';	--open doors
		end if;
	end process;
end doors;
