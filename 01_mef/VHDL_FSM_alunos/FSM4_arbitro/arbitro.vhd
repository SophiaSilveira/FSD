library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.p_arb.all;

entity arbitro is
      port(
           clock, reset:in std_logic;
           req, release:in control;
           grant:out control
           );
end arbitro;

architecture a1 of arbitro is

    type states is(idle, sselect, ack, waiting);
    signal EA, PE: states;

    signal sel : std_logic_vector(1 downto 0);     

begin


    --
    --  CONTROLE: MAQUINA DE ESTADOS
    -- 
    <<<<  FAZER AQUI A CODIFICAÇÃO DA MÁQUINA DE ESTADOS >>>



    grant(0)<='1' when EA=______ and sel="00" else '0';
    grant(1)<=  ...
    grant(2)<=  ...
    grant(3)<=  ...
    --
    --  DADOS: REGISTRADORES E SAIDA
    --     
    process(...)
    begin
        if reset = '1' then 
             sel<="00";
        elsif rising_edge(...) then
           if EA= sselect  then

                    if req(CONV_INTEGER(sel+1)) = '1' then
                                sel <= sel+1;
                    ...

                    end if; 
                    
           end if;
        end if;
    end process;


end a1;