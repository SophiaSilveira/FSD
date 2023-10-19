----**********************************************************
----Exemplo de FSM - MORAES - ENCONTRA PADRAO 1101
-----**********************************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm is 
  port (clk: in STD_LOGIC;
        rst: in STD_LOGIC;
        din: in STD_LOGIC;
        dout: out STD_LOGIC);
end fsm; 


architecture a1 of fsm is
     type state is (S0, S1, S11, S110, S1101);
     signal EA, PE: state;
begin
     
     seq: process(clk, rst)
     begin
       if rst= '1' then
         EA <= S0;
       elsif rising_edge(clk) then
         EA <= PE;
       end if;
     end process;
     
     comb: process(EA, din)
     begin
        case EA is
          when S0 => if din = '1' then PE <= S1;
                    else PE <= S0;
                    end if;
          when S1 => if din = '1' then PE <= S11;
                    else PE <= S0;
                    end if;
          when S11 => if din = '0' then PE <= S110;
                    else PE <= S11;
                    end if;
          when S110 => if din = '1' then PE <= S1101;
                    else PE <= S0;
                    end if;
          when S1101 => if din = '0' then PE <= S0;
                    else PE <= S11;
                    end if;
          when others => null;          
        end case;
     end process;
     
     dout <= '1' when EA = S1101  else '0';

end a1;