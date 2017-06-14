LIBRARY ieee  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
ENTITY ram_tb  IS 
END ; 
 
ARCHITECTURE ram_tb_arch OF ram_tb IS
  SIGNAL load   :  std_logic  ; 
  SIGNAL control   :  std_logic  ; 
  SIGNAL data_in   :  std_logic_vector (7 downto 0)  ; 
  SIGNAL data_out   :  std_logic_vector (7 downto 0)  ; 
  SIGNAL address   :  std_logic_vector (7 downto 0)  ; 
  SIGNAL reset   :  std_logic  ; 
  COMPONENT ram  
    PORT ( 
      load  : in std_logic ; 
      control  : in std_logic ; 
      data_in  : in std_logic_vector (7 downto 0) ;
      data_out  : out std_logic_vector (7 downto 0) ; 
      address  : in std_logic_vector (7 downto 0) ; 
      reset  : in std_logic ); 
  END COMPONENT ; 
BEGIN
  DUT  : ram  
    PORT MAP ( 
      load   => load  ,
      control   => control  ,
      data_in   => data_in  ,
      data_out => data_out ,
      address   => address  ,
      reset   => reset   ) ; 
           
      load <=  '1' after 20 ns,
               not load after 40 ns;
               
    control <= '0',
               '1' after 320 ns;
    
    address <= 
              x"00" after 100 ns,
              x"01" after 150 ns,
              x"02" after 200 ns,
              x"03" after 250 ns,
              x"04" after 300 ns;
              
    data_in <= x"33" after 300 ns;
              
    reset <= '1' after 10 ns,
             '0' after 40 ns;   
      
      
END ; 

