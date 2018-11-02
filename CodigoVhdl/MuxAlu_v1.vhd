----------------------------------------------------------------------------------------------------------------------
-- Actividad : MuxAlu Proyecto
-- Autores : German Andres Caycedo , David Hernandez, Maria Camila Lopez, Alejandro Meza
-- Fecha : 27/10/2018
--
-- archivo : MuxAlu_v1.vhd
----------------------------------------------------------------------------------------------------------------------
-- Descripción : Vamos a hacer el MuxAlu del proyecto
----------------------------------------------------------------------------------------------------------------------
-- cambios :
----------------------------------------------------------------------------------------------------------------------

Library IEEE;
use IEEE.std_logic_1164.all;

Entity MuxAlu_v1 is
	port
	(	registerFile : in std_logic_vector(7 downto 0);
		irA : in std_logic_vector(7 downto 0);
		clk : in std_logic;
		PcSource: in std_logic;
		MuxOut : out std_logic_vector(7 downto 0)
	);

End Entity;


Architecture MuxAlu_v1_arc of MuxAlu_v1 is
	signal temp : std_logic_vector(7 downto 0);
	Begin
		Process (clk,registerFile,irA,temp,PcSource)
		Begin
			if (rising_edge(clk)) then
				if (PcSource = '0') then
					temp <= registerFile;
				end if;
				if (PcSource = '1') then
					temp <= irA;
				end if;
			end if;
			MuxOut <= temp;
		end process;

End Architecture MuxAlu_v1_arc ;



