----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2026 19:15:21
-- Design Name: 
-- Module Name: UC_Termostat - Behavioral
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

entity UC_Termostat is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           BTNU : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNR : in STD_LOGIC;
           BTNL : in STD_LOGIC;
           Sw0 : in STD_LOGIC;
           Sw1: in std_logic;
           Sw2: in std_logic;
           Sw3:in std_logic;
           Tc_sub_min:in std_logic;
           Tc_peste_max:in std_logic;
           Load_CLK : out STD_LOGIC;
           Load_TEMP : out STD_LOGIC;
           Centrala : out STD_LOGIC;
           Led_Centrala:out std_logic;
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
           set_tmax_out : out STD_LOGIC;
           Disp_mode : out STD_LOGIC_VECTOR (1 downto 0);
           dbg_stare   : out STD_LOGIC_VECTOR(2 downto 0));
end UC_Termostat;

architecture Behavioral of UC_Termostat is
    type Stare_type is(A,B,C,D,E,F);
    
    signal stare:stare_type:=A;
    signal ora_set:unsigned(4 downto 0):=(others=>'0');
    signal set_tmax_mode:std_logic:='0';
    signal valid:std_logic;
    
begin
    
    ora_set_out<=std_logic_vector(ora_set);
    set_tmax_out <= set_tmax_mode;
    valid<='1' when Tc_sub_min='0' and Tc_peste_max='0' else '0';
    process(clk,rst)
    begin
        if rst='1' then 
            stare<=A;
            ora_set<=(others =>'0');
            set_tmax_mode<='0';
        elsif rising_edge(clk) then
            case stare is
                when A=>
                       if BTNC ='1' then
                            stare <=B;
                       else 
                            stare <=A;
                      end if ;      
                        
                when B=>
                        if BTNC='1' then
                            stare<=C;
                            ora_set<=(others =>'0');
                            set_tmax_mode<='0';
                         else 
                            stare <= B;   
                         end if;    
               
               when C=>
                        if BTNC = '1' then
                        if set_tmax_mode = '0' then
                            set_tmax_mode <= '1';
                            stare <= C;
                        else
                            set_tmax_mode <= '0';
                            if ora_set = to_unsigned(23, 5) then
                                stare <= D;
                            else
                                ora_set <= ora_set + 1;
                                stare   <= C;
                            end if;
                        end if;
                    else
                        stare <= C;
                    end if;                      
                           
         
                  when D =>
                    if valid = '1' then
                        stare <= D;
                    else
                       if Tc_sub_min ='1' then
                            stare<=F;
                       else
                            stare<=E ;    
                      end if;
                    end if;  
              when E =>
                        if Tc_sub_min='1' then
                               stare<=D;
                        else 
                                stare<=E;
                        end if;
              
              when F =>
                      if Tc_peste_max ='1' then
                                stare <=E;
                        else
                                stare <=F;
                        end if;    
                        
              when others =>
                    stare <=A;                                          
            
           end case; 
        end if;
            
    end process;

process(Rst,stare,BTNU,BTND,BTNR,BTNL,SW0,SW1,SW2,SW3,set_tmax_mode)
begin
        Load_CLK <='0';
        Load_TEMP <='0';
        Reset_Clk <='0';
        Reset_TEMP <= '0';
        Centrala <='0';
        Led_centrala<='0';
        Inc_ora <='0';
        Dec_ora <='0';
        Inc_min <='0';
        Dec_min <='0';
        Inc_Tmin <='0';
        Dec_Tmin <='0';
        Inc_Tmax <='0';
        Dec_Tmax <='0';
        Disp_mode <="00";

         if Rst ='1' then
            NULL;
         else
            case stare is
                when A =>
                        Disp_mode<="00";
                        if SW0='1' then
                            Reset_Clk <='1';
                            Reset_TEMP <='1';
                        end if;
                
                when B  =>
                          Load_CLK <='1';
                          Inc_ora <=BTNR;
                          Dec_ora <=BTNL;
                          Inc_min <=BTNU;
                          Dec_min <=BTND;
                          Disp_mode<="01";
                          
                          
                when C =>
                        Load_TEMP <='1';
                        if set_tmax_mode ='0' then
                            Inc_Tmin<=BTNR;
                            Dec_Tmin<=BTNL;
                        else
                            Inc_Tmax<=BTNR;
                            Dec_Tmax<=BTNL;
                        end if;
                        Disp_mode <="10";
                        
                        
                        
                 when D=>
                        Centrala <='0';
                        Disp_mode<="11";
                        
                 when E =>
                          Centrala <='0';
                          Led_Centrala<='0';
                          if SW3 ='1' then
                                Inc_Tmin<=BTNR;
                                Dec_Tmin<=BTNL;
                                Load_TEMP<=BTNC;
                                Disp_mode<="10";
                          else
                            Disp_mode <="11";          
                          end if;
                                                                  
                when F =>
                          Centrala <='1';
                          Led_Centrala<='1';
                          if SW3='1' then
                            Inc_Tmax<=BTNR;
                            Dec_Tmax<=BTNL;
                            Load_TEMP<=BTNC;
                            Disp_mode <= "10";
                          else  
                            Disp_mode<="11";
                            
                          end if;    
                when others=>
                            NULL;
                            
        end case;
 end if;                                     
end process;

process(stare)
    begin
        case stare is
            when A      => dbg_stare <= "000";
            when B      => dbg_stare <= "001";
            when C      => dbg_stare <= "010";
            when D      => dbg_stare <= "011";
            when E      => dbg_stare <= "100";
            when F      => dbg_stare <= "101";
            when others => dbg_stare <= "111";
        end case;
    end process;

end Behavioral;
