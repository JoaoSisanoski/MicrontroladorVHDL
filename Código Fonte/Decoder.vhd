library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Descrição do Módulo Principal

-- Entradas e saídas do Decoder

entity Decoder is
    port
          (
             INSTR_IN    : in  std_logic_vector(15 downto 0);
             LOAD        : in std_logic;
             RESET       : in std_logic;
             COMMAND_OUT : out  std_logic_vector(3 downto 0);
             ADDRESS      : out std_logic_vector(7 downto 0)
           
           );
           
end Decoder;

architecture behavior of Decoder is
    
begin
    process(LOAD, INSTR_IN, RESET)
      begin
        if(RESET = '1') then
           ADDRESS <= x"00";
           COMMAND_OUT <= x"0";
           
        elsif(LOAD'event and LOAD = '1') then 
             
         ADDRESS <= INSTR_IN(7 downto 0);
         
         case INSTR_IN(15 downto 8) is
	         when x"00" => COMMAND_OUT <= x"1"; -- LDA
	         when x"01" => COMMAND_OUT <= x"2"; -- STA
	         when x"02" => COMMAND_OUT <= x"3"; -- ADD
	         when x"03" => COMMAND_OUT <= x"4"; -- AND
	         when x"04" => COMMAND_OUT <= x"5"; -- JMP
	         when x"05" => COMMAND_OUT <= x"6"; -- BRN
	         when x"06" => COMMAND_OUT <= x"7"; -- BRZ
	         when x"FF" => COMMAND_OUT <= x"F"; -- HALT
	         when others  => COMMAND_OUT <= x"F";
       end case;
         
        end if;
   end process;
          
end behavior;
                
        
                
