----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.05.2026 19:56:36
-- Design Name: 
-- Module Name: Binar_la_BCD - Behavioral
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

entity Binar_la_BCD is
    Port ( Bin : in STD_LOGIC_VECTOR (5 downto 0);
           Zeci : out STD_LOGIC_VECTOR (3 downto 0);
           Unitati : out STD_LOGIC_VECTOR (3 downto 0));
end Binar_la_BCD;

architecture Behavioral of Binar_la_BCD is
signal val:integer range 0 to 63;
begin
val <=TO_INTEGER(unsigned(Bin));
Zeci<=std_logic_vector(TO_UNSIGNED(val/10,4));
Unitati<=std_logic_vector(TO_UNSIGNED(val mod 10,4));

end Behavioral;
