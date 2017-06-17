library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Descrição do Módulo Principal

-- Entradas e saídas da Máquina de Estados

entity FSM is
    port
          (
             COMMAND    : in  std_logic_vector(3 downto 0);
             RESET      : in  std_logic;
             CLOCK      : in  std_logic;
             FLAG_ZERO  : in  std_logic;
             FLAG_NEG   : in  std_logic;
             LOAD_ACC   : out std_logic;
             LOAD_PC    : out std_logic;
             LOAD_IR    : out std_logic;
             LOAD_DECOD : out std_logic;
             LOAD_RAM   : out std_logic;
             LOAD_ROM   : out std_logic;
             CONTROL_ULA: out std_logic;
             CONTROL_JMP: out std_logic;
             CONTROL_RAM: out std_logic;
             CONTROL_ACC: out std_logic;
             RST_ALL    : out std_logic
           
           );
           
end FSM;

architecture behavior of FSM is
    type States is (START, SINST, CACC, LOADIR, DECOD, ID, OP, COND, RW, JMPR, RESULT, BREAK);
	 signal   PE, EA: States; -- SINAIS QUEM INDICAM O ESTADO ATUAL E O PROXIMO ESTADO
	 signal   LOAD_PCAUX: std_logic;
	 
	 begin
    
   process(CLOCK, RESET, PE)
	begin
		if(RESET = '1') then
			EA <= START;
		elsif(CLOCK'event and CLOCK = '1') then
		   EA <= PE;
		end if;
   end process;

-- AQUI SERÁ DESCRITO O COMPORTAMENTO EM CADA ESTADO E SUAS INTERVENÇÕES

   process(CLOCK, EA)
	 begin
		 case EA is
 
       when START =>  LOAD_ACC   <= '0';
                      LOAD_PCAUX <= '0';
                      LOAD_PC    <= '0';
                      LOAD_IR    <= '0';
                      LOAD_ROM   <= '0';
                      LOAD_DECOD <= '0';
                      RST_ALL    <= '1';

                      PE <= SINST;

        when SINST =>  RST_ALL     <= '0';
                       LOAD_ACC    <= '0';
                       LOAD_RAM    <= '0';
                       CONTROL_JMP <= '0';
                       LOAD_PC     <= not(LOAD_PCAUX);
                       LOAD_ROM    <= '1';
                      
                       PE <= LOADIR;
                       
        when LOADIR =>  LOAD_IR <= '1';
                        
            
                        PE <= DECOD;
                        
            
        when DECOD => LOAD_PC    <= '0';
                      LOAD_IR    <= '0';
                      LOAD_ROM   <= '0';
                      LOAD_DECOD <= '1';
                      
                      PE <= ID;
                     
        when ID    => LOAD_DECOD <= '0';
                    
               case COMMAND is
                   when x"1"  => PE <= RW;
                   when x"2"  => PE <= RW;
                   when x"3"  => PE <= OP;
                   when x"4"  => PE <= OP;
                   when x"5"  => PE <= JMPR;
                   when x"6"  => PE <= COND;
                   when x"7"  => PE <= COND;
                   when x"F"  => PE <= BREAK;
                   when others => PE <= BREAK;
                end case;   
            
        
        
        when RW    => 
                           if(COMMAND = x"1") then
                               CONTROL_RAM <= '0'; -- Leitura
                               CONTROL_ACC <= '0';
                               LOAD_RAM  <= '1';
                               PE <= CACC;

                           elsif(COMMAND = x"2") then
                               CONTROL_RAM <= '1'; -- Escrita
                               LOAD_RAM <= '1';
                               PE <= SINST;
                               
                           end if;
                           
                           
                           
        when   CACC  =>   LOAD_ACC <= '1';
                          PE <= SINST;
                          
                            
       
                       
        when OP   =>       LOAD_RAM <= '1';
            
                           PE <= RESULT;
        
                       
        when RESULT  =>    if(COMMAND = x"3") then
                               CONTROL_ULA <= '0'; -- OP ADD
                           elsif(COMMAND = x"4") then
                               CONTROL_ULA <= '1'; -- OP AND
                           end if;
                           
                              CONTROL_ACC <= '1';
                              PE <= CACC;
            
                         
        when COND  =>   
                           if((COMMAND = x"6" and FLAG_NEG = '1') or (COMMAND = x"7" and FLAG_ZERO = '1')) then
                               PE <= JMPR;
                           end if;
                           
                           PE <= SINST;
                               
                       
        when JMPR  =>   
                              CONTROL_JMP <= '1';
                              LOAD_PCAUX <= '1';
                              LOAD_PC <= '1';
                              
                              PE <= SINST;
                       
        when BREAK  =>   
                            if(RESET = '1') then
                              PE <= START;
                            else
                              PE <= BREAK;
                            end if;
                         
                        
        when others => PE <= BREAK;
                       
            end case;
    end process;

end behavior;
                               
                              
                               
                       
                       
        
