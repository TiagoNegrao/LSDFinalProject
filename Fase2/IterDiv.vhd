library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity IterDiv is
	port(CLOCK_50 : in std_logic;
		  KEY : in std_logic;
		  SW : in std_logic_vector(17 downto 0);
		  LEDR : out std_logic;
		  D : out std_logic_vector(7 downto 0);
		  R : out std_logic_vector(7 downto 0));
end IterDiv;

architecture Structural of IterDiv is
	signal s_globalClock : std_logic;
	signal s_start, s_add, s_done, s_busy, s_reset : std_logic;
	signal s_divisor, s_quociente : std_logic_vector(7 downto 0);
begin		process(CLOCK_50)
	begin
		if(rising_edge(CLOCK_50)) then
			s_start <= not KEY;
		end if;
	end process;

	Dividir : entity work.Dividir(Logic)
		port map(clk => CLOCK_50,
				   start => s_start,
				   reset => '0',
				   quotient => SW(15 downto 8),
				   divisor => SW(7 downto 0),
					reset_out => LEDR,
				   remainder => R,
					dividend => D);
	
	
end Structural;