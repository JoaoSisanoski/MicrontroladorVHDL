library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

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
          CARRY <= B when ((A xor B) = '0') else C;
end behavior;
    


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Descrição do Módulo Principal

-- Entradas e saídas da ULA

entity ULA is
    port
          (
             VALUE1    : in  std_logic_vector(7 downto 0);
             VALUE2    : in  std_logic_vector(7 downto 0);
             CONTROL   : in  std_logic;
             FLAG_ZERO : out std_logic;
             FLAG_NEG  : out std_logic;
             RESULT    : out std_logic_vector(7 downto 0)
           
           );
end ULA;

architecture behavior of ULA is
    
signal SUM_AUX, CARRY_AUX: std_logic_vector(7 downto 0);

component FA 
	port 
	   (
			   A, B, C: in std_logic; -- ENTRADAS -> VALOR 1, VALOR 2, CARRY-IN
			   SOMA, CARRY: out std_logic -- SAIDAS -> RESULTADO DA SOMA, CARRY-OUT
			   
		 ); 
end component;

begin

   FA1: FA port map (VALUE2(0), VALUE1(0), '0'     , SUM_AUX(0), CARRY_AUX(0));
	FA2: FA port map (VALUE2(1), VALUE1(1), CARRY_AUX(0), SUM_AUX(1), CARRY_AUX(1));
	FA3: FA port map (VALUE2(2), VALUE1(2), CARRY_AUX(1), SUM_AUX(2), CARRY_AUX(2));
	FA4: FA port map (VALUE2(3), VALUE1(3), CARRY_AUX(2), SUM_AUX(3), CARRY_AUX(3));
	FA5: FA port map (VALUE2(4), VALUE1(4), CARRY_AUX(3), SUM_AUX(4), CARRY_AUX(4));
	FA6: FA port map (VALUE2(5), VALUE1(5), CARRY_AUX(4), SUM_AUX(5), CARRY_AUX(5));
	FA7: FA port map (VALUE2(6), VALUE1(6), CARRY_AUX(5), SUM_AUX(6), CARRY_AUX(6));
	FA8: FA port map (VALUE2(7), VALUE1(7), CARRY_AUX(6), SUM_AUX(7), CARRY_AUX(7));
	

        
        process (CONTROL, VALUE1, VALUE2)  
           begin
                   if(CONTROL = '0') then -- Operação de soma
                       RESULT <= SUM_AUX;
                    elsif(CONTROL = '1') then -- Operaçao AND
                        RESULT <= VALUE1 and VALUE2;
                   end if;
        end process;
        
        process (VALUE1, VALUE2, CONTROL)
            begin
                    if(CONTROL = '0') then
                        FLAG_NEG <= SUM_AUX(7);
                    else
                        FLAG_NEG <= '0';
                    end if;
                    
                    if((VALUE1 and VALUE2) = x"00" and CONTROL = '1') then
                        FLAG_ZERO <= '1';
                    else 
                        FLAG_ZERO <= '0';
                    end if;
        end process;
                       
end behavior;

