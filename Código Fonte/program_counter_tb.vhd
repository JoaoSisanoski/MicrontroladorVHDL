LIBRARY ieee  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
ENTITY program_counter_tb  IS 
END ; 
 
ARCHITECTURE program_counter_tb_arch OF program_counter_tb IS
  SIGNAL clock   :  std_logic  ; 
  SIGNAL pos   :  std_logic_vector (7 downto 0)  ; 
  SIGNAL jmp   :  std_logic_vector (7 downto 0)  ; 
  SIGNAL reset   :  std_logic  ; 
  SIGNAL control_jmp   :  std_logic  ; 
  COMPONENT program_counter  
    PORT ( 
      clock  : in std_logic ; 
      pos  : out std_logic_vector (7 downto 0) ; 
      jmp  : in std_logic_vector (7 downto 0) ; 
      reset  : in std_logic ; 
      control_jmp  : in std_logic ); 
  END COMPONENT ; 
BEGIN
  DUT  : program_counter  
    PORT MAP ( 
      clock   => clock  ,
      pos   => pos  ,
      jmp   => jmp  ,
      reset   => reset  ,
      control_jmp   => control_jmp   ) ; 
      
      clock <=  '1' after 20 ns,
                  not clock after 40 ns;
                  
      reset <= '1' after 40 ns,
              '0' after 100 ns;
              
      jmp <= x"2A";
      
      control_jmp <= '1' after 800 ns,
              '0' after 900 ns;
END ; 

