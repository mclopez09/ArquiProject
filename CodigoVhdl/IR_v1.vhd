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

	generic (N: positive := 16 ; M: positive := 4);

	port
	(	instruccion,outjump : in std_logic_vector(N downto 0);
		oeir,irwrite: inout std_logic;
		clk : in std_logic;
		opcode : out std_logic_vector(M downto 0);
		outrd,outrs,outrt : out std_logic_vector(M downto 0):="0000"
	);
end entity;
Architecture IR_v1_arc of IR_v1 is
signal opcodetmp : std_logic_vector(3 downto 0);
	Begin
	process(clk,irwrite)
	Begin
	if (rising_edge(clk) and irwrite='1') then
		opcodetmp(0)<=instruccion(12);
		opcodetmp(1)<=instruccion(13);
		opcodetmp(2)<=instruccion(14);
		opcodetmp(3)<=instruccion(15);
	end if;
	end process;
	process(clk,oeir,irwrite)
	Begin
	if (rising_edge(clk)) then
			if (opcodetmp="0000" OR opcodetmp="0010" OR opcodetmp="0011") then
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
			elsif (opcodetmp="1010" ) then
				oeir <= '1';
				outjump(0)<=instruccion(0);
				outjump(1)<=instruccion(1);
				outjump(2)<=instruccion(2);
				outjump(3)<=instruccion(3);
				outjump(4)<=instruccion(4);
				outjump(5)<=instruccion(5);
				outjump(6)<=instruccion(6);
				outjump(7)<=instruccion(7);
			elsif (opcodetmp="1111") then
				outjump<=NULL;
				outrd<=NULL;
				outrs<=NULL;
				outrt<=NULL;
			else
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
			end if;
	end if;
	end process;
	opcode<=opcodetmp;
End Architecture IR_v1_arc;
