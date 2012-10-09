library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity vgadrive is
Port (mclk : in std_logic;
	hs : out std_logic;
	vs : out std_logic;
	red, grn, blu : out std_logic;
	waveform:in STD_LOGIC_VECTOR (0 to 255));
end vgadrive;
architecture Behavioral of vgadrive is
component vgaController is
	Port ( mclk : in std_logic;
		hs : out std_logic;
		vs : out std_logic;
		x:out integer range 1 to 639;
		y:out integer range 1 to 479);
end component;
component vga_memory is
	Port ( red : out std_logic;
		grn : out std_logic;
		blu : out std_logic;
		x:in integer range 0 to 639;
		y:in integer range 0 to 479;
		waveform:in STD_LOGIC_VECTOR (0 to 255));
	end component;
signal xt: integer range 1 to 640;
signal yt: integer range 1 to 480;
begin
vga1: vgaController port map (mclk,hs,vs,xt,yt);
vgamemory: vga_memory port map(red,grn,blu,xt,yt,waveform);
end Behavioral;