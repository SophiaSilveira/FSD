--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Divider   A/B  --                                       Fernando Moraes
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;

entity div_serial is                  
      generic(N: integer := 32);
      port( reset, clock:  in  std_logic;
            start:         in  std_logic; 
            A:             in  std_logic_vector((N-1) downto 0);
            B:             in  std_logic_vector((N-1) downto 0);
            end_div :      out std_logic;
            QUO, RES :     out std_logic_vector((N-1) downto 0));
end div_serial;

architecture a1 of div_serial is   
   type State_type is (inicio, desloca, subtrai, fim);
   signal EA, PE: State_type;
   
   signal regPA : std_logic_vector( (N*2) downto 0); 
   signal regB  : std_logic_vector( N downto 0);
   signal sub   : std_logic_vector( N downto 0);
   signal cont  : integer;
     
begin      

   sub    <=  regPA(N*2 downto N) - regB ;   
     
   end_div  <= '1' when EA=fim else '0';
    
   -------------------------------------------------
   -- State machine to control the division process
   -------------------------------------------------
   process (reset, clock)
     begin
      if reset='1'then
               EA <= inicio; 
      elsif rising_edge(clock) then  
               EA <= PE;
     end if;
   end process;

   process (start, EA, cont)
      begin
         case EA is
            when inicio   =>  if start='1' then  PE <= desloca;  else   PE <= inicio;   end if;
                             
            when desloca  =>  PE <= subtrai;

            when subtrai  =>  if cont=N-1 then  PE <= fim;  else  PE <= desloca; end if; 
                
            when fim      =>  PE <= inicio;
         end case; 
   end process;

   -------------------------------------------------
   -- bloco de dados
    -------------------------------------------------   
   process(reset, clock)
   begin    
       if reset='1'then
                QUO    <= (others=>'0');
                RES    <= (others=>'0');
       elsif rising_edge(clock) then 
     
            if EA=inicio then 
                regPA(N*2 downto N) <= (others=>'0');
                regPA(N-1 downto 0) <= A;
                regB <= '0'& B;
                cont <= 0;
                
            elsif EA=desloca then  
                regPA(N*2 downto 0) <= regPA(((N*2)-1) downto 0) & '0';   
                                
            elsif EA=subtrai then

                -- só armazena se a subtração é positiva
                if sub(N)='0' then
                     regPA(N*2 downto N) <= sub;
                end if; 

                regPA(0) <= not sub(N);

                cont  <= cont + 1;

           elsif EA=fim then
                QUO    <= regPA( N-1 downto 0);
                RES    <= regPA( N*2-1 downto N);

            end if;   
      end if;  
    end process;                                                                 
   
   
end a1;