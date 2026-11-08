----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2026 15:18:53
-- Design Name: 
-- Module Name: ClockDivider - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ClockDivider is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Clk_1min : out STD_LOGIC;
           Clk_1s : out STD_LOGIC;
           Clk_3s : out STD_LOGIC);
end ClockDivider;

architecture Behavioral of ClockDivider is

component clock_divider_gen is
    Generic(PERIOD: natural:= 1000);
    Port(
         rst:in std_logic;
         clk_in:in std_logic;
         clk_out:out std_logic);
end component;
begin

    div_1min:clock_divider_gen
        generic map(PERIOD=>1000)
        port map(
                rst=>rst,
                clk_in=>clk,
                clk_out=>clk_1min);
    
    div_1s:clock_divider_gen
        generic map(PERIOD =>1000)
        port map(
                rst=>rst,
                clk_in=>clk,
                clk_out=>clk_1s);
    
    div_3s:clock_divider_gen
        generic map(PERIOD =>3000)
        port map(
                rst=>rst,
                clk_in=>clk,
                clk_out=>clk_3s);                

end Behavioral;
