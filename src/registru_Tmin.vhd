----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2026 10:53:34
-- Design Name: 
-- Module Name: registru_Tmin - Behavioral
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

entity registru_Tmin is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Inc_Tmin : in STD_LOGIC;
           Dec_Tmin : in STD_LOGIC;
           Load : in STD_LOGIC;
           Data_in : in STD_LOGIC_VECTOR (5 downto 0);
           Tmin_val : out STD_LOGIC_VECTOR (5 downto 0));
end registru_Tmin;

architecture Behavioral of registru_Tmin is

signal tmin_reg : unsigned(5 downto 0) :="010010";

begin

Tmin_val<= std_logic_vector(tmin_reg);
process(clk,rst)
begin

    if rst ='1' then
        tmin_reg <="010010";
    elsif rising_edge(clk) then
        if load ='1' then
            tmin_reg<=unsigned(Data_in);
        elsif Inc_Tmin ='1' then
            if tmin_reg < TO_UNSIGNED(50,6) then
                tmin_reg <= tmin_reg +1;
            end if;
        elsif Dec_Tmin ='1' then
            if tmin_reg > TO_UNSIGNED(0,6) then
                tmin_reg <= tmin_reg -1;
            end if;
        end if;
    end if;                            

end process;

end Behavioral;
