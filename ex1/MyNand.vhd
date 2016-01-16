library ieee
use ieee.std_logic_1164.all

-- top entity
entity MyNand is
	port (
		u	: in	std_logic;
		v	: in	std_logic;
		w	: out	std_logic	
	);
end entity MyNand;

architecture A of MyNand is
	
	-- component insige top entity
	component MyAnd is
		port (
			X	: in	std_logic;
			Y	: in	std_logic;
			Z	: out	std_logic
		);
	end component MyAnd;

	-- component inside top entity
	component MyInv is
		port (
			X	: in	std_logic;
			Z	: in	std_logic
		);
	end component MyInv;

	-- signal inside top entity
	signal tmp	: std_logic;

	-- create component and map it
	A1: MyAnd
		port map (
			X	=> u,
			Y	=> v,
			Z	=> tmp	
		);

	-- create component and map it
	I1: MyInv
		port map (
			X	=> tmp,
			Z	=> w
		);

end architecture A;
