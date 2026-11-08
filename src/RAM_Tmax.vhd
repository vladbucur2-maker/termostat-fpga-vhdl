----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2026 17:09:54
-- Design Name: 
-- Module Name: RAM_Tmax - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM_Tmax is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Load : in STD_LOGIC;
           wr_addr : in STD_LOGIC_VECTOR (4 downto 0);
           Data_in : in STD_LOGIC_VECTOR (5 downto 0);
           Rd_addr : in STD_LOGIC_VECTOR (4 downto 0);
           Data_out : out STD_LOGIC_VECTOR (5 downto 0));
end RAM_Tmax;

architecture Behavioral of RAM_Tmax is
type RAM_TYPE is array (0 to 23) of std_logic_vector(5 downto 0);
signal RAM:RAM_TYPE:=(others =>"010110");
begin

process(clk,rst)
begin
    
    if rst ='1' then
        RAM<=(others =>"010110");
    elsif rising_edge(clk) then
        if load ='1' then
            RAM(TO_INTEGER(unsigned(Wr_addr)))<=Data_in;
        end if;
    end if;            
    
end process;
Data_out <= RAM(TO_INTEGER(unsigned(Rd_addr)));
end Behavioral;
