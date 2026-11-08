
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2026 15:17:54
-- Design Name: 
-- Module Name: simulare_UC - Behavioral
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

entity simulare_UC is
--  Port ( );
end simulare_UC;

architecture Behavioral of simulare_UC is
    component UC_Termostat
            Port ( Clk : in STD_LOGIC;
                   Rst : in STD_LOGIC;
                   BTNC : in STD_LOGIC;
                   BTNU : in STD_LOGIC;
                   BTND : in STD_LOGIC;
                   BTNR : in STD_LOGIC;
                   BTNL : in STD_LOGIC;
                   Sw0 : in STD_LOGIC;
                   Sw1 : in STD_LOGIC;
                   Sw2 : in STD_LOGIC;
                   Sw3 : in STD_LOGIC;
                   Tc_sub_min   : in STD_LOGIC;
                   Tc_peste_max : in STD_LOGIC;
                   Load_CLK : out STD_LOGIC;
                   Load_TEMP : out STD_LOGIC;
                   Centrala : out STD_LOGIC;
                   Led_Centrala : out STD_LOGIC;
                   Reset_CLK : out STD_LOGIC;
                   Reset_TEMP : out STD_LOGIC;
                   ora_set_out : out STD_LOGIC_VECTOR(4 downto 0);
                   Inc_ora : out STD_LOGIC;
                   Dec_ora : out STD_LOGIC;
                   Inc_min : out STD_LOGIC;
                   Dec_min : out STD_LOGIC;
                   Inc_Tmin : out STD_LOGIC;
                   Dec_Tmin : out STD_LOGIC;
                   Inc_Tmax : out STD_LOGIC;
                   Dec_Tmax : out STD_LOGIC;
                   Disp_mode : out STD_LOGIC_VECTOR (1 downto 0);
                   dbg_stare   : out STD_LOGIC_VECTOR(2 downto 0));
    end component;
    
    signal clk: std_logic:='0';
    signal rst:std_logic:='0';
    signal BTNC:std_logic:='0';
    signal BTNU:std_logic:='0';
    signal BTND:std_logic:='0';
    signal BTNR:std_logic:='0';
    signal BTNL:std_logic:='0';
    signal SW0:std_logic:='0';
    signal Tc_sub_min   : std_logic := '0';
    signal Tc_peste_max : std_logic := '0';
    signal SW1 : std_logic := '0';
    signal SW2 : std_logic := '0';
    signal SW3 : std_logic := '0';
    signal Load_clk:std_logic;
    signal Load_TEMP:std_logic;
    signal Reset_clk:std_logic;
    signal Centrala:std_logic;
    signal ora_set_out:std_logic_vector(4 downto 0);
    signal Inc_ora:std_logic;
    signal Dec_ora:std_logic;
    signal Inc_min:std_logic;
    signal Dec_min:std_logic;
    signal Inc_Tmin:std_logic;
    signal Dec_Tmin:std_logic;
    signal Inc_Tmax:std_logic;
    signal Dec_Tmax:std_logic;
    signal Disp_mode:std_logic_vector(1 downto 0);
    signal dbg_stare:std_logic_vector(2 downto 0);
    
    
begin

TERMOSTAT:UC_Termostat
        port map(
                 clk=>clk,
                 rst=>rst,
                 BTNC=>BTNC,
                 BTNU=>BTNU,
                 BTND=>BTND,
                 BTNL=>BTNL,
                 BTNR=>BTNR,
                 SW0=>SW0,
                 Tc_sub_min   => Tc_sub_min,
                 Tc_peste_max => Tc_peste_max,
                 Sw1 => SW1,
                 Sw2 => SW2,
                 Sw3 => SW3,
                 Load_clk=>Load_clk,
                 Load_temp=>Load_temp,
                 Centrala=>Centrala,
                 Led_Centrala => open,
                 Reset_clk=>Reset_clk,
                 Reset_TEMP => open,
                 ora_set_out=>ora_set_out,
                 Inc_ora=>Inc_ora,
                 Dec_ora=>Dec_ora,
                 Inc_min=>Inc_min,
                 Dec_min=>Dec_min,
                 Inc_Tmin =>Inc_Tmin,
                 Dec_Tmin =>Dec_Tmin,
                 Inc_Tmax=>Inc_Tmax,
                 Dec_Tmax=>Dec_Tmax,
                 Disp_mode=>Disp_mode,
                 dbg_stare=>dbg_stare);
                 
  clk <= not clk after 5 ns;
  
  process
  begin
  
        rst<='1';
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        rst<='0';
        wait until rising_edge(clk);
        
        SW0<='1';
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        SW0<='0';
        wait until rising_edge(clk);
        
        BTNC<='1';
        wait until rising_edge(clk);
        BTNC<='0';
        wait until rising_edge(clk);
        
        BTNR <='1';
        wait until rising_edge(clk);
        BTNR<='0';
        wait until rising_edge(clk);
        
        BTNL <='1';
        wait until rising_edge(clk);
        BTNL <='0';
        wait until rising_edge(clk);
        
        BTNU<='1';
        wait until rising_edge(clk);
        BTNU<='0';
        wait until rising_edge(clk);
        
        BTND<='1';
        wait until rising_edge(clk);
        BTND<='0';
        wait until rising_edge(clk);
        
        BTNC<='1';
        wait until rising_edge(clk);
        BTNC<='0';
        wait until rising_edge(clk);
        
        BTNR <='1';
        wait until rising_edge(clk);
        BTNR <='0';
        wait until rising_edge(clk);
        
        BTNL<='1';
        wait until rising_edge(clk);
        BTNL<='0';
        wait until rising_edge(clk);
        
        BTNC<='1';
        wait until rising_edge(clk);
        BTNC<='0';
        wait until rising_edge(clk);
        
        BTNR<='1';
        wait until rising_edge(clk);
        BTNR<='0';
        wait until rising_edge(clk);
        
        BTNL<='1';
        wait until rising_edge(clk);
        BTNL<='0';
        wait until rising_edge(clk);
        
        BTNC<='1';
        wait until rising_edge(clk);
        BTNC<='0';
        wait until rising_edge(clk);
        
        for i in 1 to 23 loop
            BTNC <='1';
            wait until rising_edge(clk);
            BTNC <='0';
            wait until rising_edge(clk);
            BTNC<='1';
            wait until rising_edge(clk);
            BTNC<='0';
            wait until rising_edge(clk);
        end loop;
        
       
        
        Tc_sub_min <= '0'; Tc_peste_max <= '0';
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        
        Tc_sub_min <= '1'; Tc_peste_max <= '0';
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        
        Tc_sub_min <= '0'; Tc_peste_max <= '1';
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        
        Tc_sub_min <= '1'; Tc_peste_max <= '0';
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        
        Tc_sub_min <= '1'; Tc_peste_max <= '0';
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        
        Tc_sub_min <= '0'; Tc_peste_max <= '1';
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        
        wait;    
        
  end process;              

end Behavioral;
