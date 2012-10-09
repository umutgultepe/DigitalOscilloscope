library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity vga_memory is
Port ( red : out std_logic;
	grn : out std_logic;
	blu : out std_logic;
	x:in integer range 0 to 639;
	y:in integer range 0 to 479;
	waveform:in STD_LOGIC_VECTOR (0 to 255));
	end vga_memory;
architecture Behavioral of vga_memory is
begin
process(x,y)
variable cccc1:integer range 0 to 255;
begin
	red<='0';blu<='0';grn<='0';
	if (x=150 or x=470) and y<=300 and y>=44 then red<='1';blu<='0';grn<='0'; end if;
	if x>=150 and x<=470 and (y=300 or y=44) then red<='1';blu<='0';grn<='0'; end if;
	for i in 0 to 31 loop
		cccc1:=conv_integer(waveform(i*8 to i*8+7));
		if (x=i*10+150 or x=i*10+151) and y=300-cccc1 then red<='1';blu<='0';grn<='1';end if;
	end loop;
end process;
end Behavioral;