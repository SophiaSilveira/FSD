---
---  FERNANDO GEHM MORAES - tb da exponenciacao   
---
library ieee,work;
use ieee.std_logic_1164.all;

entity tb is
end tb;

architecture a1 of tb is 

   signal op1: std_logic_vector(7 downto 0);
   signal op2: std_logic_vector(3 downto 0);
   signal resultado : std_logic_vector(63 downto 0);
   signal clock, reset, start, end_expo: std_logic := '0';

    type test_record is record
       x :  std_logic_vector(7 downto 0);
       y :  std_logic_vector(3 downto 0);
   end record;

   type padroes is array(natural range <>) of test_record;

   constant vet : padroes := (
        (x => x"43",  y => x"1"),
        (x => x"16",  y => x"2"),
        (x => x"04",  y => x"3"),
        (x => x"FF",  y => x"4"),
        (x => x"18",  y => x"7"),
        (x => x"02",  y => x"F"),
        (x => x"05",  y => x"A"),
        (x => x"40",  y => x"5"),
        (x => x"F5",  y => x"1")
    );

 begin

    ex: entity work.exponenciador
             port map( clock=> clock, reset=> reset, start=>start,
                       X => op1, Y=> op2,
                       end_expo => end_expo,
                       resultado=> resultado
                     );  
    
    reset <= '1', '0' after 0.5 ns;    
    clock <= not clock after 1 ns;

    p1: process     --- read the  ROM  with the stimulus
    begin
   
       wait for 10 ns;    -- delay to start the operations
      
       for i in 0 to vet'high loop    
                op1 <= vet(i).x;
                op2 <= vet(i).y;
                start <='1';
                wait for 10 ns;
                start <= '0';
                wait for 10 ns;
                wait until end_expo='1';
                wait for 100 ns;      -- para tratar o end_expo
            end loop;

       wait for 500 ns;    -- delay to finish the operations

       assert false
            report "A SIMULACAO TERMINOU!"
            severity failure;
                 
     end process;
        
end architecture;
