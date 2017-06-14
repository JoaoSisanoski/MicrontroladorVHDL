library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Descrição do Módulo Principal

-- Entradas e saídas do Microprocessador

entity uProcessor is
    port
          (
              CLOCK: in  std_logic;
              RESET: in  std_logic
           
           );
end uProcessor;

-- Descrição do comportamento do módulo principal

architecture behavior of uProcessor is
    
    -- Saídas da FSM
    
	 signal   SLOAD_ACC, 
	          SLOAD_PC, 
	          SLOAD_IR,
	          SLOAD_DECOD, 
	          SLOAD_RAM, 
	          SLOAD_ROM,
	          SCONTROL_ULA, 
	          SCONTROL_JMP, 
	          SCONTROL_RAM, 
	          SCONTROL_ACC,
	          SRST_ALL: std_logic;
	          
	 -- Saídas da ULA
	 
	 signal   SFLAG_ZERO,
	          SFLAG_NEG: std_logic;
	 signal   SRESULT: std_logic_vector(7 downto 0);
	 
	 -- Saídas da ROM
	 
	 signal   SDATA: std_logic_vector(15 downto 0);
	 
	 -- Saídas da RAM
	 
	 signal   SDATA_OUT: std_logic_vector(7 downto 0);
	 
	 -- Saídas do Program Counter
	 
	 signal   SPOS: std_logic_vector(7 downto 0);
	 
	 -- Saídas do Mux 2x1
	 
	 signal   SQ: std_logic_vector(7 downto 0);
	 
	 -- Saídas do Instruction Register
	 
	 signal   SPINSTRUCTION: std_logic_vector(15 downto 0);
	 
	 -- Saídas do Decoder
	 
	 signal   SCOMMAND_OUT: std_logic_vector(3 downto 0);
	 signal   SADDRESS: std_logic_vector(7 downto 0);
	 
	 -- Saídas do Acumulator
	 
	 signal SVALUE_OUT: std_logic_vector(7 downto 0);
	 

-- Descrição dos componentes utilizados no módulo principal

-- Instruction Register

component Instruction_Register is
        port
        (
           LOAD: in std_logic; -- Load vindo da FSM
           RESET: in std_logic; -- Reset
           PINSTRUCTION: out std_logic_vector(15 downto 0); -- Instruçao em uso
           NINSTRUCTION: in std_logic_vector(15 downto 0) -- Proxima instruçao
           
         );
         
end component;

-- ULA

component ULA is
    port
        (
             VALUE1    : in  std_logic_vector(7 downto 0);
             VALUE2    : in  std_logic_vector(7 downto 0);
             CONTROL   : in  std_logic;
             FLAG_ZERO : out std_logic;
             FLAG_NEG  : out std_logic;
             RESULT    : out std_logic_vector(7 downto 0)
           
           );
         
end component;

-- Acumulator

component Accumulator is
    port
        (
           CLOCK: in std_logic; -- Load vindo da FSM
           RESET: in std_logic;
           VALUE_IN: in std_logic_vector(7 downto 0);
           VALUE_OUT: out std_logic_vector(7 downto 0)
        );
        
end component;

-- Mux 2x1

component mux2x1 is
    port
        (
           D1 : in std_logic_vector(7 downto 0); -- Entrada 1, vindo da ULA
           D2 : in std_logic_vector(7 downto 0); -- Entrada 2, vindo da memória
           CONTROLE: in std_logic; -- 00 LDA 01 STA 10 ULA
           Q   : out std_logic_vector(7 downto 0)
        
        );
end component;
    

-- Program Counter

component Program_Counter is
    port
        (
           CLOCK: in std_logic; -- Load vindo da FSM
           CONTROL_JMP: in std_logic; -- Load para o JMP
           RESET: in std_logic; -- Reset
           JMP  : in std_logic_vector(7 downto 0); -- Endereço de memoria vindo da instruçao JMP
           POS  : out std_logic_vector(7 downto 0) -- Posiçao de memoria
           
         );
         
end component;

-- Decoder

component Decoder is
    port
        (
             INSTR_IN    : in  std_logic_vector(15 downto 0);
             LOAD        : in std_logic;
             RESET       : in std_logic;
             COMMAND_OUT : out  std_logic_vector(3 downto 0);
             ADDRESS      : out std_logic_vector(7 downto 0)
           
         );
end component;

-- Memória do programa

component ROM is
    port
        (
           LOAD   : in std_logic;
           ADDRESS : in std_logic_vector(7 downto 0);
           DATA   : out std_logic_vector(15 downto 0)
        ); 
        
end component;

-- Memória RAM

component RAM is
    port
        (
           LOAD, RESET   : in std_logic;
           ADDRESS : in std_logic_vector(7 downto 0);
           DATA_IN   : in std_logic_vector(7 downto 0);
           DATA_OUT   : out std_logic_vector(7 downto 0);
           CONTROL: in std_logic         -- Fazer leitura(0) ou escrita(1)
           
        ); 
        
end component;

-- Finite State Machine

component FSM is
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
        
end component;

-- Comportamento do módulo principal

begin
    
-- Mapeamento de portas 

   ALU      : ULA port map(SDATA_OUT, SVALUE_OUT, SCONTROL_ULA, SFLAG_ZERO, SFLAG_NEG, SRESULT); 
   MPROGRAMA: ROM port map(SLOAD_ROM, SPOS, SDATA);
   MDADOS   : RAM port map(SLOAD_RAM, SRST_ALL, SADDRESS, SVALUE_OUT, SDATA_OUT, SCONTROL_RAM);
   PC       : Program_Counter port map(SLOAD_PC, SCONTROL_JMP, SRST_ALL, SADDRESS, SPOS);
   MUX      : mux2x1 port map(SRESULT, SDATA_OUT, SCONTROL_ACC, SQ);
   IR       : Instruction_Register port map(SLOAD_IR, SRST_ALL, SPINSTRUCTION, SDATA);
   DECOD    : Decoder port map(SPINSTRUCTION, SLOAD_DECOD, SRST_ALL, SCOMMAND_OUT, SADDRESS);
   ACC      : Accumulator port map(SLOAD_ACC, SRST_ALL, SQ, SVALUE_OUT);
   ME       : FSM port map(SCOMMAND_OUT, RESET, CLOCK, SFLAG_ZERO, SFLAG_NEG, SLOAD_ACC, SLOAD_PC, SLOAD_IR, SLOAD_DECOD, SLOAD_RAM, SLOAD_ROM, SCONTROL_ULA, SCONTROL_JMP, SCONTROL_RAM, SCONTROL_ACC, SRST_ALL);              
    
end architecture;

           
           
            
