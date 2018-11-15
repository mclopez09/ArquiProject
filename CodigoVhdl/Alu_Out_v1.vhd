----------------------------------------------------------------------------------------------------------------------
-- Actividad : Alu_Out Proyecto
-- Autores : German Andres Caycedo , David Hernandez, Maria Camila Lopez, Alejandro Meza
-- Fecha : 20/10/2018
--
-- archivo : Alu_Out_v1.vhd
----------------------------------------------------------------------------------------------------------------------
-- Descripción : Vamos a hacer la alu out del proyecto
----------------------------------------------------------------------------------------------------------------------
-- cambios :
----------------------------------------------------------------------------------------------------------------------

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity Alu_out_v1 is
	generic (NAluOut: positive := 8);
	port(
		dataAlu : in std_logic_vector(NAluOut-1 downto 0);
		RESULOUT: out std_logic_vector(NAluOut-1 downto 0);
		oeAluOut: in std_logic
	);
End Entity;


Architecture Alu_out_v1_arc of Alu_out_v1 is
Begin

	RESULOUT <= dataAlu;

End Architecture Alu_out_v1_arc;