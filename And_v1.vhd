----------------------------------------------------------------------------------------------------------------------
-- Actividad : And_v1 Proyecto
-- Autores : German Andres Caycedo , David Hernandez, Maria Camila Lopez, Alejandro Meza
-- Fecha : 27/10/2018
--
-- archivo : And_v1.vhd
----------------------------------------------------------------------------------------------------------------------
-- Descripción : Vamos a hacer el And del proyecto
----------------------------------------------------------------------------------------------------------------------
-- cambios :
----------------------------------------------------------------------------------------------------------------------

Library IEEE;
use IEEE.std_logic_1164.all;

Entity And_v1 is
	port
	(	
		PcWriteCond : in std_logic;
		AluZero: in std_logic;
		AndOut : out std_logic
	);

End Entity;

Architecture And_v1_arc of And_v1 is
	Begin

	AndOut <= PcWriteCond and AluZero;


End Architecture And_v1_arc ;

