----------------------------------------------------------------------------------------------------------------------
-- Actividad : Ram_v1 Proyecto
-- Autores : German Andres Caycedo , David Hernandez, Maria Camila Lopez, Alejandro Meza
-- Fecha : 27/10/2018
--
-- archivo : Ram_v1.vhd
----------------------------------------------------------------------------------------------------------------------
-- Descripción : Vamos a hacer la Ram del proyecto
----------------------------------------------------------------------------------------------------------------------
-- cambios :
----------------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--entity ram

entity Ram_v1 is
generic (N: positive);
port(
	clk, WriteMem: in std_logic;
	data_in: in std_logic_vector(N-1 downto 0);
	wr_address, rd_address: in integer range 0 to 255;
	data_out: out std_logic_vector(N-1 downto 0)
);
end entity;

architecture Ram_v1_arc of Ram_v1 is
	type memory is array (0 to 255) of std_logic_vector(7 downto 0);
	signal my_ram : memory;
	attribute ram_style: string;
	attribute ram_style of my_ram: signal is "M4K";
	attribute ram_init_file: string;
	attribute ram_init_file of my_ram: signal is "ram_contents.mif";
begin
	process(clk) is
	begin
		if(rising_edge(clk)) then
			if(WriteMem = '1') then
				my_ram(wr_address) <= data_in;
			end if;
			data_out <= my_ram(rd_address);
		end if;
	end process;
end architecture;