library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entradas e saídas do Instruction Register

entity Instruction_Register is
    port
        (
           LOAD: in std_logic; -- Load vindo da FSM
           RESET: in std_logic; -- Reset
           PINSTRUCTION: out std_logic_vector(15 downto 0); -- Instruçao em uso
           NINSTRUCTION: in std_logic_vector(15 downto 0) -- Proxima instruçao
           
         );
end Instruction_Register;

-- Descrição do comportamento do módulo principal

architecture behavior of Instruction_Register is
 
   begin
       
    process (LOAD, NINSTRUCTION, RESET)  
        begin
            if(RESET = '1') then
                PINSTRUCTION <= x"0000";
               elsif(LOAD'event and LOAD = '1') then
                   PINSTRUCTION <= NINSTRUCTION; 
            end if;
    end process;
        
end behavior;
