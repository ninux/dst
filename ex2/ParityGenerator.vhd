library ieee;
use ieee.std_logic_1164.all;

entity ParityGenerator is
    port (
        data    : in    std_logic_vector(3 downto 0);
        parity  : out   std_logic;
    );
end entity ParityGenerator;

architecture A of ParityGenerator is
begin
    process(data)
        variable p : std_logic;
    begin
        p := '0';
        for i in 0 to 3 loop
            p <= p xor data(i);
        end loop;
        parity <= p;
    end process;
end architecture A;
