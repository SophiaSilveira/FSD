library ieee;
use ieee.std_logic_1164.all;
library work;
use work.all;

entity tb is
end tb;

architecture a1 of tb is
	signal LLa, LLb : std_logic_vector(1 downto 0);
	signal clk, rst, TTb: std_logic := '0';
	signal TTa: std_logic := '1';
begin

	UUT: entity work.fsm1
		port map(CLK=>clk, RST=>rst, Ta=>TTa, Tb=>TTb, La=>LLa, Lb=>LLb  );

    clk <= not clk after 2.5 ns;

	rst <= '1', '0' after 3 ns;

	TTa <= not TTa after 50 ns;
	TTb <= not TTb after 50 ns;

end a1; 