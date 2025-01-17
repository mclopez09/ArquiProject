----------------------------------------------------------------------------------------------------------------------
-- Actividad : Rom_v1 Proyecto
-- Autores : German Andres Caycedo , David Hernandez, Maria Camila Lopez, Alejandro Meza
-- Fecha : 27/10/2018
--
-- archivo : Rom_v1.vhd
----------------------------------------------------------------------------------------------------------------------
-- Descripción : Vamos a hacer la Rom del proyecto
----------------------------------------------------------------------------------------------------------------------
-- cambios :
----------------------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
--entity rom

entity Rom_v1 is
generic (Nrom: positive := 20 ; Mrom: positive := 8);
port(
	clk: std_logic;
	address: in std_logic_vector(Mrom-1 downto 0);
	data_out: out std_logic_vector(Nrom-1 downto 0)
);
end entity;

architecture Rom_v1_arc of Rom_v1 is
signal reg_address: std_logic_vector(Mrom-1 downto 0);
type mem is array (0 to 255) of std_logic_vector(Nrom-1 downto 0);
signal rom : mem;
attribute ram_init_file: string;
attribute ram_init_file of rom: signal is "rom_contents.mif";
begin
--registrar direccion
	process (clk) is
	begin
		if(rising_edge(clk)) then
			reg_address <=  address;
		end if;
	end process;
	data_out <= rom(to_integer(unsigned(reg_address)));
end architecture;