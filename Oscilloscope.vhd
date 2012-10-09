library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Oscilloscope is
	Port ( voltage : in std_logic_vector(0 to 7);
		  voltageo : out std_logic_vector(0 to 7);
		  tvalue:in std_logic_vector(0 to 6);
		  tvalueo:out std_logic_vector(0 to 6);
		  tsign: in std_logic;
		  hs : out std_logic;
		  vs : out std_logic;
		  red, grn, blu : out std_logic;
		  clk:in std_logic;
		  wr,cs,rd :out std_logic;
	  	  intr:in std_logic;
		  tsigno,intro: out std_logic);
end Oscilloscope;

architecture Behavioral of Oscilloscope is
component input_process
    Port ( voltage : in std_logic_vector(0 to 7);
    		 wr:out std_logic;
		 intr,clkin:in std_logic;
		 data:out std_logic_vector(0 to 7));
end component;
component voltage_process
    Port ( voltage : in std_logic_vector(0 to 7);
		  tvalue:in std_logic_vector(0 to 6);
		  tsign: in std_logic;
		  waveform:out std_logic_vector(0 to 255));
end component;
component VGAdrive
Port (mclk : in std_logic;
	hs : out std_logic;
	vs : out std_logic;
	red, grn, blu : out std_logic;
	waveform:in STD_LOGIC_VECTOR (0 to 255));
end component;
signal value:std_logic_vector(0 to 7);
signal waveform:std_logic_vector(0 to 255);
signal intrx:std_logic;
begin
process(clk)
begin
	intrx<=intr;
end process;
measure:		input_process port map(voltage,wr,intrx,clk,value);
output: 		voltage_process port map(value,tvalue,tsign,waveform);
monitor:  	vgadrive port map(clk,hs,vs,red,grn,blu,waveform);
cs<='0';
rd<='0';	
voltageo<=voltage;
tvalueo<=tvalue;
tsigno<=tsign;
intro<=intr;
end Behavioral;
