----------------------------------------------------------------------------------------------------------------------
-- Actividad : MuxPc Proyecto
-- Autores : German Andres Caycedo , David Hernandez, Maria Camila Lopez, Alejandro Meza
-- Fecha : 20/10/2018
--
-- archivo : MuxPc_v1.vhd
----------------------------------------------------------------------------------------------------------------------
-- Descripción : Vamos a hacer el MuxPc del proyecto
----------------------------------------------------------------------------------------------------------------------
-- cambios :
----------------------------------------------------------------------------------------------------------------------

Library IEEE;
use IEEE.std_logic_1164.all;

Entity MuxPc_v1 is
	generic (Nmuxpc: positive := 8);
	port
	(	Jump : in std_logic_vector(Nmuxpc-1 downto 0);
		Adder : in std_logic_vector(Nmuxpc-1 downto 0);
		clk : in std_logic;
		PcSource: in std_logic;
		MuxOut : out std_logic_vector(Nmuxpc-1 downto 0)
	);

End Entity;


Architecture MuxPc_v1_arc of MuxPc_v1 is
	signal temp : std_logic_vector(7 downto 0);
	Begin
		Process (clk,Jump,Adder,temp,PcSource)
		Begin
			if (rising_edge(clk)) then
				if (PcSource = '0') then
					temp <= Jump;
				end if;
				if (PcSource = '1') then
					temp <= Adder;
				end if;
			end if;
			MuxOut <= temp;
		end process;

End Architecture MuxPc_v1_arc ;



