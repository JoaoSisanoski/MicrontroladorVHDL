LIBRARY ieee  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
ENTITY mux2x1_tb  IS 
END ; 
 
ARCHITECTURE mux2x1_tb_arch OF mux2x1_tb IS
  SIGNAL q   :  std_logic_vector (7 downto 0)  ; 
  SIGNAL d1   :  std_logic_vector (7 downto 0)  ; 
  SIGNAL controle   :  std_logic  ; 
  SIGNAL d2   :  std_logic_vector (7 downto 0)  ; 
  COMPONENT mux2x1  
    PORT ( 
      q  : out std_logic_vector (7 downto 0) ; 
      d1  : in std_logic_vector (7 downto 0) ; 
      controle  : in std_logic ; 
      d2  : in std_logic_vector (7 downto 0) ); 
  END COMPONENT ; 
BEGIN
  DUT  : mux2x1  
    PORT MAP ( 
      q   => q  ,
      d1   => d1  ,
      controle   => controle  ,
      d2   => d2   ) ; 
      
      
      d1 <= x"FF" after 10 ns;
      d2 <= x"00" after 10 ns;
      controle <= '0' after 50 ns,
                  not controle after 100 ns;
      
END ; 

