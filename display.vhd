library ieee	 ;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity display is 
	port(Cod1: in std_logic_vector(6 downto 0); 
	Cod2: in std_logic_vector(6 downto 0);
	Cod3: in std_logic_vector(6 downto 0);
	Cod4: in std_logic_vector(6 downto 0);	 
	clk:in std_logic;
	Anod: out  std_logic_vector(3 downto 0);
	CATOD: out std_logic_vector(6 downto 0) );
end display;

architecture displaying of display is 
signal D: std_logic_vector(3 downto 0) := "1110" ;	 
signal clk70hz: std_logic;

component freq_div is
	port(clk: in std_logic;
	clk70hz: out std_logic);
end component;

begin
	clkdiv: freq_div port map(clk, clk70hz);
	
	process(clk70hz, D)	
	begin
		if(clk70hz ='1' and clk70hz'event) then	
			
			D(3) <= D(0);
			for i in 2 downto 0 loop
				D(i) <= D(i+1);
			end loop;
			
		end if;
		for i in 3 downto 0 loop
			Anod(i) <= D(i);
		end loop;
	end process;
	
	process(D, cod1, cod2, cod3, cod4)
	begin
		case D is
			when "1110" => CATOD <=Cod1;
			when "1101" => CATOD <=Cod2;
			when "1011" => CATOD <=Cod3;
			when "0111" => CATOD <=Cod4;
			when others => CATOD <="1111111";
		end case;
	end process;
	
end displaying;