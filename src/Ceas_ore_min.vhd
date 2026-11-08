----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2026 17:16:43
-- Design Name: 
-- Module Name: Ceas_ore_min - Behavioral
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

entity Ceas_ore_min is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_1min : in STD_LOGIC;
           reset_clk : in STD_LOGIC;
           load_clk : in STD_LOGIC;
           inc_ora : in STD_LOGIC;
           dec_ora : in STD_LOGIC;
           inc_min : in STD_LOGIC;
           dec_min : in STD_LOGIC;
           Ora : out STD_LOGIC_VECTOR (4 downto 0);
           Minut : out STD_LOGIC_VECTOR (5 downto 0));
end Ceas_ore_min;

architecture Behavioral of Ceas_ore_min is
signal ora_reg:unsigned(4 downto 0):=(others =>'0');
signal minut_reg:unsigned(5 downto 0):=(others =>'0');
signal clk1min_prev: std_logic :='0';
begin

ora<=std_logic_vector(ora_reg);
minut<=std_logic_vector(minut_reg);

process(clk,rst)
begin

    if rst='1' then
        ora_reg<=(others =>'0');
        minut_reg<=(others =>'0');
        clk1min_prev <='0';
        
        elsif rising_edge(clk) then
        if reset_clk='1' then
            ora_reg<=(others =>'0');
            minut_reg<=(others =>'0');
            
        elsif load_clk='1' then
            if inc_ora='1'then
                if ora_reg =TO_UNSIGNED(23,5) then
                    ora_reg<=(others =>'0');
                else
                    ora_reg<=ora_reg+1;
                end if;
            end if;
        
        if dec_ora ='1' then
            if ora_reg = TO_UNSIGNED(0,5) then
                ora_reg<=TO_UNSIGNED(23,5);
            else
                ora_reg<=ora_reg-1;
            end if;
        end if;          
        
        if inc_min ='1' then
            if minut_reg =TO_UNSIGNED(59,6) then
                    minut_reg <=(others =>'0');
             else
                    minut_reg<=minut_reg+1;
             end if;
        end if;
        
        if dec_min ='1' then
            if minut_reg = TO_UNSIGNED(0,6) then
                minut_reg<= TO_UNSIGNED(59,6);
            else
                minut_reg<=minut_reg-1;
            end if;
       end if;         
       
       elsif clk_1min='1' and clk1min_prev='0' then
            if minut_reg =TO_UNSIGNED(59,6) then
                minut_reg<=(others =>'0');
                if ora_reg = TO_UNSIGNED(23,5) then
                    ora_reg <=(others =>'0');
                else
                    ora_reg<=ora_reg+1;
                end if;
             else
                minut_reg<=minut_reg +1;
             end if;
       end if;
       clk1min_prev<=clk_1min;
  end if;                                                               
end process;

end Behavioral;
