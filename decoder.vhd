library ieee	 ;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity decoder is
	port(  
	number: in std_logic_vector(3 downto 0);
	Cod1: out std_logic_vector(6 downto 0);
	Cod2: out std_logic_vector(6 downto 0) );
end entity;

architecture A_decoder of decoder is
begin  
	process(number)	  
	begin
	case number is
    when "0000" => Cod1 <= "0000001"; Cod2 <= "1111111";  -- "0"     
    when "0001" => Cod1 <= "1001111"; Cod2 <= "1111111"; -- "1" 
    when "0010" => Cod1 <= "0010010"; Cod2 <= "1111111"; -- "2" 
    when "0011" => Cod1 <= "0000110"; Cod2 <= "1111111";-- "3" 
    when "0100" => Cod1 <= "1001100"; Cod2 <= "1111111";-- "4" 
    when "0101" => Cod1 <= "0100100"; Cod2 <= "1111111";-- "5" 
    when "0110" => Cod1 <= "0100000"; Cod2 <= "1111111";-- "6" 
    when "0111" => Cod1 <= "0001111"; Cod2 <= "1111111";-- "7" 
    when "1000" => Cod1 <= "0000000"; Cod2 <= "1111111";-- "8"     
    when "1001" => Cod1 <= "0000100"; Cod2 <= "1111111";-- "9" 
    when "1010" => Cod1 <= "0000001"; Cod2 <= "1001111"; -- 10
    when "1011" => Cod1 <= "1001111"; Cod2 <= "1001111"; -- 11
    when "1100" => Cod1 <= "0010010"; Cod2 <= "1001111"; -- 12
    when others => Cod1 <= "0000001"; Cod2 <= "1111111";
    end case;  
end process;
end A_decoder;
