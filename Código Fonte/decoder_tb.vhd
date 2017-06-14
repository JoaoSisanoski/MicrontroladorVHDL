LIBRARY ieee  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
ENTITY decoder_tb  IS 
END ; 
 
ARCHITECTURE decoder_tb_arch OF decoder_tb IS
  SIGNAL load   :  std_logic  ; 
  SIGNAL address   :  std_logic_vector (7 downto 0)  ; 
  SIGNAL command_out   :  std_logic_vector (3 downto 0)  ; 
  SIGNAL instr_in   :  std_logic_vector (15 downto 0)  ; 
  SIGNAL reset   :  std_logic  ; 
  COMPONENT decoder  
    PORT ( 
      load  : in std_logic ; 
      address  : out std_logic_vector (7 downto 0) ; 
      command_out  : out std_logic_vector (3 downto 0) ; 
      instr_in  : in std_logic_vector (15 downto 0) ; 
      reset  : in std_logic ); 
  END COMPONENT ; 
BEGIN
  DUT  : decoder  
    PORT MAP ( 
      load   => load  ,
      address   => address  ,
      command_out   => command_out  ,
      instr_in   => instr_in  ,
      reset   => reset   ) ; 
      
       load <=  '0' after 20 ns,
                  not load after 100 ns;
                  
        reset <= '1' after 40 ns,
                 '0' after 60 ns;
                 
        instr_in <= x"0455" after 100 ns,
                    x"0387" after 200 ns,
                    x"06AA" after 300 ns;
END ; 

