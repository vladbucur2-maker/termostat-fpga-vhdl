----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.05.2026 20:05:20
-- Design Name: 
-- Module Name: Display_Mux - Behavioral
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

entity Display_Mux is
    Port ( Disp_mode : in STD_LOGIC_VECTOR (1 downto 0);
           Ora : in STD_LOGIC_VECTOR (4 downto 0);
           Minut : in STD_LOGIC_VECTOR (5 downto 0);
           Tc : in STD_LOGIC_VECTOR (5 downto 0);
           ora_set : in STD_LOGIC_VECTOR (4 downto 0);
           Tmin_set : in STD_LOGIC_VECTOR (5 downto 0);
           Tmax_set : in STD_LOGIC_VECTOR (5 downto 0);
           set_tmax : in STD_LOGIC;
           Data : out STD_LOGIC_VECTOR (31 downto 0));
end Display_Mux;

architecture Behavioral of Display_Mux is

component Binar_la_BCD

port(
    Bin:in std_logic_vector(5 downto 0);
    Zeci:out std_logic_vector(3 downto 0);
    Unitati:out std_logic_vector(3 downto 0));

end component;

signal ora_6bit:std_logic_vector(5 downto 0);
signal ora_set_6bit:std_logic_vector(5 downto 0);

signal ora_zeci :std_logic_vector(3 downto 0);
signal ora_unit:std_logic_vector(3 downto 0);

signal min_zeci:std_logic_vector(3 downto 0);
signal min_unit:std_logic_vector(3 downto 0);

signal tc_zeci:std_logic_vector(3 downto 0);
signal tc_unit:std_logic_vector(3 downto 0);

signal ora_set_zeci:std_logic_vector(3 downto 0);
signal ora_set_unit:std_logic_vector(3 downto 0);

signal tmin_zeci:std_logic_vector(3 downto 0);
signal tmin_unit:std_logic_vector(3 downto 0);

signal tmax_zeci:std_logic_vector(3 downto 0);
signal tmax_unit:std_logic_vector(3 downto 0);

signal temp_zeci:std_logic_vector(3 downto 0);
signal temp_unit:std_logic_vector(3 downto 0);

begin

ora_6bit <='0' & ora;
ora_set_6bit <='0' & ora_set;

bcd_ora:Binar_la_BCD
    port map(Bin=>ora_6bit,zeci=>ora_zeci,unitati=>ora_unit);

bcd_min:Binar_la_BCD
    port map(Bin=>minut,zeci=>min_zeci,unitati=>min_unit);    
    
bcd_tc:Binar_la_BCD
    port map(Bin=>Tc,Zeci=>tc_zeci,unitati=>tc_unit);
    
bcd_ora_set:Binar_la_BCD
    port map(Bin=>ora_set_6bit,Zeci=>ora_set_zeci,unitati=>ora_set_unit);
    
bcd_tmin:Binar_la_BCD
    port map(Bin=>Tmin_set,Zeci=>tmin_zeci,unitati=>tmin_unit);
    
bcd_tmax:Binar_la_BCD
    port map(Bin=>Tmax_set,Zeci=>tmax_zeci,unitati=>tmax_unit);
    
temp_zeci<=tmax_zeci when set_tmax ='1' else tmin_zeci;
temp_unit<=tmax_unit when set_tmax='1' else tmin_unit;

process(Disp_mode,ora_zeci,ora_unit,min_zeci,min_unit,tc_zeci,tc_unit,ora_set_zeci,ora_set_unit,temp_zeci,temp_unit)
begin
case Disp_mode is
when "00"|"01" =>
    Data(31 downto 28)<=ora_zeci;
    Data(27 downto 24)<=ora_unit;
    Data(23 downto 20)<="1010";
    Data(19 downto 16)<= min_zeci;
    Data(15 downto 12)<= min_unit;
    Data(11 downto 8)<= "1111";
    Data(7 downto 4)<="1111";
    Data(3 downto 0)<="1111";
    
when "10" =>
    Data(31 downto 28)<=ora_set_zeci;
    Data(27 downto 24)<= ora_set_unit;
    Data(23 downto 20)<="1010";
    Data(19 downto 16)<= temp_zeci;
    Data(15 downto 12)<= temp_unit;
    Data(11 downto 8)<="1111";
    Data(7 downto 4)<="1111";
    Data(3 downto 0)<="1111";
    
when "11" =>
    Data(31 downto 28)<=ora_zeci;
    Data(27 downto 24)<=ora_unit;
    Data(23 downto 20)<="1010";
    Data(19 downto 16)<=min_zeci;
    Data(15 downto 12)<=min_unit;
    Data(11 downto 8)<="1011";
    Data(7 downto 4)<=tc_zeci;
    Data(3 downto 0)<=tc_unit;
    
when others=>
    Data<=(others =>'1');
end case;               
end process;               


end Behavioral;
