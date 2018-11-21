----------------------------------------------------------------------------------------------------------------------
-- Actividad : IR Proyecto
-- Autores : German Andres Caycedo , David Hernandez, Maria Camila Lopez, Alejandro Meza
-- Fecha : 20/10/2018-25/10/2018
--
-- archivo : IR_v1.vhd
----------------------------------------------------------------------------------------------------------------------
-- Descripción : Vamos a hacer el IR del proyecto
----------------------------------------------------------------------------------------------------------------------
-- Cambios : Se verifica que todo sea funcional
-- Cambios 2: Se agrega proceso sensible a la señal de escritura del IR para la obtencion del opcode de la instruccion.
----------------------------------------------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity IR_v1 is

	generic (Nir: positive := 20 ; Mir: positive := 4 ; Pir: positive := 8);

	port
	(	instruccion: in std_logic_vector(Nir-1 downto 0);
		oeir,oeirj,irwrite: inout std_logic;
		clk : in std_logic;
		opcode: out std_logic_vector(Mir-1 downto 0);
		opcode2: out std_logic_vector(Mir-1 downto 0);
		opcode3: out std_logic_vector(Mir-1 downto 0);
		outrd,outrs,outrt : out std_logic_vector(Mir-1 downto 0);
		outrd2,outrs2,outrt2 : out std_logic_vector(Mir-1 downto 0);
		outjump, constante, constante_dir : out std_logic_vector(Pir-1 downto 0);
		outjump2, constante2, constante_dir2 : out std_logic_vector(Pir-1 downto 0)
	);
end entity;
Architecture IR_v1_arc of IR_v1 is
signal opcodetmp : std_logic_vector(3 downto 0);
signal opcodetmp2 : std_logic_vector(3 downto 0);
signal tmp: std_logic_vector(Pir-1 downto 0);
signal tmp2: std_logic_vector(Pir-1 downto 0);
signal tmp3: std_logic_vector(Pir-1 downto 0);
	Begin
	process(clk,irwrite)
	Begin
	if (rising_edge(clk) and irwrite='1') then
		opcodetmp(0)<=instruccion(12);
		opcodetmp(1)<=instruccion(13);
		opcodetmp(2)<=instruccion(14);
		opcodetmp(3)<=instruccion(15);
		opcodetmp2(0)<=instruccion(16);
		opcodetmp2(1)<=instruccion(17);
		opcodetmp2(2)<=instruccion(18);
		opcodetmp2(3)<=instruccion(19);
		opcode2<=opcodetmp;
		opcode3<=opcodetmp2;
		
	end if;
	end process;
	process(clk,oeir,irwrite)
	Begin
	if (rising_edge(clk)) then
			if ((opcodetmp="0000" OR opcodetmp="0010" OR opcodetmp="0011") and opcodetmp2="0000") then
				outrd(0)<=instruccion(0);
				outrd(1)<=instruccion(1);
				outrd(2)<=instruccion(2);
				outrd(3)<=instruccion(3);
				outrt(0)<=instruccion(4);
				outrt(1)<=instruccion(5);
				outrt(2)<=instruccion(6);
				outrt(3)<=instruccion(7);
				outrs(0)<=instruccion(8);
				outrs(1)<=instruccion(9);
				outrs(2)<=instruccion(10);
				outrs(3)<=instruccion(11);
				opcode<=opcodetmp;
			elsif (opcodetmp2="1010" ) then
				oeirj <= '1';
				tmp3(0)<=instruccion(0);
				tmp3(1)<=instruccion(1);
				tmp3(2)<=instruccion(2);
				tmp3(3)<=instruccion(3);
				tmp3(4)<=instruccion(4);
				tmp3(5)<=instruccion(5);
				tmp3(6)<=instruccion(6);
				tmp3(7)<=instruccion(7);
				opcode<=opcodetmp2;
				outjump<=tmp3;
				outjump2<=tmp3;
				
			elsif (opcodetmp2="0001") then
				tmp(0)<=instruccion(0);
				tmp(1)<=instruccion(1);
				tmp(2)<=instruccion(2);
				tmp(3)<=instruccion(3);
				tmp(4)<=instruccion(4);
				tmp(5)<=instruccion(5);
				tmp(6)<=instruccion(6);
				tmp(7)<=instruccion(7);
				opcode<=opcodetmp2;
				constante<=tmp;
				constante2<=tmp2;

					
			elsif(opcodetmp2="0100" or opcodetmp2="0101" or opcodetmp2="0110" or opcodetmp2="0111" or opcodetmp2="1000" or opcodetmp2="1001" or opcodetmp2="1101" or opcodetmp2="1110" or opcodetmp2="1011" or opcodetmp2="1100") then
				oeir <= '1';
				tmp2(0)<=instruccion(0);
				tmp2(1)<=instruccion(1);
				tmp2(2)<=instruccion(2);
				tmp2(3)<=instruccion(3);
				tmp2(4)<=instruccion(4);
				tmp2(5)<=instruccion(5);
				tmp2(6)<=instruccion(6);
				tmp2(7)<=instruccion(7);
				outrt(0)<=instruccion(8);
				outrt(1)<=instruccion(9);
				outrt(2)<=instruccion(10);
				outrt(3)<=instruccion(11);
				outrs(0)<=instruccion(12);
				outrs(1)<=instruccion(13);
				outrs(2)<=instruccion(14);
				outrs(3)<=instruccion(15);
				opcode<=opcodetmp2;
				constante_dir<=tmp2;
				constante_dir2<=tmp2;
			else 
				outjump<=NULL;
				outrd<=NULL;
				outrs<=NULL;
				outrt<=NULL;
			end if;
	end if;
	end process;
End Architecture IR_v1_arc;
