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

    seq: process(reset,clock)
    begin
        if reset = '1' then
            EA <= idle;
        elsif rising_edge(clock) then
            EA <= PE;
        end if;   
    end process;

    process(EA, req, release)
    begin
        case EA is
            when idle =>
                if req(0) = '1' or  req(1) = '1' or  req(2) = '1' or  req(3) = '1' 
                    then PE <= sselect;
                else PE <=  idle;
                end if ;
            when sselect => PE <= ack;
            when ack => PE <= waiting;
            when waiting => 
                if release(conv_integer(sel))='1' then PE <= idle;
                else PE <= waiting;
                end if;
        end case;    
    end process;


    grant(0)<= '1' when EA=ack and sel="00" else '0';
    grant(1)<= '1' when EA=ack and sel="01" else '0';
    grant(2)<= '1' when EA=ack and sel="10" else '0';
    grant(3)<= '1' when EA=ack and sel="11" else '0';


    process(reset, clock)
    begin
        if reset = '1' then 
             sel<="00";
        elsif rising_edge(clock) then
           if EA= sselect  then
                    if req(CONV_INTEGER(sel+1)) = '1' then
                                sel <= sel+1;
                    elsif req(CONV_INTEGER(sel+2)) = '1' then
                        sel <= sel+2;
                    elsif req(CONV_INTEGER(sel+3)) = '1' then
                            sel <= sel+3;                      
                    elsif req(CONV_INTEGER(sel)) = '1' then
                                sel <= sel;            
                    end if; 
           end if;
        end if;
    end process;

end a1;