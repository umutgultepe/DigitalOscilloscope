library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity vgaController is
Port ( mclk : in std_logic;
hs : out std_logic;
vs : out std_logic;
x:out integer range 0 to 639;
y:out integer range 0 to 479
);
end vgaController;
architecture Behavioral of vgaController is
constant hpixels: std_logic_vector(9 downto 0) := "1100100000"; 
constant vlines : std_logic_vector(9 downto 0) := "1000001001"; 
constant hbp : std_logic_vector(9 downto 0) := "0010010000"; 
constant hfp : std_logic_vector(9 downto 0) := "1100010000"; 
constant vbp : std_logic_vector(9 downto 0) := "0000011111"; 
constant vfp : std_logic_vector(9 downto 0) := "0111111111";
signal hc, vc : std_logic_vector(9 downto 0) :="0000000000";
signal clkdiv : std_logic :='0'; 
signal vsenable : std_logic;
begin 
process(mclk)
begin
	if(mclk = '1' and mclk'EVENT) then clkdiv <= not clkdiv;end if;
end process;

process(clkdiv)
begin
	if(clkdiv = '1' and clkdiv'EVENT) then
		if hc = hpixels then
		hc <= "0000000000";
		vsenable <= '1';
		else
		hc <= hc + 1;
		vsenable <= '0';
		end if;
	end if;
end process;
hs <= '1' when hc(9 downto 7) = "000" else '0';
process(clkdiv)
begin
	if(clkdiv = '1' and clkdiv'EVENT and vsenable = '1') then
		if vc = vlines then
		vc <= "0000000000";
		else vc <= vc + 1;
		end if;
	end if;
end process;
vs <= '1' when vc(9 downto 1) = "000000000" else '0';
x<=conv_integer(hc)-conv_integer(hbp) when ((hc < hfp) and (hc >= hbp));
y<=conv_integer(vc)-conv_integer(vbp)when ((vc < vfp) and (vc >= vbp));
end Behavioral;