library ieee;
use ieee.std_logic_1164.all;

entity MyAnd is
    port (
        X   : in    std_logic;
        Y   : in    std_logic;
        Z   : out   std_logic
    );
end entity MyAnd;

architecture A of MyAnd is
begin
    Z <= X and Y;
end architecture A;
