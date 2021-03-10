library ieee	 ;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity priority is 
	port(button: std_logic_vector(3 downto 0);	-- buttons
	dir, int_ext : in std_logic; --dir(up-1 or down-0) , int_ext(command coming from inside-0 or outside-1)
	curr_state:in std_logic_vector(3 downto 0);	
	standby, going_up, going_down: in std_logic; 
	fin_com: out std_logic_vector(3 downto 0));
end priority;

architecture idk of priority is 

signal v_ext_up: std_logic_vector(12 downto 0):="0000000000000";
signal v_ext_down: std_logic_vector(12 downto 0):="0000000000000";
signal v_int: std_logic_vector(12 downto 0):="0000000000000";

begin  	 		  

process(button, curr_state, dir, int_ext, standby, going_up, going_down) 
	
	variable v_ext_up_v: std_logic_vector(12 downto 0):="0000000000000";
	variable v_ext_down_v: std_logic_vector(12 downto 0):="0000000000000";
	variable v_int_v: std_logic_vector(12 downto 0):="0000000000000";
	variable floor, c_state_v: integer;										

begin 
	if standby = '1' then 
		fin_com <= button;
	  case button is	
		when "0000" => floor := 0;
		when "0001" => floor := 1;
		when "0010" => floor := 2;
		when "0011" => floor := 3;
		when "0100" => floor := 4;
		when "0101" => floor := 5;
		when "0110" => floor := 6;
		when "0111" => floor := 7;
		when "1000" => floor := 8;
		when "1001" => floor := 9;
		when "1010" => floor := 10;
		when "1011" => floor := 11;
		when "1100" => floor := 12;
		when others => floor := 10;
	end case;
		case curr_state is
		when "0000" => c_state_v := 0;
		when "0001" => c_state_v := 1;
		when "0010" => c_state_v := 2;
		when "0011" => c_state_v := 3;
		when "0100" => c_state_v := 4;
		when "0101" => c_state_v := 5;
		when "0110" => c_state_v := 6;
		when "0111" => c_state_v := 7;
		when "1000" => c_state_v := 8;
		when "1001" => c_state_v := 9;
		when "1010" => c_state_v := 10;
		when "1011" => c_state_v := 11;
		when "1100" => c_state_v := 12;
		when others => c_state_v := 0;
	end case;
	--store the previous commands too
	if button < curr_state then v_ext_down_v(floor) := '1'; end if;
	if button > curr_state then v_ext_up_v(floor) := '1'; end if;  
		--  current floor index => 0 
	v_ext_down_v(c_state_v) := '0';
	v_ext_up_v(c_state_v) := '0'; 
	v_int_v(c_state_v) := '0';
	
		
	else  --when movement
	case button is	
		when "0000" => floor := 0;
		when "0001" => floor := 1;
		when "0010" => floor := 2;
		when "0011" => floor := 3;
		when "0100" => floor := 4;
		when "0101" => floor := 5;
		when "0110" => floor := 6;
		when "0111" => floor := 7;
		when "1000" => floor := 8;
		when "1001" => floor := 9;
		when "1010" => floor := 10;
		when "1011" => floor := 11;
		when "1100" => floor := 12;
		when others => floor := 10;
	end case;
--	temp_v := temp; 

	
	if int_ext = '1' then 
		if  dir = '1' then 
			v_ext_up_v(floor) := '1';
							else if dir = '0' then 
										v_ext_down_v(floor) := '1'; 
									end if ; 
		end if;
	end if;
	
	if int_ext = '0' then v_int_v(floor) :=	'1';  end if;  
	
	case curr_state is
		when "0000" => c_state_v := 0;
		when "0001" => c_state_v := 1;
		when "0010" => c_state_v := 2;
		when "0011" => c_state_v := 3;
		when "0100" => c_state_v := 4;
		when "0101" => c_state_v := 5;
		when "0110" => c_state_v := 6;
		when "0111" => c_state_v := 7;
		when "1000" => c_state_v := 8;
		when "1001" => c_state_v := 9;
		when "1010" => c_state_v := 10;
		when "1011" => c_state_v := 11;
		when "1100" => c_state_v := 12;
		when others => c_state_v := 0;
	end case;
	
	--  current floor index => 0 
	v_ext_down_v(c_state_v) := '0';
	v_ext_up_v(c_state_v) := '0'; 
	v_int_v(c_state_v) := '0';
	
	if c_state_v < 12 and going_up = '1' then 
		if v_ext_up_v(c_state_v+1) = '1' 
			then fin_com <= curr_state +'1'; end if;
		if v_int_v(c_state_v+1) = '1' 
			then fin_com <= curr_state +'1'; end if;
	end if;
	if c_state_v > 0 and going_down = '1' then
		if v_ext_down_v(c_state_v-1) = '1' 
			then fin_com <= curr_state - '1'; end if;	
		if v_int_v(c_state_v-1) = '1'
			then fin_com <= curr_state - '1'; end if;
	end if;	
	
	end if;	
	
	v_ext_up <= v_ext_up_v;	
	v_ext_down <= v_ext_down_v;
	v_int <= v_int_v;
	
	end process;
	
end idk;
