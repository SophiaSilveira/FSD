library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.CONV_STD_LOGIC_VECTOR;

entity tb is
end tb;

architecture tb of tb is 

  constant N : integer := 8; 

  signal op1, op2, QUO, RES : std_logic_vector(N-1 downto 0);
  signal reset, start, end_div : std_logic;
  signal clock : std_logic := '0';

     type test_record is record
         a, b :  integer;
     end record;

     type padroes is array(natural range <>) of test_record;

     constant padrao_de_teste : padroes := (
          (a =>  27,  b =>  5),     --   5/2   
          (a => 163,  b => 17),     --   9/10 
          (a => 217,  b => 41),     --   5/12
          (a => 254,  b => 253),    --   1/1
          (a =>   5,  b => 124),    --   0/5
          (a => 225,  b => 15),     --   15/0
          (a =>   0,  b => 255)     --   0/0
        );
begin

    DUT: entity work.div_serial
         generic map(8)
         port map( clock => clock, reset => reset, start => start, A => op1,
                 B => op2, end_div => end_div, QUO=>QUO, RES=>RES );  

    reset <= '1', '0' after 5 ns;    
    clock <= not clock after 5 ns;

    test: process
     begin       

        for i in 0 to padrao_de_teste'high loop    
                op1 <= CONV_STD_LOGIC_VECTOR(padrao_de_teste(i).a, op1'length);
                op2 <= CONV_STD_LOGIC_VECTOR(padrao_de_teste(i).b, op2'length);
                start <='1';
                wait for 10 ns;
                start <='0';
                wait for 300 ns;
        end loop;

    end process;

    
end tb;