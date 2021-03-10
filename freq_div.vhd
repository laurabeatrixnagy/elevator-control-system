library ieee	 ;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


--7 seg display clock
entity freq_div is
	port ( clk: in std_logic;
	clk70hz: out std_logic);
end freq_div;

architecture counter of freq_div is
begin
	counter: process(clk)
	variable int: std_logic_vector(17 downto 0) := (others => '0');
	begin
		if(clk'event and clk ='1') then
			int:= int+1;
			clk70hz <=int(17);
		end if;
	end process;
end architecture;
