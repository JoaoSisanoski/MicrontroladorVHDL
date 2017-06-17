library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entradas e saídas da ROM

entity ROM is
    port
        (
           LOAD   : in std_logic;
           ADDRESS : in std_logic_vector(7 downto 0);
           DATA   : out std_logic_vector(15 downto 0)
        ); 
end ROM;

architecture behavior of ROM is
    
    type vector_data_program is array(15 downto 0) of std_logic_vector(15 downto 0);
  
     signal MEMPROGRAM: vector_data_program := 
     (
		0  => x"0002",
		1  => x"0203",
		2  => x"0506",
		3  => x"0100",
		4  => x"0408",
		5  => x"0001",
		6  => x"0000",
		7  => x"0000",
		8  => x"FF00",
		9  => x"0000",
		10 => x"0000",
		11 => x"0000",
		12 => x"0000",
		13 => x"0000",
		14 => x"0000",
		15 => x"0000"
		);
		
		signal DATA_signal: std_logic_vector(15 downto 0);
   
begin
   
process(LOAD, ADDRESS)
    begin 
        if(LOAD'event and LOAD = '1') then
                DATA_signal <= MEMPROGRAM(conv_integer(ADDRESS)); 
        end if;  
end process;

process(DATA_signal)
    begin
   
       DATA <= DATA_signal;
   
 end process;
   
end behavior;
           
           
