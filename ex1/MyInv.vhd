library ieee
use ieee.std_logic_1164.all;

entity MyInv is
	port (
		X	: in	std_logic;
		Z	: out	std_logic
	);	
end entity MyInv;

architecture A of MyInv is
begin
	Z <= not X;
end architecture A;
