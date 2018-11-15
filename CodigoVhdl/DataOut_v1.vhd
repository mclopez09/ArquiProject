----------------------------------------------------------------------------------------------------------------------
-- Actividad : Data Out Proyecto
-- Autores : German Andres Caycedo , David Hernandez, Maria Camila Lopez, Alejandro Meza
-- Fecha : 20/10/2018
--
-- archivo : Arquitectura_v1.vhd
----------------------------------------------------------------------------------------------------------------------
-- Descripción : Vamos a hacer el Data Out (Output) del proyecto
----------------------------------------------------------------------------------------------------------------------
-- cambios :
----------------------------------------------------------------------------------------------------------------------

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

Entity DataOut_v1 is
	generic(NdataOut: positive :=8);
	port
	(entrada: in std_logic_vector(NdataOut-1 downto 0);
	out1: out std_logic_vector(NdataOut-1 downto 0);
	out2: out std_logic_vector(NdataOut-1 downto 0);
	out3 : out std_logic_vector(NdataOut-1 downto 0);
	out4 : out std_logic_vector(NdataOut-1 downto 0)
	);
End entity;

Architecture DataOut_arc_v1 of DataOut_v1 is
signal diez: integer:=10;
signal tmp: integer;
signal tmp2:integer;
signal tmp3:integer;
signal tmp4:integer;
begin
	process(entrada)is
	begin
		tmp <=conv_integer(entrada);
		tmp2 <=tmp mod	diez;
		tmp3 <= tmp-tmp2;
		out2 <= std_logic_vector(to_unsigned(tmp2, NdataOut));
		if tmp3 > diez then
			tmp4 <= tmp/diez;	
			out1 <= std_logic_vector(to_unsigned(tmp4, NdataOut));
		end if;
	end process;
end architecture;
		