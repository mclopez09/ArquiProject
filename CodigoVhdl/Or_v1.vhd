----------------------------------------------------------------------------------------------------------------------
-- Actividad : Or_v1 Proyecto
-- Autores : German Andres Caycedo , David Hernandez, Maria Camila Lopez, Alejandro Meza
-- Fecha : 27/10/2018
--
-- archivo : Or_v1.vhd
----------------------------------------------------------------------------------------------------------------------
-- Descripción : Vamos a hacer el Or del proyecto
----------------------------------------------------------------------------------------------------------------------
-- cambios :
----------------------------------------------------------------------------------------------------------------------

Library IEEE;
use IEEE.std_logic_1164.all;

Entity Or_v1 is
	port
	(	
		AndOut : in std_logic;
		PcWrite: in std_logic;
		OrOut : out std_logic
	);

End Entity;

Architecture Or_v1_arc of Or_v1 is
	Begin

	OrOut <= PcWrite or AndOut;


End Architecture Or_v1_arc ;
