LIBRARY ieee  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
ENTITY ula_tb  IS 
END ; 
 
ARCHITECTURE ula_tb_arch OF ula_tb IS
  SIGNAL flag_neg   :  std_logic  ; 
  SIGNAL flag_zero   :  std_logic  ; 
  SIGNAL control   :  std_logic_vector (1 downto 0) ; 
  SIGNAL value1   :  std_logic_vector (7 downto 0)  ; 
  SIGNAL result   :  std_logic_vector (7 downto 0)  ; 
  SIGNAL value2   :  std_logic_vector (7 downto 0)  ; 
  COMPONENT ula  
    PORT ( 
      flag_neg  : out std_logic ; 
      flag_zero  : out std_logic ; 
      control  : in  std_logic_vector (1 downto 0) ; 
      value1  : in std_logic_vector (7 downto 0) ; 
      result  : out std_logic_vector (7 downto 0) ; 
      value2  : in std_logic_vector (7 downto 0) ); 
  END COMPONENT ; 
BEGIN
  DUT  : ula  
    PORT MAP ( 
      flag_neg   => flag_neg  ,
      flag_zero   => flag_zero  ,
      control   => control  ,
      value1   => value1  ,
      result   => result  ,
      value2   => value2   ) ; 
      
      value1 <= x"00",
                x"02" after 100 ns,
                x"03" after 200 ns,
                x"05" after 300 ns;
                
      value2 <= x"FF",
                x"02" after 100 ns,
                x"03" after 200 ns,
                x"10" after 300 ns;
                  
      control <= "11" after 100 ns,
                 "11" after 200 ns,
                 "11" after 350 ns; 
      
END ; 

