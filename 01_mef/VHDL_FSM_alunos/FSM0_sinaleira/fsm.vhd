library ieee;
use ieee.std_logic_1164.all;

entity fsm1 is
	port (
		CLK, RST: in std_logic;
		Ta, Tb: in std_logic;
		La, Lb: out std_logic_vector(1 downto 0)
	);
end entity;

architecture a1 of fsm1 is
	type state is (S0, S1, S2, S3);
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
     
     comb: process(EA, Ta, Tb)
     begin
        case EA is

            when S0 =>  if Ta = '0' then   PE <= S1;
                                    else   PE <= S0;
                        end if;

            when S1 =>  PE <=S2;

            when S2 => if Tb = '0' then  PE <= S3;
                                    else PE <= S2;
                        end if;
           
            when S3 =>  PE <= S0;
            
            when others => null;
        end case;
     end process;

	La <= "01" when EA = S0 else
	      "10" when EA = S1 else
	      "00";

	Lb <= "01" when EA = S2 else
	      "10" when EA = S3 else
	      "00";

end architecture;	 		 	


		
