library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Raiz is

generic(N : integer := 2);
port (clk, start, reset	: in std_logic;
		operando 			: in std_logic_vector (7 downto 0);
		result				: out std_logic_vector(15 downto 0));
		
end Raiz;

architecture Behav of Raiz is

type Tstate is (S1, S2, S3, S4, S5);

	signal s_op1 					: unsigned (7 downto 0);
	signal s_resultado, s_conta: unsigned (7 downto 0);
	signal count_i    			: std_logic_vector (7 downto 0);
	signal s_currentState, s_nextState : TState;
	
begin
	
	s_op1 <= unsigned (operando);
	
	process(clk)
	begin
	
	if (rising_edge(clk)) then
		if (reset = '1') then
			s_currentState <= S1;
		else
			s_currentState <= s_nextState;
		end if;
	end if;
	end process;
	
	
	process (clk)
	begin
	
		if (rising_edge(clk)) then
		
		s_conta <= (to_unsigned(N,8) + (s_op1 / to_unsigned(N, 8))) / 2 ;
		--The number s_conta is a better approximation to sqrt(s_op1)
		
				case s_currentState is
				when S1 =>
					if (start = '1') then
						s_nextState <= S2;
					end if;
					
			
				when S2 =>
					s_conta <= (unsigned(s_conta) + (s_op1 / unsigned(s_conta))) / 2 ;
					s_nextState <= S3;
					-- we apply this formula until the process converges (approx. 4 times). 
				when S3 =>
					s_conta <= (unsigned(s_conta) + (s_op1 / unsigned(s_conta))) / 2 ;
					s_nextState <= S4;
					
				when S4 =>
					s_conta <= (unsigned(s_conta) + (s_op1 / unsigned(s_conta))) / 2 ;
					s_nextState <= S5;
					
				when S5 =>
					s_conta <= (unsigned(s_conta) + (s_op1 / unsigned(s_conta))) / 2 ;
				end case;
		end if;		
	end process;
	
	result <= "00000000" & std_logic_vector(s_conta(7 downto 0));
			
end Behav;	
		
		
		