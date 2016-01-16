library ieee;
use ieee.std_logic_1164.all;

entity BarrelShifter is
    port (
        dataIn  : in    std_logic_vector(7 downto 0);
        dataOut : out   std_logic_vector(7 downto 0);
        shift   : in    std_logic_vector(3 downto 0)
    );  
end entity BarrelShifter;

architecture A of BarrelShifter is
begin
    process(dataIn)
        variable barrel : std_logic_vector(23 downto 0);)
    begin
        barrel := (others => '0');
        -- barrel(offset) = dataIn
        barrel((to_integer(signed(shift)) + 15) downto (to_integer(signed(shift))) + 8) := dataIn(7 downto 0);
        dataOut(7 downto 0) <= barrel(15 downto 8);
    end process;
end architecture BarrelShifter;
