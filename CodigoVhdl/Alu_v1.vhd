----------------------------------------------------------------------------------------------------------------------
-- Actividad : Alu Proyecto
-- Autores : German Andres Caycedo , David Hernandez, Maria Camila Lopez, Alejandro Meza
-- Fecha : 20/10/2018
--
-- archivo : Alu_v1.vhd
----------------------------------------------------------------------------------------------------------------------
-- Descripción : Vamos a hacer la alu del proyecto
----------------------------------------------------------------------------------------------------------------------
-- cambios :
----------------------------------------------------------------------------------------------------------------------

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity Alu_v1 is
	generic (N: positive := 16 ; M: positive := 4);

	port(
		OPCODE : in std_logic_vector(M-1 downto 0);
		A,B,C : in std_logic_vector(N-1 downto 0);
		RESUL: out std_logic_vector(N-1 downto 0);
		Branch: out std_logic
	);
End Entity;

Architecture Alu_v1_arc of Alu_v1 is
	signal temporary :std_logic_vector(31 downto 0);
Begin

process(A,B,OPCODE)
	Begin
	Case OPCODE is

	when "0000" =>
		RESUL <= std_logic_vector((unsigned(A) + unsigned(B)));
		Branch <= '0';

	when "0010" =>
		RESUL <= std_logic_vector(unsigned(A) - unsigned(B));
		Branch <= '0';

	when "0011" =>
		temporary <= std_logic_vector(unsigned(A) *	unsigned(B));
		RESUL <= temporary(15 downto 0);
		Branch <= '0';

	when "0001" =>
		RESUL <= std_logic_vector(unsigned(A) + unsigned(C));
		Branch <= '0';

	when "0100" =>
		if(unsigned(A) - unsigned(B) = 0) then
			Branch <= '1';
		else
			Branch <= '0';
		end if;

	when "0101" =>
		if(unsigned(A) - unsigned(B) = 0) then
			Branch <= '0';
		else
			Branch <= '1';
		end if;

	when "0110" =>
		if(unsigned(A) < unsigned(B)) then
			Branch <= '1';
		else
			Branch <= '0';
		end if;

	when "0111" =>
		if(unsigned(A) > unsigned(B)) then
			Branch <= '1';
		else
			Branch <= '0';
		end if;

	when "1000" =>
		if(unsigned(A) >= unsigned(B)) then
			Branch <= '1';
		else
			Branch <= '0';
		end if;

	when "1001" =>
		if((unsigned(A) < unsigned(B)) OR (unsigned(A) = 0)) then
			Branch <= '1';
		else
			Branch <= '0';
		end if;


	when others => 
		RESUL <= NULL;
		Branch <= '0';
		
	End Case;
End Process;

End Architecture Alu_v1_arc;