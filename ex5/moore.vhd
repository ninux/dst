library ieee;
use ieee.std_logic_1164.all;

entity moore is
	port (
		input	: in	std_logic_vector(1 downto 0);
		output	: out	std_logic;
		rst	: in	std_logic;
		clk	: in	std_logic
	);
end entity moore;

architecture A of moore is
	type state is (s0, s1, s2);
	signal c_st, n_st : state;
begin
	p_seq: process(rst, clk)
	begin
		if rst = '1' then
			c_st <= s0;
			n_st <= s0;
			output <= '0';
		elsif rising_edge(clk) then
			c_st <= n_st;
		end if;
	end process;

	p_com: process(input, c_st)
	begin
		n_st <= c_st;
		output <= '0';

		case c_st is
			when s0 =>
				output <= '1';
				if input = "00" then
					n_st <= s1;
				end if;
			when s1 => 
				output <= '0';
				if input = "00" then
					n_st <= s2;
				elsif input = "10" then
					n_st <= s0;
				end if
			when s2 => 
				output <= '0';
				if input = "00" then
					n_st <= s2;
				elsif input = "11" then
					n_st <= s1;
				elsif input = "10" then
					n_st <= s0;
				end if;
			when others => 
				output <= 0';
				n_st <= s0;
		end case;
	end process;
end architecture moore;
