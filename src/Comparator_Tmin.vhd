----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2026 11:07:28
-- Design Name: 
-- Module Name: Comparator_Tmin - Behavioral
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

entity Comparator_Tmin is
    Port ( Tc : in STD_LOGIC_VECTOR (5 downto 0);
           Tmin_cur : in STD_LOGIC_VECTOR (5 downto 0);
           Tc_sub_min : out STD_LOGIC);
end Comparator_Tmin;

architecture Behavioral of Comparator_Tmin is

begin

Tc_sub_min <='1' when unsigned(Tc)< unsigned(Tmin_cur) else '0';

end Behavioral;
