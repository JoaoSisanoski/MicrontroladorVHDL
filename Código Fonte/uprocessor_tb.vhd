LIBRARY ieee  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
ENTITY uprocessor_tb  IS 
END ; 
 
ARCHITECTURE uprocessor_tb_arch OF uprocessor_tb IS
  SIGNAL clock   :  std_logic  ; 
  SIGNAL reset   :  std_logic  ; 
  COMPONENT uprocessor  
    PORT ( 
      clock  : in std_logic ; 
      reset  : in std_logic ); 
  END COMPONENT ; 
BEGIN
  DUT  : uprocessor  
    PORT MAP ( 
      clock   => clock  ,
      reset   => reset   ) ; 
      
      clock <= '1' after 20 ns,
                  not clock after 40 ns;
                  
      reset <= '1' after 10 ns,
               '0' after 30 ns;
               
END ; 

