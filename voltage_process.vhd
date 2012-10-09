library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity voltage_process is
	Port ( voltage : in std_logic_vector(0 to 7);
		  tvalue:in std_logic_vector(0 to 6);
		  tsign: in std_logic;
		  waveform:out std_logic_vector(0 to 255));
end voltage_process;

architecture Behavioral of voltage_process is
constant zerovec:std_logic_vector(0 to 255):="0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
signal tempint:integer range 0 to 255;
signal tempwave,waveformer: std_logic_vector(0 to 255):="0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
signal count:integer range 0 to 255:=0;
signal oldvalue: std_logic_vector(0 to 7):="00000000";
signal curvalue: std_logic_vector(0 to 7):="00000000";
signal measure:std_logic:='0';
signal oldvalint:integer range 0 to 255;
signal tvaluex,curvalint:integer range 0 to 255;
signal send:std_logic;
begin
tvaluex<=CONV_INTEGER(tvalue);
tempint<=	CONV_INTEGER(voltage);
process(voltage)
begin
	oldvalue<=curvalue;
	curvalue<=voltage;
end process;
oldvalint<=CONV_INTEGER(oldvalue);
curvalint<=CONV_INTEGER(curvalue);
process(tsign,tvalue,tempint)
begin
	if (tsign='1') then
		if count=0 then
			if (tempint>tvaluex and curvalint>oldvalint) then 
				measure<='1';
			else
				measure<='0';
			end if;
		end if;
	elsif (tsign='0') then
		if count=0 then
			if (tempint>tvaluex and curvalint<oldvalint)  then 
				measure<='1';
			else
				measure<='0';
			end if;
		end if;		
	end if;
end process;
process(measure,voltage)
begin
	if measure='1' then
		tempwave<=tempwave(8 to 255)&voltage;
		if count=31 then
			count<=0;
			send<='1';
		else
			count<=count+1;
		end if;
	end if;		
end process;
process(send)
begin
	if send='1' then
	waveformer<=tempwave;
	send<='0';
	end if;
end process;
waveform<=waveformer;
end Behavioral;

