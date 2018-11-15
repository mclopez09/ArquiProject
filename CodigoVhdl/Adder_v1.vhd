----------------------------------------------------------------------------------------------------------------------
-- Actividad : Adder Proyecto
-- Autores : German Andres Caycedo , David Hernandez, Maria Camila Lopez, Alejandro Meza
-- Fecha : 20/10/2018
--
-- archivo : Adder_v1.vhd
----------------------------------------------------------------------------------------------------------------------
-- Descripción : Vamos a hacer el adder del proyecto
----------------------------------------------------------------------------------------------------------------------
-- cambios :
----------------------------------------------------------------------------------------------------------------------

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity Adder_v1 is
	generic (Nadder: positive := 8);
	port
	(	Pc: inout std_logic_vector(Nadder-1 downto 0);
		OUTADDER: out std_logic_vector(Nadder-1 downto 0)
	);

End Entity;

Architecture Adder_v1_arc of Adder_v1 is
	Begin
		Pc <= std_logic_vector(unsigned(Pc) + 1);
End Architecture Adder_v1_arc;