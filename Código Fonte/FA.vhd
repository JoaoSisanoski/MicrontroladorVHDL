library ieee;
use ieee.std_logic_1164.all;

-- Descrição do Módulo Principal

-- Entradas e saídas do FA

entity FA is
	port 
	   (
			   A, B, C: in std_logic; -- ENTRADAS -> VALOR 1, VALOR 2, CARRY-IN
			   SOMA, CARRY: out std_logic -- SAIDAS -> RESULTADO DA SOMA, CARRY-OUT
			   
		 ); 
end FA;

architecture behavior of FA is
   begin
       SOMA <= (A xor B) xor C;
       CARRY <= B when ((A xor C) = '1') else C;
end behavior;
    