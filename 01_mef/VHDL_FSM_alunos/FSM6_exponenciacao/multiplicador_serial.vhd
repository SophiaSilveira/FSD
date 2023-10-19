---
---  FERNANDO GEHM MORAES - multiplicador serial
---
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity mult_serial is
         port( clock, reset : in std_logic;
               start : in std_logic;            
               A : in std_logic_vector(31 downto 0);         
               B : in std_logic_vector(31 downto 0);       
               end_mul : out std_logic;                
               produto : out std_logic_vector(63 downto 0) 
             );
end mult_serial;

architecture mult_serial of mult_serial is
    type states is (init, sum, shift, fim);
    signal EA, PE : states;
    signal cont : std_logic_vector(4 downto 0);
    signal regP : std_logic_vector(64 downto 0);
begin                           
        -- bloco de controle
        process(reset, clock)
        begin
          if reset='1' then
             EA <= Init;
          elsif rising_edge(clock) then
             EA <= PE;
          end if;
        end process;

        process (EA,start,cont)
        begin
                case EA is
                    when init =>  if start='1' then PE <= sum; else PE <= init; end if;
                    when sum =>   PE <= shift;
                    when shift => if cont=0 then 
                                         PE <= fim;
                                      else 
                                         PE <= sum;
                                      end if;
                     when fim =>   PE <= init;

                end case;               
        end process;
        
        -- bloco de dados
        process (reset, clock)  
        begin
          if reset='1' then
             regP <= (others=>'0');
             produto <= (others=>'0');

          elsif rising_edge(clock) then
               case EA is
                      when init =>   regP(64 downto 32) <= (others=>'0');
                                     regP(31 downto 0)  <= A;
                                     cont <= (others=>'0'); 
                                     end_mul <='0';

                      when sum =>    cont <= cont-1;

                                     if regP(0)='1' then
                                         regP(64 downto 32) <= regP(64 downto 32) + ('0' & B);
                                     end if;

                      when shift =>  if cont=0 then 
                                            end_mul <='1';
                                     end if;
                                     regP <= '0' & regP(64 downto 1);

                      when fim =>    produto <= regP(63 downto 0);                 
                   end case;
                end if;
        end process;

end mult_serial;