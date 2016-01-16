library ieee;
use ieee.std_logic_1164.all;

entity EnableGate is
    port (
        -- data
        x   : in    std_logic_vector(3 downto 0);
        y   : out   std_logic_vector(3 downto 0);
        -- controls
        en  : in    std_logic;
    );  
end EnableGate;

-- concurrent naive
architecture A1 of EnableGate is
begin
    y(0) = x(0) and en;
    y(1) = x(1) and en;
    y(2) = x(2) and en;
    y(3) = x(3) and en;
end architecture;

-- concurrent
architecture A2 of EnableGate is
begin
    if en = '1' then
        y <= x;
    else
        y <= (others => '0');
    end if;
end architecture;

-- sequential
architecture A3 of EnableGate is
    process(x, en)
        if en = '0' then
            y <= (others => '0');
        else
            y <= x;
        end if;
    end process;
end architecture;

-- for-loop
architecture A4 of EnableGate is
    process(x, en)
        for i in 0 to 3 loop
            y(i) <= x(i) and en;
        end loop;       
    end process;
end architecture
