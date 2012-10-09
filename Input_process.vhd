library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Input_process is
    Port ( voltage : in std_logic_vector(0 to 7);
    		 wr:out std_logic;
		 intr,clkin:in std_logic;
		 data:out std_logic_vector(0 to 7));
end Input_process;

architecture Behavioral of Input_process is
signal count,countx:integer:=0;															    
signal tempval:std_logic_vector(0 to 7):="00000000";				 										 
signal tempwr:std_logic:='0';			    										   
begin																	 		   				  									    										    			  
wr<=tempwr;
process(intr,clkin)
begin
if (clkin'event and clkin = '1') then
	if (intr= '0') then	
	data<=voltage;
	tempval<=voltage;
		if (tempwr='1') then 		     						     
					if (countx=625) then
							tempwr<='0';							
							countx<=0;
					else 										 
						countx <= countx +1;	                  
					end if;
		end if;
	else
	data<=tempval;
	if (tempwr='0') then 		     						     
				if (count=5) then
						tempwr<='1';							
						count<=0;
				else 										 
					count <= count +1;	                  
				end if;
		end if;			
	end if;
end if;
end process;
end Behavioral;
