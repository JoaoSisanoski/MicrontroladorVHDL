library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entradas e saídas da RAM

entity RAM is
    port
        (
           LOAD, RESET   : in std_logic;
           ADDRESS : in std_logic_vector(7 downto 0);
           DATA_IN   : in std_logic_vector(7 downto 0);
           DATA_OUT   : out std_logic_vector(7 downto 0);
           CONTROL: in std_logic         -- Fazer leitura(0) ou escrita(1)
           
        ); 
end RAM;

architecture behavior of RAM is
    
    type vector_data_RAM is array(15 downto 0) of std_logic_vector(7 downto 0);
  
     signal MEM: vector_data_RAM := 
     (
		0  => x"00",
		1  => x"00",
		2  => x"05",
		3  => x"06",
		4  => x"00",
		5  => x"00",
		6  => x"00",
		7  => x"00",
		8  => x"00",
		9  => x"00",
		10 => x"00",
		11 => x"00",
		12 => x"00",
		13 => x"00",
		14 => x"00",
		15 => x"00"
		);
		
		
begin
   
process(LOAD, RESET, DATA_IN, ADDRESS)
    
    begin 
        if(RESET = '1') then
            DATA_OUT <= x"00";
        elsif(LOAD'event and LOAD = '1') then
           if(CONTROL = '0') then   -- Operação de leitura
              DATA_OUT <= MEM(conv_integer(ADDRESS));
           elsif(CONTROL = '1') then   -- Operação de escrita
              MEM(conv_integer(ADDRESS)) <= DATA_IN;    
           end if;
       end if;
end process;
   
end behavior;
           
           