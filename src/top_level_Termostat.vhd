----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2026 16:48:46
-- Design Name: 
-- Module Name: top_level_Termostat - Behavioral
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

entity top_level_Termostat is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           BTNU : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNR : in STD_LOGIC;
           BTNL : in STD_LOGIC;
           SW0 : in STD_LOGIC;
           SW1 : in STD_LOGIC;
           SW2:  in STD_LOGIC;
           SW3 : in STD_LOGIC;
           Catozi : out STD_LOGIC_VECTOR (7 downto 0);
           Anozi : out STD_LOGIC_VECTOR (7 downto 0);
           Led_Centrala : out STD_LOGIC);
end top_level_Termostat;

architecture Behavioral of top_level_Termostat is

    component UC_Termostat is
        Port (
            Clk          : in  STD_LOGIC;
            Rst          : in  STD_LOGIC;
            BTNC         : in  STD_LOGIC;
            BTNU         : in  STD_LOGIC;
            BTND         : in  STD_LOGIC;
            BTNR         : in  STD_LOGIC;
            BTNL         : in  STD_LOGIC;
            Sw0          : in  STD_LOGIC;
            Sw1          : in  STD_LOGIC;
            Sw2          : in  STD_LOGIC;
            Sw3          : in  STD_LOGIC;
            Tc_sub_min   : in  STD_LOGIC;
            Tc_peste_max : in  STD_LOGIC;
            Load_CLK     : out STD_LOGIC;
            Load_TEMP    : out STD_LOGIC;
            Centrala     : out STD_LOGIC;
            Led_Centrala : out STD_LOGIC;
            Reset_CLK    : out STD_LOGIC;
            Reset_TEMP   : out STD_LOGIC;
            ora_set_out  : out STD_LOGIC_VECTOR(4 downto 0);
            Inc_ora      : out STD_LOGIC;
            Dec_ora      : out STD_LOGIC;
            Inc_min      : out STD_LOGIC;
            Dec_min      : out STD_LOGIC;
            Inc_Tmin     : out STD_LOGIC;
            Dec_Tmin     : out STD_LOGIC;
            Inc_Tmax     : out STD_LOGIC;
            Dec_Tmax     : out STD_LOGIC;
            Disp_mode    : out STD_LOGIC_VECTOR(1 downto 0);
            set_tmax_out : out STD_LOGIC;
            dbg_stare    : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;
    
    component UE_Termostat is
        Port (
            clk          : in  STD_LOGIC;
            rst          : in  STD_LOGIC;
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
            Anozi        : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
    
    component MPG is
        Port (
            btn : in  STD_LOGIC;
            clk : in  STD_LOGIC;
            en  : out STD_LOGIC
        );
    end component;    

    signal rst_int       : STD_LOGIC;
    signal btnc_db       : STD_LOGIC;
    signal btnu_db       : STD_LOGIC;
    signal btnd_db       : STD_LOGIC;
    signal btnr_db       : STD_LOGIC;
    signal btnl_db       : STD_LOGIC;
    
    signal load_clk      : STD_LOGIC;
    signal load_temp     : STD_LOGIC;
    signal reset_clk     : STD_LOGIC;
    signal reset_temp    : STD_LOGIC;
    signal centrala      : STD_LOGIC;
    signal ora_set       : STD_LOGIC_VECTOR(4 downto 0);
    signal inc_ora       : STD_LOGIC;
    signal dec_ora       : STD_LOGIC;
    signal inc_min       : STD_LOGIC;
    signal dec_min       : STD_LOGIC;
    signal inc_tmin      : STD_LOGIC;
    signal dec_tmin      : STD_LOGIC;
    signal inc_tmax      : STD_LOGIC;
    signal dec_tmax      : STD_LOGIC;
    signal disp_mode     : STD_LOGIC_VECTOR(1 downto 0);
    signal dbg_stare     : STD_LOGIC_VECTOR(2 downto 0);
    
    signal tc_sub_min    : STD_LOGIC;
    signal tc_peste_max  : STD_LOGIC;
    
    signal set_tmax_mode : STD_LOGIC := '0';
    
begin

    rst_int <=  Rst;
    
    mpg_c: MPG port map (btn => BTNC, clk => CLK, en => btnc_db);
    mpg_u: MPG port map (btn => BTNU, clk => CLK, en => btnu_db);
    mpg_d: MPG port map (btn => BTND, clk => CLK, en => btnd_db);
    mpg_r: MPG port map (btn => BTNR, clk => CLK, en => btnr_db);
    mpg_l: MPG port map (btn => BTNL, clk => CLK, en => btnl_db);

uc: UC_Termostat
        port map (
            Clk          => CLK,
            Rst          => rst_int,
            BTNC         => btnc_db,
            BTNU         => btnu_db,
            BTND         => btnd_db,
            BTNR         => btnr_db,
            BTNL         => btnl_db,
            Sw0          => SW0,
            Sw1          => SW1,
            Sw2          => SW2,
            Sw3          => SW3,
            Tc_sub_min   => tc_sub_min,
            Tc_peste_max => tc_peste_max,
            Load_CLK     => load_clk,
            Load_TEMP    => load_temp,
            Centrala     => centrala,
            Led_Centrala => Led_Centrala,
            Reset_CLK    => reset_clk,
            Reset_TEMP   => reset_temp,
            ora_set_out  => ora_set,
            Inc_ora      => inc_ora,
            Dec_ora      => dec_ora,
            Inc_min      => inc_min,
            Dec_min      => dec_min,
            Inc_Tmin     => inc_tmin,
            Dec_Tmin     => dec_tmin,
            Inc_Tmax     => inc_tmax,
            Dec_Tmax     => dec_tmax,
            Disp_mode    => disp_mode,
            set_tmax_out => set_tmax_mode,
            dbg_stare    => dbg_stare
        );
        
        ue: UE_Termostat
        port map (
            clk          => CLK,
            rst          => rst_int,
            load_clk     => load_clk,
            load_temp    => load_temp,
            reset_clk    => reset_clk,
            reset_temp   => reset_temp,
            centrala     => centrala,
            ora_set      => ora_set,
            inc_ora      => inc_ora,
            dec_ora      => dec_ora,
            inc_min      => inc_min,
            dec_min      => dec_min,
            inc_tmin     => inc_tmin,
            dec_tmin     => dec_tmin,
            inc_tmax     => inc_tmax,
            dec_tmax     => dec_tmax,
            disp_mode    => disp_mode,
            set_tmax     => set_tmax_mode,
            btnc_db      => btnc_db,
            tc_sub_min   => tc_sub_min,
            tc_peste_max => tc_peste_max,
            Catozi       => Catozi,
            Anozi        => Anozi
        );

end Behavioral;
