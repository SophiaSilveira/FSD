---
---  FERNANDO GEHM MORAES - exponenciacao
---
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity exponenciador is
         port( clock, reset : in std_logic;
               start : in std_logic;            
               X : in std_logic_vector(7 downto 0);         
               Y : in std_logic_vector(3 downto 0);       
               end_expo : out std_logic;                
               resultado : out std_logic_vector(63 downto 0) 
             );
end exponenciador;

architecture exponenciador of exponenciador is
    type states is (init, start_multip, multip, laco, fim);
    signal EA, PE : states;
    signal end_mul, start_mul: std_logic;
    signal cont : std_logic_vector(3 downto 0);
    signal produto, op2 : std_logic_vector(63 downto 0);
    signal op1: std_logic_vector(31 downto 0);
begin                           
        
    
     <<<<  FAZER AQUI A CODIFICAÇÃO DA MÁQUINA DE ESTADOS >>>

      mu: entity work.mult_serial
             port map(  <<< COMPLETAR >>>
                     );  

      -- bloco de dados
      process (reset, clock)  
      begin
          if reset='1' then
              resultado <= (others=>'0');
          elsif rising_edge(clock) then

               start_mul <= '0';  -- default value
               end_expo <= '0';

               case EA is

                      when init =>   -- incializa os registradores
                                     cont <= Y;
                                     op1(7 downto 0)  <=  X; 
                                     op1(31 downto 8)  <=  (others=>'0'); 
                                     op2 <=  (0=>'1', others=>'0');    --------- valor 1
                      when start_multip =>   start_mul <= '1';


                      when laco =>  -- armazena o resultado da multiplicacao e inicia nova iteracao
                                    op2 <= produto;
                                    cont <= cont -1;

                      when fim  =>  end_expo <= '1';
                                    resultado <= produto;

                      when others => null;     

                end case;
         end if;
      end process;

end exponenciador;
