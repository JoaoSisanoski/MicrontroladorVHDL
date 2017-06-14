LIBRARY ieee  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_unsigned.all  ; 
ENTITY fsm_tb  IS 
END ; 
 
ARCHITECTURE fsm_tb_arch OF fsm_tb IS
  SIGNAL control_ram   :  std_logic  ; 
  SIGNAL rst_all   :  std_logic  ; 
  SIGNAL flag_zero   :  std_logic  ; 
  SIGNAL reset   :  std_logic  ; 
  SIGNAL clock   :  std_logic  ; 
  SIGNAL control_acc   :  std_logic  ; 
  SIGNAL load_ram   :  std_logic  ; 
  SIGNAL control_jmp   :  std_logic  ; 
  SIGNAL control_ula   :  std_logic  ; 
  SIGNAL flag_neg   :  std_logic  ; 
  SIGNAL load_pc_ir   :  std_logic  ; 
  SIGNAL load_acc   :  std_logic  ; 
  SIGNAL load_decod   :  std_logic  ; 
  SIGNAL command   :  std_logic_vector (3 downto 0)  ; 
  COMPONENT fsm  
    PORT ( 
      control_ram  : out std_logic ; 
      rst_all  : out std_logic ; 
      flag_zero  : in std_logic ; 
      reset  : in std_logic ; 
      clock  : in std_logic ; 
      control_acc  : out std_logic ; 
      load_ram  : out std_logic ; 
      control_jmp  : out std_logic ; 
      control_ula  : out std_logic ; 
      flag_neg  : in std_logic ; 
      load_pc_ir  : out std_logic ; 
      load_acc  : out std_logic ; 
      load_decod  : out std_logic ; 
      command  : in std_logic_vector (3 downto 0) ); 
  END COMPONENT ; 
BEGIN
  DUT  : fsm  
    PORT MAP ( 
      control_ram   => control_ram  ,
      rst_all   => rst_all  ,
      flag_zero   => flag_zero  ,
      reset   => reset  ,
      clock   => clock  ,
      control_acc   => control_acc  ,
      load_ram   => load_ram  ,
      control_jmp   => control_jmp  ,
      control_ula   => control_ula  ,
      flag_neg   => flag_neg  ,
      load_pc_ir   => load_pc_ir  ,
      load_acc   => load_acc  ,
      load_decod   => load_decod  ,
      command   => command   ) ; 
      
      reset <= '1' after 10 ns,
               '0' after 30 ns;
               
      clock <=  '1' after 20 ns,
                not clock after 30 ns;
                
      command <= x"3" after 100 ns,
      x"1" after 300 ns,
      x"F" after 500 ns;
      
      
END ; 

