--
-- protocolo de transmissao de dados por uma serial
--
library IEEE;
use IEEE.std_logic_1164.all;

entity transmissor is
    port ( clock,reset,send: in ...;
           palavra: in ...;
           busy, linha: out ...
         );
end transmissor;

architecture a1 of transmissor is
    type STATES is (...);
    signal EA, PE : STATES;     
begin
  
   <<<<  FAZER AQUI A CODIFICAÇÃO DA MÁQUINA DE ESTADOS >>>

	
	busy <= ...
	
	linha <=  ...		

end a1;


