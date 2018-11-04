----------------------------------------------------------------------------------------------------------------------
-- Actividad : PC Proyecto
-- Autores : German Andres Caycedo , David Hernandez, Maria Camila Lopez, Alejandro Meza
-- Fecha : 20/10/2018
--
-- archivo : PC_v1.vhd
----------------------------------------------------------------------------------------------------------------------
-- Descripción : Vamos a hacer el PC del proyecto
----------------------------------------------------------------------------------------------------------------------
-- cambios :
----------------------------------------------------------------------------------------------------------------------

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity PC_v1 is
	generic (N: positive := 8 ; M: positive := 16);
	port
	(	MuxPc : in std_logic_vector(N-1 downto 0);
		PcOut : out std_logic_vector(M-1 downto 0);
		clk : in std_logic;
		PcSig: in std_logic
	);

End Entity;

Architecture PC_v1_arc of PC_v1 is
	signal temp : std_logic_vector(7 downto 0);
	signal temp2 : std_logic_vector(15 downto 0);
	Begin
		Process (clk,PcSig,temp)
		Begin
			if (rising_edge(clk)and PcSig = '1') then
				temp <= "00000001";
				temp2 <= std_logic_vector(unsigned(MuxPc) *	unsigned(temp));
			end if;
			PcOut <= temp2;
		end process;

End Architecture PC_v1_arc ;






