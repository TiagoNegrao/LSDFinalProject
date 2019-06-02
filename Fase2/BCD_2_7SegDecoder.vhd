--SOMA = SUM = 00101 + 10100 + 10011
--SUBTRAÇÃO = SUb = 00101 + 10100 + 01011
--DIVISÃO = dIv = 01101 + 00001 + 10010
--MULTIPLICAÇÃO = MULP = 10011 + 10100 + 10101 + 10110
--Raiz Quadrada = rAIZ = 10111 + 01010 + 00001 + 00010
--Overflow (ERRO) = ovF =  10001 + 10010 + 01111
--Dividir por 0 (ERRO) = dIv_0 = 01101 + 00001 + 10010 + 11000 + 00000

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity BCD_2_7SegDecoder is
	port(enable : in std_logic;
		  binInput: in std_logic_vector(4 downto 0);
		  decOut_n: out std_logic_vector(6 downto 0));
end BCD_2_7SegDecoder;

architecture Behavioural of BCD_2_7SegDecoder is
begin 
	 decOut_n <= 
					 "1111111" when (enable = '0') else --X
					 "1000000" when (binInput = "00000") else --0
					 "1111001" when (binInput = "00001") else --1 // I
					 "0100100" when (binInput = "00010") else --2 // Z
					 "0110000" when (binInput = "00011") else --3
					 "0011001" when (binInput = "00100") else --4
					 "0010010" when (binInput = "00101") else --5 // S
					 "0000010" when (binInput = "00110") else --6
					 "1111000" when (binInput = "00111") else --7
					 "0000000" when (binInput = "01000") else --8
					 "0010000" when (binInput = "01001") else --9
					 "0001000" when (binInput = "01010") else --A
					 "0000011" when (binInput = "01011") else --b
					 "1000110" when (binInput = "01100") else --C
					 "0100001" when (binInput = "01101") else --d
					 "0000110" when (binInput = "01110") else --E
					 "0001110" when (binInput = "01111") else --F
					 -------------------------------------------------
					 "0111111" when (binInput = "10000") else -- '-'
					 "0100011" when (binInput = "10001") else -- o
					 "1100011" when (binInput = "10010") else -- v
					 "1001000" when (binInput = "10011") else --M
					 "1000001" when (binInput = "10100") else --U
					 "1000111" when (binInput = "10101") else --L
					 "0001100" when (binInput = "10110") else --P
					 "0101111" when (binInput = "10111") else --r 
					 "1110111" when (binInput = "11000") else -- '_'
					 "0001001"; -- NADA
end Behavioural;