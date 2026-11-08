----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2026 10:43:28
-- Design Name: 
-- Module Name: SimulareTC - Behavioral
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

entity SimulareTC is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_1s : in STD_LOGIC;
           clk_3s : in STD_LOGIC;
           centrala : in STD_LOGIC;
           Tc : out STD_LOGIC_VECTOR (5 downto 0));
end SimulareTC;

architecture Behavioral of SimulareTC is

signal tc_reg :unsigned( 5 downto 0):="010100";
signal clk1s_prev:std_logic :='0';
signal clk3s_prev:std_logic :='0';


begin

Tc <=std_logic_vector(tc_reg);
process(clk,rst)
begin

    if rst ='1' then
        tc_reg <="010100";
        clk1s_prev<='0';
        clk3s_prev<='0';
        
    elsif rising_edge(clk) then
        if clk_1s ='1' and clk1s_prev='0' then
            if centrala ='1' then
                if tc_reg < TO_UNSIGNED(50,6) then
                    tc_reg <=tc_reg +1 ;
                end if;
            end if;
         end if;
         
         
         if clk_3s ='1' and clk3s_prev ='0' then
            if centrala ='0' then
                if tc_reg > TO_UNSIGNED(0,6) then
                    tc_reg <= tc_reg-1;
                end if;
            end if;
         end if;
         
         clk1s_prev <=clk_1s;
         clk3s_prev <=clk_3s;                          
    end if;
end process;

end Behavioral;
