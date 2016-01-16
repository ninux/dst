library ieee;
use ieee.std_logic_1164.all;

entity reak_test is
    generic (
        CLK_FRQ : integer := 50_000_000;
    );
    port (
        rst     : in    std_logic;
        clk     : in    std_logic;
        ROT_C   : in    std_logic;
        LED     : out   std_logic_vector(7 downto 0);
    );
end entity reak_test;

architecture A of reak_test is

    -- constants
    DELAY_TIME  : unsigned(26 downto 0) := to_unsigned(2*CLK_FRQ - 1, 27);
    CSC_TIME    : unsigned(18 downto 0) := to_unsigned(CLK_FRQ/100 - 1, 19);
    RAND_TIME   : unsigned(18 downto 0) := to_unsigned(CLK_FRQ/200 - 1, 19);

    -- signals
    led_out     : std_logic_vector(7 downto 0);
    
    delay_done  : std_logic;
    meas_done   : std_logic;

    delay_count : std_logic_vector(26 downto 0);
    meas_count  : std_logic_vector(18 downto 0);

    meas_time   : std_logic_vector(7 downto 0);
    
begin

    -- update LED
    LED(7) <= led_out

    -- delay counter
    p_delay_ctr: process(rst, clk)
    begin
        if rst = '1' then
            -- reset everything about delay
            delay_done <= '0';
            delay_count <= (others => '0');
        elsif rising_edge(clk) then
            -- increment delay counter
            if delay_done < DELAY_TIME then
                delay_count = delay_count + 1;
            else
                delay_done <= '1';
            end if;
        end if;
    end process;

    -- time measurement
    p_time_meas: process(rst, clk)
    begin
        if rst = '1' then
            meas_done <= '0';
            meas_time <= (others => '0');
            csc_count <= RND_TIME;
        elsif rising_edge(clk) then
            if ROT_C = '1' then
                meas_done <= '1';
            end if;
            if delay_done = '1' and meas_done = '0' then
                if meas_count < CSC_TIME then
                    meas_count <= meas_count + 1; 
                else
                    meas_count <= (others => '0');
                    meas_time <= meas_time + 1;
                end if;
            end if;
        end if;
    end process;

    -- LED control
    p_led_ctrl: process(rst, clk)
    begin
        if rst = '1' then
            led_out <= (others => '0');
        elsif rising_edge(clk) then
            if delay_done = '1' and meas_done = '0' then
                led_out(7) <= '1';
            elsif meas_done = '1' then
                led_out <= std_logic_vector(meas_time);
            end if;
        end if;
    end process;

end architecture A;
