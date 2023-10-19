----**********************************************************
----- test bench    
-----**********************************************************
library IEEE;
use IEEE.std_logic_1164.all;

entity tb is
end tb;

architecture arch of tb is
      signal reset: std_logic;
      signal clk : std_logic := '0' ;
      signal din, dout: STD_LOGIC;

      type dados is array(natural range <>) of std_logic;

      constant padrao_de_teste : dados := ('1', '0', '1', '1', '0', '1', '1', '0', '1', '0', '0', '1', '1', '0', '1', '0');

begin

      reset <= '1', '0' after 5 ns;

      test: process
      begin 
        for i in 0 to padrao_de_teste'high loop    
                din <= padrao_de_teste(i);
                wait for 10 ns;
         end loop;
      end process;

      clk <= not clk after 5 ns;

      seq: entity work.fsm  
          port map(clk => clk, rst => reset,  din => din, dout=>dout);

end arch; 
