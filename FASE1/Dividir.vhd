library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Dividir is
	port(clk : in std_logic;
		  start : in std_logic;
		  reset : in std_logic;
		  quotient : in std_logic_vector(7 downto 0);
		  divisor : in std_logic_vector(7 downto 0);
		 -- busy : out std_logic;
		  --done : out std_logic;
		 -- add_en : out std_logic;
		  reset_out : out std_logic;
		  remainder : out std_logic_vector(7 downto 0);
		  dividend : out std_logic_vector(7 downto 0));
end Dividir;

architecture Logic of Dividir is
	type TState is (ST_IDLE, ST_START, ST_QGTD, ST_ADD, ST_REM);
	signal s_currentState, s_nextState : TState;
	
	signal s_quotient : std_logic_vector(7 downto 0);
	signal s_dividend : std_logic_vector(7 downto 0) := (others => '0');
	
begin
		process(clk, reset)
		begin
			if(reset = '1') then
				s_currentState <= ST_IDLE;
			elsif(rising_edge(clk)) then
				s_currentState <= s_nextState;
				
			end if;
		end process;
		
		process(clk)
		begin
			if(rising_edge(clk)) then
				if(s_currentState = ST_IDLE) then
					s_quotient <= quotient;
				elsif (s_currentState = ST_ADD) then
					s_quotient <= std_logic_vector(unsigned(s_quotient) - unsigned(divisor));
					s_dividend <= std_logic_vector(unsigned(s_dividend) + 1);
					
				end if;
			end if;
		end process;
		
		process(s_currentState, start, quotient, divisor)
		begin
			s_nextState <= s_currentState;
			
			case s_currentState is
			when ST_IDLE =>
				if(start = '1') then
					if(s_dividend = "00000000") then
					s_nextState <= ST_START;
				else
					s_nextState <= ST_IDLE;
				end if;
				end if;
			
			when ST_START =>
				s_nextState <= ST_QGTD;
				
			when ST_QGTD =>
				if(s_quotient < divisor) then
					s_nextState <= ST_REM;
				else
					s_nextState <= ST_ADD;
				end if;
			
			when ST_ADD =>
				s_nextState <= ST_QGTD;
			
			when ST_REM =>
				s_nextState <= ST_IDLE;
			
			
			end case;
		end process;
		
		process(s_currentState)
		begin
			----busy <= '0';
			--done <= '0';
			--add_en <= '0';
			reset_out <= '0';
			remainder <= (others => '0');
			dividend <= (others => '0');
		
			case s_currentState is
			when ST_IDLE =>
				--add_en <= '0';
				--done <= '1';
				--busy <= '0';
				--reset_out <= '0';
				
			when ST_START =>
				remainder <= (others => '0');
				dividend <= (others => '0');
				--add_en <= '0';
				--done <= '0';
				--busy <= '1';
				--reset_out <= '1';
				
			when ST_ADD =>
				--add_en <= '1';
				--done <= '0';
				--busy <= '1';
				--reset_out <= '0';
			
			when ST_REM => 
				remainder <= s_quotient;
				--add_en <= '0';
				--done <= '0';
				--busy <= '1';
				--reset_out <= '0';
			
			when others =>
				--add_en <= '0';
				--done <= '0';
				--busy <= '1';
				reset_out <= '0';
			
			end case;
		end process;
end Logic;

architecture Logic_sync of Dividir is
	type TState is (ST_IDLE, ST_START, ST_QGTD, ST_ADD, ST_REM);
	signal s_state: TState;
	
	signal s_quotient : std_logic_vector(7 downto 0);
	signal s_dividend : std_logic_vector(7 downto 0);
	
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(reset = '1') then
				s_state <= ST_IDLE;
				--busy <= '0';
				--done <= '1';
				--add_en <= '0';
				reset_out <= '0';
			else
				case s_state is
				when ST_IDLE =>
					if(start = '1') then
						s_state <= ST_START;
						--busy <= '1';
						--done <= '0';
						reset_out <= '1';
						
					end if;
				
				when ST_START =>
					s_quotient <= (others => '0');
					s_dividend <= (others => '0');
					s_state <= ST_QGTD;
					reset_out <= '0';
					--add_en <= '0';
				
				when ST_QGTD =>
					if(s_quotient < divisor) then
						s_state <= ST_REM;
						remainder <= s_quotient;
					else
						s_state <= ST_ADD;
						--add_en <= '1';
						s_quotient <= std_logic_vector(unsigned(s_quotient) - unsigned(divisor));
						s_dividend <= std_logic_vector(unsigned(s_dividend) + 1);
					end if;
				
				when ST_ADD =>
					s_state <= ST_QGTD;
					--add_en <= '0';
					
				when ST_REM =>
					s_state <= ST_IDLE;
					--busy <= '0';
					--done <= '1';
					remainder <= s_quotient;
					dividend <= s_dividend;
				end case;
			end if;
		end if;
	end process;
end Logic_sync;
				
						