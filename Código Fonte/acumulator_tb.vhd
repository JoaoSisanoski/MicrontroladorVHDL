LIBRARY ieee  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
ENTITY accumulator_tb  IS 
END ; 
 
ARCHITECTURE accumulator_tb_arch OF accumulator_tb IS
  SIGNAL value_out   :  std_logic_vector (7 downto 0)  ; 
  SIGNAL clock   :  std_logic  ; 
  SIGNAL value_in   :  std_logic_vector (7 downto 0)  ; 
  SIGNAL reset   :  std_logic  ; 
  COMPONENT accumulator  
    PORT ( 
      value_out  : out std_logic_vector (7 downto 0) ; 
      clock  : in std_logic ; 
      value_in  : in std_logic_vector (7 downto 0) ; 
      reset  : in std_logic ); 
  END COMPONENT ; 
BEGIN
  DUT  : accumulator  
    PORT MAP ( 
      value_out   => value_out  ,
      clock   => clock  ,
      value_in   => value_in  ,
      reset   => reset   ) ; 
      
       clock <= '1' after 20 ns,
                  not clock after 40 ns;
                  
      reset <= '1' after 10 ns,
               '0' after 30 ns;
               
      value_in <= x"10" after 50 ns,
                  x"20" after 150 ns,
                  x"30" after 250 ns,
                  x"FF" after 350 ns;
      
      
END ; 

