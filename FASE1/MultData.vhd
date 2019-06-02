library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity MultData is

port (clk			: in 	std_logic;
		start			: in 	std_logic;
		operando1	: in 	std_logic_vector (7 downto 0);
		operando2	: in 	std_logic_vector (7 downto 0);
		result		: out std_logic_vector (15 downto 0);
		done			: out std_logic);
		
end MultData;



architecture Behav of MultData is

	type Tstate is (SR, S1, S2, S3, S4, S5, S6, S7, S8, S9);
						
	signal s_nextState: TState;

	signal s_result	: unsigned (15 downto 0);
	signal s_operando1: unsigned (15 downto 0);
	
begin
	
	process (clk)
	begin
	
		if (rising_edge(clk)) then
			
			case s_nextState is
			when SR => 
				done <= '0';
				s_operando1 <= "00000000" & unsigned(operando1);
				s_result 	<= (others => '0');
				if (start = '0') then
					s_nextState <= S1;
				end if;
			when S1 => 
				if (operando2(0) = '1') then
					s_result <= s_result + s_operando1;
				else
					s_result <= s_result;
				end if;
				s_operando1	<= s_operando1(14 downto 0) & '0';
				s_nextState <= S2;
				
			when S2 =>
				if (operando2(1) ='1') then
					s_result <= s_result + s_operando1;
				else
					s_result <= s_result;
				end if;
				s_operando1	<= s_operando1(14 downto 0) & '0';
				s_nextState <= S3;
				
			when S3 =>
				if (operando2(2) ='1') then
					s_result <= s_result + s_operando1;
				else
					s_result <= s_result;
				end if;
				s_operando1	<= s_operando1(14 downto 0) & '0';
				s_nextState <= S4;
				
			when S4 =>
				if (operando2(3) ='1') then
					s_result <= s_result + s_operando1;
				else
					s_result <= s_result;
				end if;
				s_operando1	<= s_operando1(14 downto 0) & '0';
				s_nextState <= S5;
				
			when S5 =>
				if (operando2(4) ='1') then
					s_result <= s_result + s_operando1;
				else
					s_result <= s_result;
				end if;
				s_operando1	<= s_operando1(14 downto 0) & '0';
				s_nextState <= S6;
				
			when S6 =>
				if (operando2(5) ='1') then
					s_result <= s_result + s_operando1;
				else
					s_result <= s_result;
				end if;
				s_operando1	<= s_operando1(14 downto 0) & '0';
				s_nextState <= S7;
				
			when S7 =>
				if (operando2(6) ='1') then
					s_result <= s_result + s_operando1;
				else
					s_result <= s_result;
				end if;
				s_operando1	<= s_operando1(14 downto 0) & '0';
				s_nextState <= S8;
				
			when S8 =>
				if (operando2(7) ='1') then
					s_result <= s_result + s_operando1;
				else
					s_result <= s_result;
				end if;
				s_operando1	<= s_operando1(14 downto 0) & '0';
				s_nextState	<= S9;
			
			when S9 =>
				done <= '1';
				s_nextState <= SR;
				
			end case;	
		end if;
		result <= std_logic_vector (s_result);
	end process;	
end Behav;
		