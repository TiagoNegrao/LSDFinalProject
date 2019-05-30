library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ControlPath is
	port(clk : in std_logic;
			 reset : in std_logic;
			 start : in std_logic;
			 INPUT : in std_logic_vector(3 downto 0);
			 opComplete : out std_logic;
			 en_OPC : out std_logic := '0');
end ControlPath;

architecture Struct of ControlPath is

	signal s_op1, s_op2 : std_logic_vector( 7 downto 0);
	signal s_res : std_logic_vector(7 downto 0);

	type TState is (ST_RESET, ST_START, ST_OPC, ST_RES);
	signal s_current, s_next : TState;
	
	subtype TCounter is natural range 0 to 3;
	signal s_memoryCNT : TCounter;
	
	begin
		process(clk)
		begin
			
			if(rising_edge(clk)) then
				if(reset = '1') then
					s_current <= ST_RESET;
				else
					s_current <= s_next;
				end if;
			end if;
		
		end process;
		
		process(clk)
		begin
		
			if(rising_edge(clk)) then
				if(s_current = ST_RESET) then
					s_memoryCNT <= 0;
				elsif(s_current = ST_RES) then
					s_memoryCNT <= s_memoryCNT + 1;
				end if;
			end if;
			
		end process;
		
		process(INPUT, start, s_current)
		begin
			case s_current is
				when ST_RESET =>
					s_next <= ST_START;
				
				when ST_START =>
					if(start = '1') then
						s_next <= ST_OPC;
					end if;
							
				when ST_OPC =>
					en_OPC <= '1';
					opComplete <= '0';
					
					if(INPUT /= "1111") then
						s_next <= ST_RES;
					end if;
					
				when ST_RES =>
					opComplete <= '1';
					if(s_memoryCNT < 3) then
						s_next <= ST_OPC;
					else
						s_next <= ST_RESET;
					end if;
				end case;
		end process;
end Struct;	
