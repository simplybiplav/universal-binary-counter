--Consider an 8-bit universal binary counter supporting an asynchronous reset input plus four 
--synchronous inputs to clear the outputs, to enable the operation of the counter, 
--to load an 8-bit initial count value (c_in(7:0)), and to define the counting direction (up / down).

--1)Use the template below to create a function table describing the operation of this circuit.
--    -----------------------------------------------------------------------------------------------------
--    | reset     | clear     | enable    | load      | direction     |   c_in[7:0]   |   c_out[7:0]      |
--    |-----------|-----------|-----------|-----------|---------------|---------------|-------------------|
--    |  1        |  x        | x         |   x       |   x           |   x           |   "00000000"      |
--    |-----------|-----------|-----------|-----------|---------------|---------------|-------------------|
--    |  0        |  0        |  0        |  x        |  x            |   x           |   c_out[7:0]      |
--    |-----------|-----------|-----------|-----------|---------------|---------------|-------------------|
--    |   0       |   0       |  1        |  0        |  0            |   x           |   c_out[7:0] to   | 
--    |           |           |           |           |               |               |   255, 0 to 255   |
--    |-----------|-----------|-----------|-----------|---------------|---------------|-------------------|
--    | 0         |   0       |  1        |  0        |   1           |   x           | cout[7:0] to 0,   |
--    |           |           |           |           |               |               |   255 to 0        |
--    |-----------|-----------|-----------|-----------|---------------|---------------|-------------------|
--    |   0       |   0       |   x       |   1       |   x           |   cin         |  cin              |
--    |-----------|-----------|-----------|-----------|---------------|---------------|-------------------|
--    | 0         |  1        |  x        |   x       |   x           |   x           | 0                 |
--    |-----------|-----------|-----------|-----------|---------------|---------------|-------------------|
--
--          To change the priority of the clear and load
--    -----------------------------------------------------------------------------------------------------
--    | reset     | clear     | enable    | load      | direction     |   c_in[7:0]   |   c_out[7:0]      |
--    |-----------|-----------|-----------|-----------|---------------|---------------|-------------------|
--    | 0         |  x        |  x        |   1       |   x           |   cin         | cin               |
--    |-----------|-----------|-----------|-----------|---------------|---------------|-------------------|
--    | 0         |  1        |  x        |   0       |   x           |   x           | 0                 |
--    |-----------|-----------|-----------|-----------|---------------|---------------|-------------------|
    



--2)Create a VHDL design file complying with the functional requirements presented in the previous table.
--3)Prove the correctness of your design by simulation in Vivado.
--4)How would you change the function table and design file if you wanted to change the relative priority of the clear and load inputs?



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uni_bin_ctr is
    Port ( clk, rst: in std_logic;
            clr : in std_logic;
            en  : in std_logic;
            lod : in std_logic;
            dir : in std_logic;
            cin : in std_logic_vector(7 downto 0);
            cout: out std_logic_vector (7 downto 0)
                );
end uni_bin_ctr;

architecture arch of uni_bin_ctr is
signal ffin,ffout : unsigned(7 downto 0);
begin
-- state register section
process (clk, rst)
        begin
                if (rst = '1') then
                    ffout <= (others => '0');
                elsif rising_edge(clk) then
                    ffout <= ffin;
                        
        end if;
end process;

ffin <= "00000000" when ( clr = '1'  ) else
        unsigned(cin)  when    ( clr = '0' and lod = '1' ) else  -- clr = '0' is redundant
        ffout + 1 when  ( dir = '0' and en = '1') else
        ffout - 1 when  ( dir = '1' and en = '1') else    --- dir = '1' is redundant
        ffout;

-- if the priority has to be changed between clear and load
-- ffin <= "00000000" when ( lod = '1'  ) else
--         unsigned(cin)  when    ( clr = '1' and lod = '0' ) else
--         ffout + 1 when  ( dir = '0' and en = '1') else
--         ffout - 1 when  ( dir = '1' and en = '1') else
--         ffout;

cout <= std_logic_vector(ffout);

end arch;
