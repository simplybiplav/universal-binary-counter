library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uni_bin_ctr_test is 
end  uni_bin_ctr_test;

architecture behavior of uni_bin_ctr_test is
constant CLK_PERIOD : time := 10 ns;

component uni_bin_ctr 
    Port ( clk, rst: in std_logic;
            clr : in std_logic;
            en  : in std_logic;
            lod : in std_logic;
            dir : in std_logic;
            cin : in std_logic_vector(7 downto 0);
            cout: out std_logic_vector (7 downto 0)
                );
end component;

signal clk, rst: std_logic;
signal            clr :  std_logic;
signal            en  :  std_logic;
signal            lod :  std_logic;
signal            dir :  std_logic;
signal            cin: std_logic_vector(7 downto 0);
signal            cout: std_logic_vector (7 downto 0);

BEGIN
--Instantiate in uut
uut:uni_bin_ctr port map(
clk=>clk, rst=>rst, clr=>clr, en=>en, lod=>lod, dir=>dir, cin=>cin, cout=>cout
);

clk_process:process
begin
    clk <= '0' ;
    wait for CLK_PERIOD/2;
    clk <= '1' ;
    wait for CLK_PERIOD/2;
end process;

io_process: process
begin
    rst <= '0';
    en <= '1';
    lod <= '0';
    clr <= '1';
    dir <= '0';
    cin <= "01010001";


    wait for CLK_PERIOD ;
    clr <= '0';

    dir <= '1';    
    wait for CLK_PERIOD * 10;

    lod <= '1';
    wait for CLK_PERIOD;
    lod <= '0';

    dir <= '1';    
    wait for CLK_PERIOD * 10;

    dir <= '0';    
    wait for CLK_PERIOD * 10;

    clr <= '1';    
    wait for CLK_PERIOD;


    clr <= '0';    
    wait for CLK_PERIOD * 10;

    lod <= '0';
    clr <= '1';    
    wait for CLK_PERIOD;

    clr <= '0';    
    wait for CLK_PERIOD * 10;

    rst <= '1';
    wait for CLK_PERIOD * 2;
    
end process;

END;
