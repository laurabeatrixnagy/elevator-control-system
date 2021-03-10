library ieee	 ;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity lift is
	port(buttons: in std_logic_vector(3 downto 0);	 --input from fpga board
	speed: in std_logic:= '0';	 -- 1 or 3 s
	w_sensor, d_sensor: in std_logic := '1'; --weight and door sensors	(fpga inputs)
	dir, int_ext: in std_logic;	 -- fpga inputs
	clk: in std_logic; -- fpga clock
	open_doors: inout std_logic := '1';	 -- fpga led
	closed_doors: inout std_logic := '0';  -- fpga led
	anode: out std_logic_vector(3 downto 0);
	catode: out std_logic_vector(6 downto 0);
	fullf_cond: out std_logic);
	
end lift;

architecture arch of lift is  

component freq_div is
	port ( clk: in std_logic;
	clk70hz: out std_logic);
end component; 

component counter is
	port(d: in std_logic_vector(3 downto 0);
	clk, enable, reset , up, down: std_logic;
	q: out std_logic_vector(3 downto 0));
end component;

component comp is	
	port(A, B: in std_logic_vector(3 downto 0);
	f1, f2, f3: out std_logic);
end component; 

component and_gate is 
	port (A, B, C, D: in std_logic;
	y : out std_logic);
end component;	

component doors is	
	port (a: in std_logic; 
	y1, y2: out std_logic);
end component; 

component freq_div_speed is
	port ( speed, clk: in std_logic;
	clk_lift: out std_logic);
end component;	  

component priority is 
	port(button: std_logic_vector(3 downto 0);	-- buttons
	dir, int_ext : in std_logic; --dir(up-1 or down-0) , int_ext(command coming from inside-0 or outside-1)
	curr_state:in std_logic_vector(3 downto 0);	
	standby, going_up, going_down: in std_logic; 
	fin_com: out std_logic_vector(3 downto 0));
end component; 

component extra is
	port( c_state: in std_logic_vector(3 downto 0);
	current_state: out std_logic_vector(3 downto 0));
end component;	

component decoder is
	port(  
	number: in std_logic_vector(3 downto 0);
	Cod1: out std_logic_vector(6 downto 0);
	Cod2: out std_logic_vector(6 downto 0) );
end component;			 

component display is 
	port(Cod1: in std_logic_vector(6 downto 0); 
	Cod2: in std_logic_vector(6 downto 0);
	Cod3: in std_logic_vector(6 downto 0);
	Cod4: in std_logic_vector(6 downto 0);	 
	clk:in std_logic;
	Anod: out  std_logic_vector(3 downto 0);
	CATOD: out std_logic_vector(6 downto 0) );
end component;					


component register4 IS PORT(		  
    d   : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    ld  : IN STD_LOGIC; -- load/enable.
    clr : IN STD_LOGIC; -- async. clear.
    clk : IN STD_LOGIC; -- clock.
    q   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)); -- output
END component;

signal going_up, going_down: std_logic:= '0';
signal standby: std_logic := '1';
signal curr_state: std_logic_vector(3 downto 0):="0000"; --initial state = ground
signal enable: std_logic;
signal clk_70hz, clk_lift: std_logic;
signal command: std_logic_vector(3 downto 0); 
signal reset : std_logic := '0';
signal c_state: std_logic_vector(3 downto 0):="0000";
signal Cod1, Cod2, Cod3, Cod4: std_logic_vector (6 downto 0);

begin
	
	C1 : counter port map (curr_state, clk, enable, reset, going_up, going_down, c_state);	--clk_lift instead of clk when real situation
	C2 : comp port map (command, c_state, going_up, standby, going_down);
	C3 : and_gate port map (w_sensor, d_sensor, open_doors, closed_doors, enable);
	C4 : doors port map (standby, open_doors, closed_doors);
	C5 : freq_div_speed port map (clk, speed, clk_lift);
	C6 : priority port map (buttons, dir, int_ext, c_state, standby, going_up, going_down, command);
	C7 : extra port map(c_state, curr_state); 
	C8 : decoder port map(c_state, Cod1, Cod2);	
	C9 : display port map(Cod1, Cod2, "1111111", "1111111", clk, anode, catode);
	
end arch;

