library ieee	 ;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity comp is	
	port(A, B: in std_logic_vector(3 downto 0);
	f1, f2, f3: out std_logic);
end comp;

architecture arh of comp is
begin
	process(A, B)
	variable v_f1, v_f2, v_f3: std_logic;
	begin
		if A(0) = '0' or A(0) = '1' then
		if A>B
			then v_f1:='1'; v_f2:='0'; v_f3:='0';
		elsif A=B 
			then v_f1:='0'; v_f2:='1'; v_f3:='0';
		else v_f1:='0'; v_f2:='0'; v_f3:='1';
		end if;
		else  v_f1 := '0'; v_f2 := '1'; v_f3 := '0'; 
		end if;
		f1 <= v_f1;
		f2 <= v_f2;
		f3 <= v_f3;
	end process;
end arh;
