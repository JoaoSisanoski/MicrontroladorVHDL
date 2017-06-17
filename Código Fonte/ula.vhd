library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Descri��o do M�dulo Principal

-- Entradas e sa�das do FA


    


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Descri��o do M�dulo Principal

-- Entradas e sa�das da ULA

entity ULA is
    port
          (
             VALUE1    : in  std_logic_vector(7 downto 0);
             VALUE2    : in  std_logic_vector(7 downto 0);
             CONTROL   : in std_logic_vector(1 downto 0);
             FLAG_ZERO : out std_logic;
             FLAG_NEG  : out std_logic;
             RESULT    : out std_logic_vector(7 downto 0)
           
           );
end ULA;

architecture behavior of ULA is
    
signal SUM_AUX, CARRY_AUX: std_logic_vector(7 downto 0);

signal SUB_AUX, CARRYS_AUX: std_logic_vector(7 downto 0);

signal  MUL_AUX: std_logic_vector(15 downto 0);

component FA 
	port 
	   (
			   A, B, C: in std_logic; -- ENTRADAS -> VALOR 1, VALOR 2, CARRY-IN
			   SOMA, CARRY: out std_logic -- SAIDAS -> RESULTADO DA SOMA, CARRY-OUT
			   
		 ); 
end component;

begin

   FA1: FA port map (VALUE2(0), VALUE1(0), '0'         , SUM_AUX(0), CARRY_AUX(0));
	FA2: FA port map (VALUE2(1), VALUE1(1), CARRY_AUX(0), SUM_AUX(1), CARRY_AUX(1));
	FA3: FA port map (VALUE2(2), VALUE1(2), CARRY_AUX(1), SUM_AUX(2), CARRY_AUX(2));
	FA4: FA port map (VALUE2(3), VALUE1(3), CARRY_AUX(2), SUM_AUX(3), CARRY_AUX(3));
	FA5: FA port map (VALUE2(4), VALUE1(4), CARRY_AUX(3), SUM_AUX(4), CARRY_AUX(4));
	FA6: FA port map (VALUE2(5), VALUE1(5), CARRY_AUX(4), SUM_AUX(5), CARRY_AUX(5));
	FA7: FA port map (VALUE2(6), VALUE1(6), CARRY_AUX(5), SUM_AUX(6), CARRY_AUX(6));
	FA8: FA port map (VALUE2(7), VALUE1(7), CARRY_AUX(6), SUM_AUX(7), CARRY_AUX(7));
	FS1: FA port map (VALUE2(0), "not"(VALUE1(0)), '1'          , SUB_AUX(0), CARRYS_AUX(0));
	FS2: FA port map (VALUE2(1), "not"(VALUE1(1)), CARRYS_AUX(0), SUB_AUX(1), CARRYS_AUX(1));
	FS3: FA port map (VALUE2(2), "not"(VALUE1(2)), CARRYS_AUX(1), SUB_AUX(2), CARRYS_AUX(2));
	FS4: FA port map (VALUE2(3), "not"(VALUE1(3)), CARRYS_AUX(2), SUB_AUX(3), CARRYS_AUX(3));
	FS5: FA port map (VALUE2(4), "not"(VALUE1(4)), CARRYS_AUX(3), SUB_AUX(4), CARRYS_AUX(4));
	FS6: FA port map (VALUE2(5), "not"(VALUE1(5)), CARRYS_AUX(4), SUB_AUX(5), CARRYS_AUX(5));
	FS7: FA port map (VALUE2(6), "not"(VALUE1(6)), CARRYS_AUX(5), SUB_AUX(6), CARRYS_AUX(6));
	FS8: FA port map (VALUE2(7), "not"(VALUE1(7)), CARRYS_AUX(6), SUB_AUX(7), CARRYS_AUX(7));

        
        process (CONTROL, VALUE1, VALUE2)  
           begin
                   if(CONTROL = "00") then -- Opera��o de soma
                       RESULT <= SUM_AUX;
                    elsif(CONTROL = "01") then -- Opera�ao AND
                        RESULT <= VALUE1 and VALUE2;
						  elsif(CONTROL = "10") then -- Opera��o de sub
                       RESULT <= SUB_AUX;
                    elsif(CONTROL = "11") then -- Opera�ao mul
							  MUL_AUX <= std_logic_vector(unsigned(VALUE2) * unsigned(VALUE1));
							  RESULT <= MUL_AUX(7 downto 0);
                   end if;
        end process;
        
        process (VALUE1, VALUE2, CONTROL)
            begin
                    if(CONTROL = "00" ) or (CONTROL = "10") then
                        FLAG_NEG <= SUM_AUX(7);
                    else
                        FLAG_NEG <= '0';
                    end if;
                    
                    if((VALUE1 and VALUE2) = x"00" and CONTROL = "01") then
                        FLAG_ZERO <= '1';
                    else 
                        FLAG_ZERO <= '0';
                    end if;
        end process;
                       
end behavior;

