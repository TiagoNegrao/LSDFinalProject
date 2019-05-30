library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Calcular is
	port(clk : in std_logic;
			 reset : in std_logic;
			 start : in std_logic;
			 op1 : in std_logic_vector(7 downto 0);
			 op2 : in std_logic_vector(7 downto 0);
			 operation: in std_logic_vector(3 downto 0);
			 res : out std_logic_vector(7 downto 0);
			 hi_res : out std_logic_vector(7 downto 0);
			 overflow : out std_logic := '0');
end Calcular;

architecture Struct of Calcular is
	signal s_op1, s_op2, s_res : signed(7 downto 0);
	signal s_operation : std_logic_vector(2 downto 0) := "100";

	begin
		s_op1 <= signed(op1);
		s_op2 <= not signed(op2) + 1 when (s_operation = "001") else signed(op2);
	
		process(clk)
		begin
			if(rising_edge(clk)) then
				if(reset = '1') then
					s_res <= (others => '0');
				elsif(start = '1') then
				if(operation(0) = '0') then
							s_operation <= "000";
						elsif(operation(1) = '0') then
							s_operation <= "001";
						elsif(operation(2) = '0') then
							s_operation <= "010";
						elsif(operation(3) = '0') then
							s_operation <= "011";
						else
							s_operation <= "100";
						end if;
					
					case s_operation is
						
						when "000" | "001" =>
							if(s_op1(7) = s_op2(7) and s_op1(7) /=s_res(7)) then
								overflow <= '1';
								s_res <= (others => '0');
							else
								overflow <= '0';
								s_res <= s_op1 + s_op2;
							end if;
						when others =>
							s_res <= s_res;
							
					end case;
				end if;
			end if;
			res <= std_logic_vector(s_res);
		end process;
end Struct;