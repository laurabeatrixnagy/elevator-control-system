library ieee	 ;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter is
	port(d: in std_logic_vector(3 downto 0);
	clk, enable, reset , up, down: std_logic;
	q: out std_logic_vector(3 downto 0));
end counter;

architecture count of counter is  
signal tempp: std_logic_vector(3 downto 0):="0000";
begin 

	process(clk, reset, enable, up, down, tempp, d)
	variable aux: std_logic:='0';
	begin 	
		if enable = '1' then
			if reset = '1' then 
				tempp <= "0000"; 
				null;
			else 
					
					if aux = '0'  then tempp <=d ; aux := '1';	 --load counter with curr_state
					elsif rising_edge(clk) then if up = '1' then tempp <= tempp+1;

					elsif down = '1' then tempp <= tempp-1;  end if; 
						end if;
					end if;	
				
			end if;	
		
		--end if;	
		
		q <= tempp;	
	end process;
end count;
	