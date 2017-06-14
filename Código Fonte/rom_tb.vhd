LIBRARY ieee  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
ENTITY rom_tb  IS 
END ; 
 
ARCHITECTURE rom_tb_arch OF rom_tb IS
  SIGNAL load   :  std_logic  ; 
  SIGNAL data   :  std_logic_vector (15 downto 0)  ; 
  SIGNAL address   :  std_logic_vector (7 downto 0)  ; 
  COMPONENT rom  
    PORT ( 
      load  : in std_logic ; 
      data  : inout std_logic_vector (15 downto 0) ; 
      address  : in std_logic_vector (7 downto 0) ); 
  END COMPONENT ; 
BEGIN
  DUT  : rom  
    PORT MAP ( 
      load   => load  ,
      data   => data  ,
      address   => address   ) ; 
      
      load <=  '1' after 20 ns,
               not load after 30 ns;

    
    address <= 
              x"00" after 100 ns,
              x"01" after 200 ns,
              x"02" after 300 ns,
              x"03" after 400 ns,
              x"04" after 500 ns;
      
END ; 

