library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity BIN2BCD is
	generic(N : integer := 16); --Parametrização para em casos em que sejam necessários 16 bits (multiplicação) ou 8 bits
	port(enable : in std_logic;
			 input : in std_logic_vector(N - 1 downto 0); --entrada em binário
			 uniOut : out std_logic_vector(4 downto 0); --Digito das unidades BCD
			 decOut: out std_logic_vector(4 downto 0); --Digito das décimas BCD
			 cenOut: out std_logic_vector(4 downto 0); --Digito das centésimas BCD
			 milOut : out std_logic_vector(4 downto 0); -- Digito dos milhares BCD
			 cenmilOut : out std_logic_vector(4 downto 0); --Dígito da centésima de milhares BCD
			 sinal : out std_logic; --Indicação de sinal negativo, sinal = '1' se input < 0
			 signalBit : out std_logic_vector(4 downto 0) := "10000"); --Entrada para o codificador de 7 segmentos com o intuito de demonstar o sinal '-' no display HEX
end BIN2BCD;

architecture Behav of BIN2BCD is
	signal s_uni, s_dec, s_cen, s_mil, s_cenmil : std_logic_vector(4 downto 0);
	signal s_input : unsigned(N-1 downto 0);
	
	begin
	
	--definição do valor a tomar pelo sinal interno sendo que depende do número de bits N e do estado do MSB (N-1) sendo este indicador de sinal
	s_input <= unsigned(not input) + 1 when ((N = 16 and input(15) = '1') or (N = 8 and input(7) = '1')) else unsigned(input); 
	
	--definição do valor a tomar pela saída indicadora do sinal
	sinal <= '1' when ((N = 16 and input(15) = '1') or (N = 8 and input(7) = '1')) else '0';
	
	s_uni <= std_logic_vector(s_input rem 10);
	s_dec <= std_logic_vector((s_input / 10) rem 10);
	s_cen <= std_logic_vector((s_input / 100) rem 10);
	s_mil <= std_logic_vector((s_input / 1000) rem 10 );
	s_cenmil <= std_logic_vector((s_input / 10000) rem 10);
	
	uniOut <= "10000" when (enable = '0') else s_uni;
	decOut <="10000" when (enable = '0') else s_dec;
	cenOut <="10000" when (enable = '0') else s_cen;
	milOut <= "10000" when (enable = '0') else s_mil;
	cenmilOut <= "10000" when (enable = '0') else s_cenmil;
	
end Behav;