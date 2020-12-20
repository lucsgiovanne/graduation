library ieee;
use ieee.std_logic_1164.all;

entity ff_d is
  port (
    Clk : in std_logic;
    D : in std_logic;
    Q : out std_logic;
    Q_n : out std_logic;
    Preset : in std_logic;
    Clear : in std_logic
  );
end ff_d;

architecture rtl of ff_d is
begin
  process
  begin
    wait until Clk'event and Clk='1';
    if Clear='1' then
      Q <= '0';
      Q_n <= '1';
    elsif Preset='1' then
      Q <= '1';
      Q_n <= '0';
    else
      Q <= D;
      Q_n <= not(D);
    end if;
  end process;
end rtl;
