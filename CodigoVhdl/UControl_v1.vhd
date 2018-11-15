----------------------------------------------------------------------------------------------------------------------
-- Actividad : Unidad de Cntrol Proyecto
-- Autores : German Andres Caycedo , David Hernandez, Maria Camila Lopez, Alejandro Meza
-- Fecha : 20/10/2018
--
-- archivo : UControl_v1.vhd
----------------------------------------------------------------------------------------------------------------------
-- Descripción : Vamos a hacer la unidad de control del proyecto
----------------------------------------------------------------------------------------------------------------------
-- cambios :
------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity UControl_v1 is

	port
	(
		clk : in	std_logic;
		pcwritecond : out std_logic;
		pcwrite : out std_logic;
		pcsource : out std_logic;
		irwrite : out std_logic;
		oeirj :out std_logic;
		oeiri :out std_logic;
		regwrite : out std_logic;		
		memread : out std_logic;
		memwrite : out std_logic;
		regtomem :out std_logic;	
		aluop : out std_logic;
		alusrc : out std_logic;
		writemem :out std_logic;
		readmem :out std_logic;
		memtoreg : out std_logic;
		oealuout :out std_logic;
		readmem :out std_logic;
		oedatain :out std_logic;
	);

end entity;

architecture UControl_v1_arch of UControl_v1 is

	type State_Type is (fetch,input,output,lw,sw,add,completion,jump,branch,branch2,branch3,branch4,branch5,branch6,sub,mult,addi);

	signal State : State_Type := fetch;

begin
	process (clk)
	begin
	
	end process;
end architecture;

