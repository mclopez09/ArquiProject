----------------------------------------------------------------------------------------------------------------------
-- Actividad : Data In Proyecto
-- Autores : German Andres Caycedo , David Hernandez, Maria Camila Lopez, Alejandro Meza
-- Fecha : 20/10/2018
--
-- archivo : Arquitectura_v1.vhd
----------------------------------------------------------------------------------------------------------------------
-- Descripción : Vamos a hacer el Data In (Input) del proyecto
----------------------------------------------------------------------------------------------------------------------
-- cambios :
----------------------------------------------------------------------------------------------------------------------

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity DataIn_v1 is
	generic(Ndata: positive :=8);
	port
	(input: in std_logic_vector(Ndata-1 downto 0);
	salida: out std_logic_vector(Ndata-1 downto 0);
	ent: in std_logic
	);

End entity;

Architecture DataIn_arc_v1 of DataIn_v1 is
begin
	process(ent) is
	begin
		if(ent = '1') then	
			salida <= input;
		end if;
	end process;
end architecture;