library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Calcular is
	port(clk : in std_logic;
		  start : in std_logic;
		  operation: in std_logic_vector(3 downto 0);
		  en_SumSub : out std_logic;
		  --en_MultDiv : out std_logic;
		  s_operation : out std_logic_vector(2 downto 0));
end Calcular;

architecture Struct of Calcular is
	begin
		process(clk)
		begin
			if(rising_edge(clk)) then
				if(start = '1') then
					if(operation = "1110") then
								s_operation <= "000";
								en_SumSub <= '0';
							elsif(operation = "1101") then
								s_operation <= "001";
								en_SumSub <= '1';
							elsif(operation = "1011") then
								s_operation <= "010";
							elsif(operation = "0111") then
								s_operation <= "011";
							else
								s_operation <= "100";
								en_SumSub <= '0';
							end if;
					end if;
			end if;
		end process;
end Struct;