library ieee	 ;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity extra is
	port( c_state: in std_logic_vector(3 downto 0);
	current_state: out std_logic_vector(3 downto 0));
end extra;



architecture extra of extra is
begin

	current_state <= c_state;

end extra;
