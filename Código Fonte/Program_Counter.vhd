library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entradas e sa�das do Program Counter

entity Program_Counter is
    port
        (
           CLOCK: in std_logic; -- Load vindo da FSM
           CONTROL_JMP: in std_logic; -- Load para o JMP
           RESET: in std_logic; -- Reset
           JMP  : in std_logic_vector(7 downto 0); -- Endere�o de memoria vindo da instru�ao JMP
           POS  : out std_logic_vector(7 downto 0) -- Posi�ao de memoria
           
         );
end Program_Counter;

-- Descri��o do comportamento do m�dulo principal

architecture behavior of Program_Counter is
   
signal POS_AUX : std_logic_vector(7 downto 0);

   begin
        process(CLOCK, RESET)   
          begin
            if(RESET = '1') then
              POS_AUX <= x"00";
            elsif(CLOCK'event and CLOCK = '1') then
                   POS_AUX <= POS_AUX+'1';
               if(CONTROL_JMP = '1') then
                      POS_AUX <= JMP;  
               end if;
           end if;
        end process;
        
        process(POS_AUX)
            begin
                POS <= POS_AUX;
            end process;
        
    
        
end behavior;