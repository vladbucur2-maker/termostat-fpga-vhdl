----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2026 10:27:57
-- Design Name: 
-- Module Name: ssd_driver - Behavioral
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

entity ssd_driver is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (31 downto 0);
           catozi : out STD_LOGIC_VECTOR (7 downto 0);
           anozi : out STD_LOGIC_VECTOR (7 downto 0));
end ssd_driver;

architecture Behavioral of ssd_driver is

component clock_divider_gen 
    Generic (PERIOD: natural := 1000);
    port(rst:in std_logic;
         clk_in:in std_logic;
         clk_out:out std_logic);

end component;

component ssd_7seg

    port(datain: std_logic_vector( 3 downto 0);
         segout:out std_logic_vector( 7 downto 0));

end component;

signal clk_aux:std_logic :='0';
signal catozi_data:std_logic_vector( 3 downto 0):="0000";
signal counter: natural range 1 to 8:=1;

begin

divider:clock_divider_gen
    generic map (PERIOD => 2)
    port map (
                rst=>rst,
                clk_in=>clk,
                clk_out=>clk_aux);

converter :ssd_7seg
    port map(datain => catozi_data,
             segout =>catozi);         
                
process(rst,clk_aux)
begin

    if rst ='1' then
        counter<= 1;
    elsif rising_edge(clk_aux) then
        if counter < 8 then
            counter <=counter +1;
        else
            counter <= 1;
        end if;
    end if;
end process;

anozi<= not x"01" when counter = 8 else
        not x"02" when counter = 7 else
        not x"04" when counter = 6 else
        not x"08" when counter = 5 else
        not x"10" when counter = 4 else
        not x"20" when counter = 3 else
        not x"40" when counter = 2 else
        not x"80" when counter = 1 else
        not x"00";
        
catozi_data <= data(31 downto 28) when counter =1 else
               data(27 downto 24) when counter =2 else
               data(23 downto 20) when counter =3 else
               data(19 downto 16) when counter =4 else
               data(15 downto 12) when counter =5 else
               data(11 downto 8) when counter =6 else
               data(7 downto 4) when counter =7 else
               data(3 downto 0) when counter =8 else
               "0000";        
end Behavioral;
