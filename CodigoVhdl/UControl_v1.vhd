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
	generic(Nu: positive:=4);
	port
	(
		clk : in	std_logic;
		reset : in	std_logic;
		input : in std_logic_vector(Nu-1 downto 0);
		pcwritecond : out std_logic;
		pcwrite : out std_logic;
		pcsource : out std_logic;
		irwrite : out std_logic;
		oeirj :out std_logic;
		oeiri :out std_logic;
		regwrite : out std_logic;		
		regtomem :out std_logic;	
		aluop : out std_logic_vector (Nu-1 downto 0);
		alusrc : out std_logic;
		memwrite :out std_logic;
		memread :out std_logic;
		oealuout :out std_logic;
		oedatain :out std_logic;
		regram :out std_logic;
		MBSIG : out std_logic
	);

end entity;

architecture UControl_v1_arch of UControl_v1 is

	type State_Type is (fetch,fetch2,writereg,fetch3,waitoutput,espera,espera2,iput,oput,completioni,completionr,completionbranch,lw,sw,add,jump,branchbeq,branchbnq,branchblt,branchbgt,branchbgte,branchbgtz,sub,mult,addi);

	signal state : State_Type := fetch;

begin
	process (clk,reset)
	begin
		if reset = '1' then
			state <= fetch;
		elsif (rising_edge(clk)) then
			case state is
				when fetch => 
					state<= fetch2;
				when fetch2 => 
				   state <= fetch3;
				when fetch3 =>
					if input = "0000" then
						state <=add;
					elsif input = "0001" then
						state <= addi;					
					elsif input = "0010" then
						state <= sub;					
					elsif input = "0011" then
						state <= mult;					
					elsif input = "0100" then
						state <= branchbeq;					
					elsif input = "0101" then
						state <= branchbnq;					
					elsif input = "0110" then
						state <= branchblt;				
					elsif input = "0111" then
						state <= branchbgt;					
					elsif input = "1000" then
						state <= branchbgte;					
					elsif input = "1001" then
						state <= branchbgtz;					
					elsif input = "1010" then
						state <= jump;
					elsif input = "1101" then
						state <= lw;
					elsif input = "1110" then
						state <= sw;
					elsif input = "1011" then
						state <= iput;
					elsif input = "1100" then
						state <= oput;
					else
						state <= fetch;
					end if;
				when add =>
					state <= completionr;
				when completionr =>
					state <= fetch;
				when addi =>
					state <= completioni;
				when completioni =>
					state <= fetch;
				when completionbranch =>
					state <= fetch;
				when sub =>
					state <= completionr;
				when mult =>
					state <= completionr;
				when branchbeq =>
					state <= completionbranch;
				when branchbnq =>
					state <= completionbranch;
				when branchblt =>
					state <= completionbranch;
				when branchbgt =>
					state <= completionbranch;
				when branchbgte =>
					state <= completionbranch;
				when branchbgtz =>
					state <= completionbranch;
				when jump =>
					state <= fetch;
				when lw =>
					state <= espera;
				when espera =>
					state <= writereg;
				when sw =>
					state <= espera2;
				when espera2 =>
					state <= fetch;
				when writereg =>
					state <= fetch;					
				when iput=>
					state <= fetch;
				when oput=>
					state <= waitoutput;
				when waitoutput=>
					state <= fetch;
			end case;
		end if;
	end process;
	
	
	process(state,input)
	begin
			case state is
				when fetch=>
					pcwritecond <= '0';
					pcwrite <= '1';
					pcsource <= '1';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '0';		
					regtomem <= '0';	
					aluop <= "0000";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
				when fetch2=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '0';		
					regtomem <= '0';	
					aluop <= "0000";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
				when fetch3=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '1';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '0';		
					regtomem <= '0';	
					aluop <= "0000";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
				when add=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '1';		
					regtomem <= '0';	
					aluop <= "0000";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
				when completionr=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '1';		
					regtomem <= '0';	
					aluop <= "0000";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
				when addi=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '1';		
					regtomem <= '0';	
					aluop <= "0001";
					alusrc <= '1';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
				when completioni=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '1';		
					regtomem <= '0';	
					aluop <= "0000";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '1';
					oedatain <= '0';
					regram <= '0';
				when sub=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '1';		
					regtomem <= '0';	
					aluop <= "0010";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
				when mult=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '1';		
					regtomem <= '0';	
					aluop <= "0011";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
				when branchbeq=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '1';		
					regtomem <= '0';	
					aluop <= "0100";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';			
				when branchbnq=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '1';		
					regtomem <= '0';	
					aluop <= "0101";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
				when branchblt=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '1';		
					regtomem <= '0';	
					aluop <= "0110";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
				when branchbgt=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '1';		
					regtomem <= '0';	
					aluop <= "0111";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
				when branchbgte=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '1';		
					regtomem <= '0';	
					aluop <= "1000";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
				when branchbgtz=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '1';		
					regtomem <= '0';	
					aluop <= "1001";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
				when completionbranch=>
					pcwritecond <= '1';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '0';		
					regtomem <= '0';	
					aluop <= "0000";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '1';
					oedatain <= '0';
					regram <= '0';			
				when jump=>
					pcwritecond <= '0';
					pcwrite <= '1';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '1';
					oeiri <= '0';
					regwrite <= '0';		
					regtomem <= '0';	
					aluop <= "1010";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
				when lw=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '1';
					regwrite <= '0';		
					regtomem <= '0';	
					aluop <= "1101";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '1';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
					MBSIG <= '1';
				when espera=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '0';		
					regtomem <= '0';	
					aluop <= "1101";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
					MBSIG <= '0';	
				when writereg=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '1';		
					regtomem <= '0';	
					aluop <= "1101";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
					MBSIG <= '1';			
				when sw=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '1';
					regwrite <= '0';		
					regtomem <= '1';	
					aluop <= "1110";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
					MBSIG <= '1';
				when espera2=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '0';		
					regtomem <= '0';	
					aluop <= "1110";
					alusrc <= '0';
					memwrite <= '1';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
					MBSIG <= '1';

				when iput=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '1';
					regwrite <= '0';		
					regtomem <= '0';	
					aluop <= "1011";
					alusrc <= '0';
					memwrite <= '1';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '1';
					regram <= '0';
					MBSIG <= '0';
				when oput=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '1';
					regwrite <= '0';		
					regtomem <= '0';	
					aluop <= "1100";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '1';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
				when waitoutput=>
					pcwritecond <= '0';
					pcwrite <= '0';
					pcsource <= '0';
					irwrite <= '0';
					oeirj <= '0';
					oeiri <= '0';
					regwrite <= '0';		
					regtomem <= '0';	
					aluop <= "1100";
					alusrc <= '0';
					memwrite <= '0';
					memread <= '0';
					oealuout <= '0';
					oedatain <= '0';
					regram <= '0';
			end case;
	end process;						
end architecture;