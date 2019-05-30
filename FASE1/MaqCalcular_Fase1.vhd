library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity MaqCalcular_Fase1 is
	port(CLOCK_50 : in std_logic;
			 SW : in std_logic_vector(17 downto 0);
			 KEY : in std_logic_vector(3 downto 0);
			 LEDR : out std_logic_vector(7 downto 0);
			 LEDG : out std_logic_vector(7 downto 0);
			 HEX0 : out std_logic_vector(6 downto 0);
			 HEX1 : out std_logic_vector(6 downto 0);
			 HEX2 : out std_logic_vector(6 downto 0);
			 HEX3 : out std_logic_vector(6 downto 0);
			 HEX4 : out std_logic_vector(6 downto 0);
			 HEX5 : out std_logic_vector(6 downto 0));
end MaqCalcular_Fase1;

architecture Struct of MaqCalcular_Fase1 is
	signal resultado : std_logic_vector(15 downto 0);
	signal s_uni, s_dec, s_cen, s_mil, s_cenmil, s_sinal : std_logic_vector(4 downto 0);
	signal s_operation : std_logic_vector(3 downto 0);
	signal indSinal, s_startOperation : std_logic;
	signal s_indOperation : std_logic_vector(2 downto 0);
	begin
			Debounce0 : entity work.Debouncer(fancy)
				port map(clock => CLOCK_50,
							reset => SW(17),
							dirty => KEY(0),
							clean=> s_operation(0));
			
			Debounce1: entity work.Debouncer(fancy)
				port map(clock => CLOCK_50,
							reset => SW(17),
							dirty => KEY(1),
							clean=> s_operation(1));
			
			Debounce2 : entity work.Debouncer(fancy)
				port map(clock => CLOCK_50,
							reset => SW(17),
							dirty => KEY(2),
							clean=> s_operation(2));
			
			
			Debounce3: entity work.Debouncer(fancy)
				port map(clock => CLOCK_50,
							reset => SW(17),
							dirty => KEY(3),
							clean=> s_operation(3));
			
			ControlPath : entity work.ControlPath(Struct)
				port map(clk => CLOCK_50,
									reset => SW(17),
									start => SW(16),
									INPUT => s_operation,
									opComplete => LEDG(0),
									en_OPC => s_startOperation);
			
			Calculador: entity work.Calcular(Struct)
				port map(clk => CLOCK_50,
								  reset => SW(17),
								  start => s_startOperation,
								  op1 => SW(15 downto 8), 
								  op2 => SW(7 downto 0),
								  operation => s_operation,
								  res => resultado(7 downto 0),
								  hi_res => resultado(15 downto 8),
								  overflow => LEDR(0));
									
			BIN2BCD : entity work.BIN2BCD(Behav)
				port map(enable => SW(16),
									 input => resultado(7 downto 0),
									 uniOut => s_uni,
									 decOut =>s_dec,
									 cenOut =>s_cen,
									 milOut =>s_mil,
									 cenmilOut =>s_cenmil,
									 sinal => indSinal,
									 signalBit => s_sinal);
									 
			BCD27Seg_uni : entity work.BCD_2_7SegDecoder(Behavioural)
				port map(enable => SW(16),
									 binInput => s_uni,
									 decOut_n => HEX0);
			
			BCD27Seg_dec : entity work.BCD_2_7SegDecoder(Behavioural)
				port map(enable => SW(16),
									 binInput => s_dec,
									 decOut_n => HEX1);
									 
			BCD27Seg_cen : entity work.BCD_2_7SegDecoder(Behavioural)
				port map(enable => SW(16),
									 binInput => s_cen,
									 decOut_n => HEX2);						
									 
			BCD27Seg_mil : entity work.BCD_2_7SegDecoder(Behavioural)
				port map(enable => SW(16),
									 binInput => s_mil,
									 decOut_n => HEX3);
			
			BCD27Seg_cenmil : entity work.BCD_2_7SegDecoder(Behavioural)
				port map(enable => SW(16),
									 binInput => s_cenmil,
									 decOut_n => HEX4);	
									 
			BCD27Seg_sinal : entity work.BCD_2_7SegDecoder(Behavioural)
				port map(enable => indSinal,
									 binInput => s_sinal,
									 decOut_n => HEX5);	
	end Struct;					 