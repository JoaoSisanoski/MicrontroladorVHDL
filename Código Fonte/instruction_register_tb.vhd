LIBRARY ieee  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
ENTITY instruction_register_tb  IS 
END ; 
 
ARCHITECTURE instruction_register_tb_arch OF instruction_register_tb IS
  SIGNAL ninstruction   :  std_logic_vector (15 downto 0)  ; 
  SIGNAL load   :  std_logic  ; 
  SIGNAL pinstruction   :  std_logic_vector (15 downto 0)  ; 
  SIGNAL reset   :  std_logic  ; 
  COMPONENT instruction_register  
    PORT ( 
      ninstruction  : in std_logic_vector (15 downto 0) ; 
      load  : in std_logic ; 
      pinstruction  : out std_logic_vector (15 downto 0) ; 
      reset  : in std_logic ); 
  END COMPONENT ; 
BEGIN
  DUT  : instruction_register  
    PORT MAP ( 
      ninstruction   => ninstruction  ,
      load   => load  ,
      pinstruction   => pinstruction  ,
      reset   => reset   ) ; 
      
      load <=  '1' after 20 ns,
                  not load after 40 ns;
                  
        reset <= '1' after 40 ns,
                 '0' after 60 ns;
                  
        ninstruction <= x"1111",
                        x"2222" after 80 ns,
                        x"3333" after 160 ns,
                        x"4444" after 240 ns,
                        x"5555" after 320 ns,
                        x"6666" after 400 ns,
                        x"7777" after 480 ns,
                        x"8888" after 560 ns,
                        x"9999" after 640 ns;
END ; 

