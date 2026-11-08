----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2026 17:30:20
-- Design Name: 
-- Module Name: contor_ora - Behavioral
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

entity contor_ora is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_1ora : in STD_LOGIC;
           reset_ora : in STD_LOGIC;
           ora_cur : out STD_LOGIC_VECTOR (4 downto 0));
end contor_ora;

architecture Behavioral of contor_ora is
signal ora_cur_reg:unsigned(4 downto 0):=(others =>'0');
begin

ora_cur<=std_logic_vector(ora_cur_reg);
process(clk,rst)
begin

    if rst ='1' then
        ora_cur_reg<=(others =>'0');
    elsif rising_edge(clk) then
        if reset_ora = '1' then
            ora_cur_reg<=(others =>'0');
        elsif clk_1ora = '1' then
            if ora_cur_reg = TO_UNSIGNED(23,5) then
                ora_cur_reg <=(others =>'0');
            else
                ora_cur_reg <= ora_cur_reg+1; 
            end if;
         end if;             
     end if;
end process;
end Behavioral;
