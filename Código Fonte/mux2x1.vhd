library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entradas e saídas do Mux 2x1

entity mux2x1 is
   port
        (
           D1 : in std_logic_vector(7 downto 0); -- Entrada 1, vindo da ULA
           D2 : in std_logic_vector(7 downto 0); -- Entrada 2, vindo da memória
           CONTROLE: in std_logic; 
           Q   : out std_logic_vector(7 downto 0)
        
        );
        
end mux2x1;

architecture behavior of mux2x1 is
   begin
       process(D1, D2, CONTROLE)
           begin
                if(CONTROLE = '0') then
                    Q <= D2;
                elsif(CONTROLE = '1') then
                    Q <= D1;
                end if;
        end process;
end behavior;
