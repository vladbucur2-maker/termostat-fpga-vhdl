----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2026 15:00:17
-- Design Name: 
-- Module Name: UE_Termostat - Behavioral
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

entity UE_Termostat is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           load_clk     : in  STD_LOGIC;
           load_temp    : in  STD_LOGIC;
           reset_clk    : in  STD_LOGIC;
           reset_temp   : in  STD_LOGIC;
           centrala     : in  STD_LOGIC;
           ora_set      : in  STD_LOGIC_VECTOR(4 downto 0);
           inc_ora      : in  STD_LOGIC;
           dec_ora      : in  STD_LOGIC;
           inc_min      : in  STD_LOGIC;
           dec_min      : in  STD_LOGIC;
           inc_tmin     : in  STD_LOGIC;
           dec_tmin     : in  STD_LOGIC;
           inc_tmax     : in  STD_LOGIC;
           dec_tmax     : in  STD_LOGIC;
           disp_mode    : in  STD_LOGIC_VECTOR(1 downto 0);
           set_tmax     : in  STD_LOGIC;
           btnc_db      : in  STD_LOGIC;
           tc_sub_min   : out STD_LOGIC;
           tc_peste_max : out STD_LOGIC;
           Catozi       : out STD_LOGIC_VECTOR(7 downto 0);
           Anozi        : out STD_LOGIC_VECTOR(7 downto 0));
end UE_Termostat;

architecture Behavioral of UE_Termostat is

    

    component ram_Tmin is
        Port (
            clk      : in  STD_LOGIC;
            rst      : in  STD_LOGIC;
            Load     : in  STD_LOGIC;
            Wr_addr  : in  STD_LOGIC_VECTOR(4 downto 0);
            Data_in  : in  STD_LOGIC_VECTOR(5 downto 0);
            Rd_addr  : in  STD_LOGIC_VECTOR(4 downto 0);
            Data_out : out STD_LOGIC_VECTOR(5 downto 0)
        );
    end component;

    component RAM_Tmax is
        Port (
            clk      : in  STD_LOGIC;
            rst      : in  STD_LOGIC;
            Load     : in  STD_LOGIC;
            wr_addr  : in  STD_LOGIC_VECTOR(4 downto 0);
            Data_in  : in  STD_LOGIC_VECTOR(5 downto 0);
            Rd_addr  : in  STD_LOGIC_VECTOR(4 downto 0);
            Data_out : out STD_LOGIC_VECTOR(5 downto 0)
        );
    end component;
    
     component Ceas_ore_min is
        Port (
            clk       : in  STD_LOGIC;
            rst       : in  STD_LOGIC;
            clk_1min  : in  STD_LOGIC;
            reset_clk : in  STD_LOGIC;
            load_clk  : in  STD_LOGIC;
            inc_ora   : in  STD_LOGIC;
            dec_ora   : in  STD_LOGIC;
            inc_min   : in  STD_LOGIC;
            dec_min   : in  STD_LOGIC;
            Ora       : out STD_LOGIC_VECTOR(4 downto 0);
            Minut     : out STD_LOGIC_VECTOR(5 downto 0)
        );
    end component;
    
    component contor_ora is
        Port (
            clk       : in  STD_LOGIC;
            rst       : in  STD_LOGIC;
            clk_1ora  : in  STD_LOGIC;
            reset_ora : in  STD_LOGIC;
            ora_cur   : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;
    
    component SimulareTC is
        Port (
            Clk      : in  STD_LOGIC;
            Rst      : in  STD_LOGIC;
            CLK_1s   : in  STD_LOGIC;
            CLK_3s   : in  STD_LOGIC;
            Centrala : in  STD_LOGIC;
            Tc       : out STD_LOGIC_VECTOR(5 downto 0)
        );
    end component;

    component ClockDivider is
        Port (
            Clk      : in  STD_LOGIC;
            Rst      : in  STD_LOGIC;
            Clk_1min : out STD_LOGIC;
            Clk_1s   : out STD_LOGIC;
            Clk_3s   : out STD_LOGIC
        );
    end component;
    
     component Display_Mux is
        Port (
            Disp_mode : in  STD_LOGIC_VECTOR(1 downto 0);
            Ora       : in  STD_LOGIC_VECTOR(4 downto 0);
            Minut     : in  STD_LOGIC_VECTOR(5 downto 0);
            Tc        : in  STD_LOGIC_VECTOR(5 downto 0);
            ora_set   : in  STD_LOGIC_VECTOR(4 downto 0);
            Tmin_set  : in  STD_LOGIC_VECTOR(5 downto 0);
            Tmax_set  : in  STD_LOGIC_VECTOR(5 downto 0);
            set_tmax  : in  STD_LOGIC;
            Data      : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    
    component ssd_driver is
        Port (
            Rst      : in  STD_LOGIC;
            Clk      : in  STD_LOGIC;
            Data     : in  STD_LOGIC_VECTOR(31 downto 0);
            catozi : out STD_LOGIC_VECTOR(7 downto 0);
            anozi   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component MPG is
        Port (
            btn : in  STD_LOGIC;
            clk : in  STD_LOGIC;
            en  : out STD_LOGIC
        );
    end component;
    
    component registru_Tmin is
        Port (
            Clk      : in  STD_LOGIC;
            Rst      : in  STD_LOGIC;
            Inc_Tmin : in  STD_LOGIC;
            Dec_Tmin : in  STD_LOGIC;
            Load     : in  STD_LOGIC;
            Data_in  : in  STD_LOGIC_VECTOR(5 downto 0);
            Tmin_val : out STD_LOGIC_VECTOR(5 downto 0)
        );
    end component;

    component registru_Tmax is
        Port (
            Clk      : in  STD_LOGIC;
            Rst      : in  STD_LOGIC;
            Inc_Tmax : in  STD_LOGIC;
            Dec_Tmax : in  STD_LOGIC;
            Load     : in  STD_LOGIC;
            Data_in  : in  STD_LOGIC_VECTOR(5 downto 0);
            Tmax_val : out STD_LOGIC_VECTOR(5 downto 0)
        );
    end component;

    component Comparator_Tmin is
        Port (
            Tc         : in  STD_LOGIC_VECTOR(5 downto 0);
            Tmin_cur   : in  STD_LOGIC_VECTOR(5 downto 0);
            Tc_sub_min : out STD_LOGIC
        );
    end component;

    component Comparator_Tmax is
        Port (
            Tc           : in  STD_LOGIC_VECTOR(5 downto 0);
            Tmax_cur     : in  STD_LOGIC_VECTOR(5 downto 0);
            Tc_peste_max : out STD_LOGIC
        );
    end component;
   
   signal clk_1min :std_logic;
   signal clk_1s: std_logic;
   signal clk_3s: std_logic;
   signal clk_1ora:std_logic;
   
   signal tc:std_logic_vector(5 downto 0);
   signal tmin_cur:std_logic_vector(5 downto 0);
   signal tmax_cur: std_logic_vector(5 downto 0);
   signal ora:std_logic_vector(4 downto 0);
   signal minut :std_logic_vector(5 downto 0);
   signal ora_cur:std_logic_vector(4 downto 0);
   
   signal tmin_val: std_logic_vector(5 downto 0);
   signal tmax_val: std_logic_vector(5 downto 0);
   
   signal display_data:std_logic_vector(31 downto 0);
   signal ora_set_prev : std_logic_vector(4 downto 0) := (others => '0');
   signal load_reg     : std_logic := '0';
   
   signal tmin_disp : std_logic_vector(5 downto 0);
   signal tmax_disp : std_logic_vector(5 downto 0);
   signal ora_disp  : std_logic_vector(4 downto 0);
   
begin

    clk_1ora<=clk_1min when(unsigned(minut)=59) else '0';
    tmin_disp <= tmin_val when disp_mode = "10" else tmin_cur;
    tmax_disp <= tmax_val when disp_mode = "10" else tmax_cur;
    ora_disp  <= ora_set  when disp_mode = "10" else ora_cur;

process(clk, rst)
begin
    if rst = '1' then
        ora_set_prev <= (others => '0');
        load_reg     <= '0';
    elsif rising_edge(clk) then
        load_reg <= '0';
        if ora_set /= ora_set_prev then
            load_reg     <= '1';
            ora_set_prev <= ora_set;
        end if;
    end if;
end process;   

clk_div:ClockDivider
    port map(
            clk =>clk,
            rst =>rst,
            clk_1min=>clk_1min,
            clk_1s=>clk_1s,
            clk_3s=>clk_3s);
            
        
reg_tmin:registru_Tmin
    port map(
             clk=>clk,
             rst=>rst,
             inc_Tmin=>inc_tmin,
             dec_Tmin=>dec_tmin,
             load => load_reg,
             data_in=>tmin_cur,
             Tmin_val=>tmin_val);                             

reg_tmax:registru_Tmax
    port map(
             clk=>clk,
             rst=>rst,
             inc_Tmax=>inc_tmax,
             dec_Tmax=>dec_tmax,
             load => load_reg,
             data_in=>tmax_cur,
             Tmax_val=>tmax_val);
             
ram_tmin_inst:ram_Tmin
    port map(
             clk=>clk,
             rst=>reset_temp,
             wr_addr=>ora_set,
             load => load_temp, 
             data_in=>tmin_val,
             rd_addr=>ora_cur,
             data_out=>tmin_cur);
             
ram_tmax_inst:RAM_Tmax
    port map(
             clk=>clk,
             rst=>reset_temp,
             load=>load_temp,
             wr_addr=>ora_set,
             data_in=>tmax_val,
             rd_addr=>ora_cur,
             data_out=>tmax_cur);
             
ceas:Ceas_ore_min
    port map(
             clk=>clk,
             rst=>rst,
             clk_1min=>clk_1min,
             reset_clk=>reset_clk,
             load_clk=>load_clk,
             inc_ora=>inc_ora,
             dec_ora=>dec_ora,
             inc_min=>inc_min,
             dec_min=>dec_min,
             ora=>ora,
             minut=>minut);
             
contor:contor_ora
    port map(
             clk=>clk,
             rst=>rst,
             clk_1ora=>clk_1ora,
             reset_ora=>reset_clk,
             ora_cur=>ora_cur);
             
sim_tc :SimulareTC
    port map(
             clk=>clk,
             rst=>rst,
             clk_1s=>clk_1s,
             clk_3s=>clk_3s,
             centrala=>centrala,
             Tc=>tc);
             
comp_tmin:Comparator_Tmin
    port map(
             Tc=>tc,
             Tmin_cur=>tmin_cur,
             Tc_sub_min=>tc_sub_min);
             
comp_tmax:Comparator_Tmax
    port map(
             Tc=>tc,
             Tmax_cur=>tmax_cur,
             Tc_peste_max=>tc_peste_max);
             
disp_mux:Display_Mux
    port map(
             Disp_mode =>disp_mode,
             ora=>ora,
             minut=>minut,
             Tc=>tc,
             ora_set  => ora_disp,
             Tmin_set => tmin_disp,
             Tmax_set => tmax_disp,
             set_tmax=>set_tmax,
             data=>display_data);
             
ssd:ssd_driver
    port map(
             rst =>rst,
             clk=>clk,
             data=>display_data,
             catozi=>catozi,
             anozi=>anozi);                                                                
                                                    
end Behavioral;
