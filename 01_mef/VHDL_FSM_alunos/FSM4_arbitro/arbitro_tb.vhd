library IEEE;
use IEEE.std_logic_1164.all;
use work.p_arb.all;

entity tb is
end tb;

architecture tb of tb is
  signal clock : std_logic := '0';
  signal reset : std_logic;
  signal req, grant, release : control;
begin

  DUT : entity work.arbitro
        port map ( clock => clock, reset => reset, req => req,
                   release => release, grant => grant );

  reset <= '1', '0' after 5 ns;    
  clock <= not clock after 5 ns;

  req(0) <= '1' ,  '0' after 800 ns, '1' after 1300 ns, '0' after 1600 ns;
  req(1) <= '0' ,  '1' after 300 ns, '0' after 1000 ns;
  req(2) <= '0' ,  '1' after 300 ns, '0' after 1000 ns, '1' after 1300 ns, '0' after 1600 ns;
  req(3) <= '0' ,  '1' after 300 ns, '0' after 1000 ns;

  modulos: for i in 0 to 3 generate
    process
    begin
      release(i) <= '0'; 
      wait until grant(i)='1';
      wait for 40 ns;
      release(i) <= '1'; 
      wait for 20 ns;
    end process;
  end generate;

end tb;
