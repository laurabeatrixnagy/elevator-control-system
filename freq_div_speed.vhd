library ieee	 ;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity freq_div_speed is
	port ( speed, clk: in std_logic;
	clk_lift: out std_logic);
end freq_div_speed;

architecture counter of freq_div_speed is

signal count: integer:=1;
signal tmp : std_logic := '0';

begin
	process(clk, speed, tmp)
		begin
		if rising_edge(clk) then 
			if speed = '0' then
				count <=count+1;
				if (count = 25_000_000) then
					tmp <= NOT tmp;
					count <= 1;	end if;
		else if speed = '1' then
				count <= count+1;
				if (count = 75_000_000) then
					tmp <= NOT tmp;
					count <= 1;	end if;
			end if;
			end if;
		end if;
		clk_lift <= tmp;
	end process;
end counter;	