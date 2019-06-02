library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MaqCalcular_Fase1_Tb is
end MaqCalcular_Fase1_Tb;

architecture Structural of MaqCalcular_Fase1_Tb is
	signal s_clk : std_logic;
	signal s_SW : std_logic_vector(17 downto 0);
	signal s_KEY : std_logic_vector(3 downto 0);
	signal s_LEDR : std_logic_vector(7 downto 0);
	signal s_LEDG : std_logic_vector(7 downto 0);
	signal s_HEX0 : std_logic_vector(6 downto 0);
	signal s_HEX1 : std_logic_vector(6 downto 0);
	signal s_HEX2 : std_logic_vector(6 downto 0);
	signal s_HEX3 : std_logic_vector(6 downto 0);
	signal s_HEX4 : std_logic_vector(6 downto 0);
	signal s_HEX5 : std_logic_vector(6 downto 0);
begin

	uut: entity work.MaqCalcular_Fase1(Struct)
		port map(CLOCK_50 => s_clk,
					SW => s_SW,
					KEY => s_KEY,
					LEDR => s_LEDR,
					LEDG => s_LEDG,
					HEX0 => s_HEX0,
					HEX1 => s_HEX1,
					HEX2 => s_HEX2,
					HEX3 => s_HEX3,
					HEX4 => s_HEX4,
					HEX5 => s_HEX5);
	
	clock_proc : process
	begin
		s_clk <= '0' ; wait for 20 ns;
		s_clk <= '1' ; wait for 20 ns;
	end process;
	
	stim_proc : process
	begin
		wait for 20 ns;
		s_SW(16) <= '1';
		s_KEY <= "1111";
		
		wait for 25 ns;
		s_SW(15 downto 8) <= "00000011";
		s_SW(7 downto 0) <= "00000010";
		s_KEY(0) <= '0';
		
		wait for 50 ns;
		s_KEY(0) <= '1';
		
		wait for 50 ns;
		s_SW(17) <= '1';
		
		wait for 25 ns;
		s_SW(17) <= '0';
		
		wait for 20 ns;
		s_SW(15 downto 8) <= "00001000";
		s_SW(7 downto 0) <= "00000011";
		s_KEY(1) <= '0';
		
		wait for 10 ns;
		s_KEY(1) <= '1';
		
		s_SW(15 downto 8) <= X"FF";
		s_SW(7 downto 0) <= X"FF";
		
		wait for 25 ns;
		s_KEY(0) <= '0';
		wait for 10 ns;
		s_KEY(0) <= '1';
		
		wait for 125 ns;
	end process;
end Structural;