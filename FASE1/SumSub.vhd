library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity SumSub is
	port(clk : in std_logic;
		  sum_or_sub : in std_logic;
		  operand0 : in std_logic_vector(7 downto 0);
		  operand1 : in std_logic_vector(7 downto 0);
		  result : out std_logic_vector(15 downto 0);
		  overflow : out std_logic);
end SumSub;

architecture Algorithm of SumSub is
	signal s_result : signed(15 downto 0);
	signal s_op0, s_op1 : signed(7 downto 0);
begin

	s_op0 <= signed(operand0);
	s_op1 <= not signed(operand1) + 1 when (sum_or_sub = '1') else signed(operand1);

	process(clk)
	begin
		if(rising_edge(clk)) then
			s_result(7 downto 0) <= s_op0 + s_op1;
		
			if(operand0(7) = operand1(7) and s_result(7) /= operand0(7)) then
				s_result <= (others => '0');
				overflow <= '1';
			else
				overflow <= '0';
			end if;
			
			if(s_result(7) = '1') then
				s_result(15 downto 8) <= (others => '1');
			else
				s_result(15 downto 8) <= (others => '0');
			end if;
			
		end if;
		result <= std_logic_vector(s_result);
	end process;
end Algorithm;