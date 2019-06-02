library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity OpMux is
	port(selection_Op : in std_logic_vector(2 downto 0);
		  res_SumSub : in std_logic_vector(15 downto 0);
		  --res_MultDiv : in std_logic_vector(15 downto 0);
		  res : out std_logic_vector(15 downto 0));
		  --remain : out std_logic_vector(7 downto 0));
end OpMux;

architecture Struct of OpMux is

begin
	process(selection_Op)
	begin
	
		case selection_Op is
		when "000" | "001" =>
			res <= res_SumSub;
			--remain <= (others => '0');
		
		--when "010" =>
			--res <= res_MultDiv;
			--remain <= (others => '0');
		
		--when "011" =>
			--res <= "00000000" & res_MultDiv(7 downto 0);
			--remain <= res_MultDiv(15 downto 8);*/
		
		when others =>
			res <= res_SumSub;
			--remain <= (others => '0');
		
		end case;
	end process;
end Struct;