library ieee;
use ieee.std_logic_1164.all;

entity alu is
  port (
    a, b : in std_logic_vector(3 downto 0);
    F : out std_logic_vector(3 downto 0);
    s0, s1 : in std_logic;
    Z, C, V, N : out std_logic
  );
end alu;

architecture behavioral of alu is
  component ripple_carry is
    generic (
      N : integer := 4
    );
    port (
      x,y : in std_logic_vector(N-1 downto 0);
      r : out std_logic_vector(N-1 downto 0);
      cin : in std_logic;
      cout : out std_logic;
      overflow : out std_logic
    );
  end component;

  -- O vetor b_op tem o valor de "b" se a operação aritmética for soma, e o inverso de b se for subtração, situação em que será somado 1, o bit cin_op para que seja somado "a"
  -- ao complemento de 2 de b. Os valores de cout_op e V_op somente serão passados para C e V se as operações forem aritméticas, caso contrário, recebem 0. O vetor arithmetic_vec
  -- somente terá seu valor passado para F se a operação for aritmética, em que o bit s1 tem valor 0.

  signal  arithmetic_vec, b_op, F_buffer : std_logic_vector(3 downto 0);  
  signal cin_op, cout_op, V_op: std_logic;
  signal s: std_logic_vector(1 downto 0);  

  begin
    with s0 select
      b_op <=  b when '0',
              not(b) when others;
    with s0 select    
      cin_op <= '0' when '0',
              '1' when others;

    rc_arithmetic: ripple_carry
      generic map (N => 4)
      port map (a(3 downto 0), b_op(3 downto 0), arithmetic_vec(3 downto 0), cin_op, cout_op,  V_op);

    s <= s1 & s0;
    with s select
      F_buffer <= a or b when "11",           
                  a and b when "10",
                  arithmetic_vec when others;

    with s select
      C <= cout_op when "00",
           '0' when others;
    with s1 select
      V <= V_op when '0',      
           '0' when others;
    with s1 select
      N <= (arithmetic_vec(3) and not(V_op)) or (a(3) and V_op) when '0',      -- O valor de N é 1 se o resultado de uma soma ou subtração for negativo, ocorrendo ou não overflow
           '0' when others;
    
    with F_buffer select
      Z <= '1' when "0000",
           '0' when others;
      
    F <= F_buffer;

end behavioral;
