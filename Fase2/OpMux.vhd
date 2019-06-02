library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity OpMux is
	port(selection_Op : in std_logic_vector(3 downto 0);
		  raiz : in std_logic;
		  res_SumSub : in std_logic_vector(15 downto 0);
		  res_Mult : in std_logic_vector(15 downto 0);
		  res_D : in std_logic_vector(15 downto 0);
		  res_R : in std_logic_vector(7 downto 0);
		  res_Raiz : in std_logic_vector(15 downto 0);
		  res : out std_logic_vector(15 downto 0);
		  remain : out std_logic_vector(7 downto 0));
end OpMux;

architecture Struct of OpMux is

begin
	process(selection_Op, res_SumSub, res_Mult, res_Raiz)
	begin
	
	if(raiz = '0') then
		case selection_Op is
		when "1110" | "1101" =>
			res <= res_SumSub;
			remain <= (others => '0');
		
		when "1011" =>
			res <= res_Mult;
			remain <= (others => '0');
		
		when "0111" =>
			res <= res_D;
    		remain <= res_R;
		
		when others =>
			res <= (others => '0');
			remain <= (others => '0');
		
		end case;
	else
		res <= res_Raiz;
	end if;
	end process;
end Struct;