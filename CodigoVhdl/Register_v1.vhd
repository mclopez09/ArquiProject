----------------------------------------------------------------------------------------------------------------------
-- Actividad : Register File Proyecto
-- Autores : German Andres Caycedo , David Hernandez, Maria Camila Lopez, Alejandro Meza
-- Fecha : 20/10/2018
--
-- archivo : Register_v1.vhd
----------------------------------------------------------------------------------------------------------------------
-- Descripción : Vamos a hacer el Register File del proyecto
----------------------------------------------------------------------------------------------------------------------
-- cambios :
----------------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity Register_v1 is
generic (Nreg: positive := 4 ; Mreg: positive := 8);


port(
	clk: std_logic;
	regWrite: std_logic;
	regMem: std_logic;
	rd: in std_logic_vector(Nreg-1 downto 0);
	rs: in std_logic_vector(Nreg-1 downto 0);
	rt: in std_logic_vector(Nreg-1 downto 0);
	Register_bus: inout std_logic_vector(Mreg-1 downto 0);
	Register_alu: out std_logic_vector(Mreg-1 downto 0);
	Register_mux: out std_logic_vector(Mreg-1 downto 0)
);
end entity;

Architecture Register_arc of Register_v1 is

--Registros--

signal r0,r1,r2,r3,r4,r5,r6,r7,at,zero,ip,op,gp :std_logic_vector(M-1 downto 0);

begin 
	process(clk) is
	begin
		if rising_edge(clk) then
			if regWrite = '1' and regMem ='0' then
				case rd is
					when "0000" => r0 <= Register_bus;
					when "0001" => r1 <= Register_bus;
					when "0010" => r2 <= Register_bus;
					when "0011" => r3 <= Register_bus;
					when "0100" => r4 <= Register_bus;
					when "0101" => r5 <= Register_bus;
					when "0110" => r6 <= Register_bus;
					when "0111" => r7 <= Register_bus;
					when "1000" => zero <= "00000000";
					when "1001" => zero <= "00000000";
					when "1010" => zero <= "00000000";
					when "1011" => zero <= "00000000";
					when "1100" => zero <= "00000000";
					when "1101" => zero <= "00000000";
					when "1110" => zero <= "00000000";
					when "1111" => zero <= "00000000";

				end case;
			end if;
		end if;
	end process;

	process(Clk) is 
	begin
		case rs is
			when "0000" => Register_alu <= r0;
			when "0001" => Register_alu <= r1;
			when "0010" => Register_alu <= r2;
			when "0011" => Register_alu <= r3;
			when "0100" => Register_alu <= r4;
			when "0101" => Register_alu <= r5;
			when "0110" => Register_alu <= r6;
			when "0111" => Register_alu <= r7;
			when "1000" => zero <= "00000000";
			when "1001" => zero <= "00000000";
			when "1010" => zero <= "00000000";
			when "1011" => zero <= "00000000";
			when "1100" => zero <= "00000000";
			when "1101" => zero <= "00000000";
			when "1110" => zero <= "00000000";
			when "1111" => zero <= "00000000";
			
		end case;
	end process;

	process(Clk) is 
	begin
		case rt is
			when "0000" => Register_mux <= r0;
			when "0001" => Register_mux <= r1;
			when "0010" => Register_mux <= r2;
			when "0011" => Register_mux <= r3;
			when "0100" => Register_mux <= r4;
			when "0101" => Register_mux <= r5;
			when "0110" => Register_mux <= r6;
			when "0111" => Register_mux <= r7;
			when "1000" => zero <= "00000000";
			when "1001" => zero <= "00000000";
			when "1010" => zero <= "00000000";
			when "1011" => zero <= "00000000";
			when "1100" => zero <= "00000000";
			when "1101" => zero <= "00000000";
			when "1110" => zero <= "00000000";
			when "1111" => zero <= "00000000";

		end case;
	end process;
End Architecture;