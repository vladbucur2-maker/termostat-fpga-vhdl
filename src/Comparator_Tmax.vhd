----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2026 11:09:35
-- Design Name: 
-- Module Name: Comparator_Tmax - Behavioral
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

entity Comparator_Tmax is
    Port ( Tc : in STD_LOGIC_VECTOR (5 downto 0);
           Tmax_cur : in STD_LOGIC_VECTOR (5 downto 0);
           Tc_peste_max : out STD_LOGIC);
end Comparator_Tmax;

architecture Behavioral of Comparator_Tmax is

begin

Tc_peste_max <= '1' when unsigned(Tc) > unsigned(Tmax_cur) else '0';

end Behavioral;
