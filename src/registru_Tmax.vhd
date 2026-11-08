----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2026 11:01:05
-- Design Name: 
-- Module Name: registru_Tmax - Behavioral
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

entity registru_Tmax is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Inc_Tmax : in STD_LOGIC;
           Dec_Tmax : in STD_LOGIC;
           Load : in STD_LOGIC;
           Data_in : in STD_LOGIC_VECTOR (5 downto 0);
           Tmax_val : out STD_LOGIC_VECTOR (5 downto 0));
end registru_Tmax;

architecture Behavioral of registru_Tmax is

signal tmax_reg :unsigned( 5 downto 0):="010110";

begin

Tmax_val<= std_logic_vector(tmax_reg);

process(clk,rst)
begin

    if rst ='1' then
        tmax_reg<="010110";
    elsif rising_edge(clk) then
        if load ='1' then
            tmax_reg <= unsigned(data_in);
        elsif Inc_Tmax ='1'  then
            if tmax_reg < TO_UNSIGNED(50,6) then    
                tmax_reg <=tmax_reg+1;
            end if;
        elsif Dec_Tmax = '1' then
            if tmax_reg > TO_UNSIGNED(0,6) then
                tmax_reg <=tmax_reg -1;
            end if;
        end if;
    end if;                           

end process;

end Behavioral;
