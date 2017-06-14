library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entradas e saídas do Acumulador

entity Accumulator is
   port
        (
           CLOCK: in std_logic; -- Load vindo da FSM
           RESET: in std_logic;
           VALUE_IN: in std_logic_vector(7 downto 0);
           VALUE_OUT: out std_logic_vector(7 downto 0)
        );
        
end Accumulator;

architecture behavior of Accumulator is
   begin
       process(CLOCK, RESET, VALUE_IN)
           begin
               if(RESET = '1') then
                  VALUE_OUT <= x"00";
               elsif(CLOCK'event and CLOCK = '1') then
                  VALUE_OUT <= VALUE_IN;
               end if;
        end process;
end behavior;
