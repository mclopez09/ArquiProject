----------------------------------------------------------------------------------------------------------------------
-- Actividad : Arquitectura Proyecto
-- Autores : German Andres Caycedo , David Hernandez, Maria Camila Lopez, Alejandro Meza
-- Fecha : 20/10/2018
--
-- archivo : Arquitectura_v1.vhd
----------------------------------------------------------------------------------------------------------------------
-- Descripción : Vamos a hacer el main del proyecto
----------------------------------------------------------------------------------------------------------------------
-- cambios :
----------------------------------------------------------------------------------------------------------------------




Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity Arquitectura is

	generic 
	(
		DATA_WIDTH : natural := 20;
		ADDR_WIDTH : natural := 8;
		OPCODE_WIDTH : natural := 4
	);

	port ( entrada : in std_logic_vector(7 down to 0);
			enter : in std_logic;
			reset : in std_logic

			salida1 : out std_logic_vector(7 down to 0);
			salida2 : out std_logic_vector(7 down to 0);
			salida3 : out std_logic_vector(7 down to 0);
			salida4 : out std_logic_vector(7 down to 0)


	);

End Entity;


Architecture structural of Arquitectura is
	
	Component Alu 

	generic (NAlu: positive := 8 ; MAlu: positive := 4);

	port(
		OPCODE : in std_logic_vector(MAlu-1 downto 0);
		A,B,C : in std_logic_vector(NAlu-1 downto 0);
		RESUL: out std_logic_vector(NAlu-1 downto 0);
		Branch: out std_logic
	);

	End Component;


	Component MuxAlu

	generic (Nalux: positive := 8);
	port
	(	registerFile : in std_logic_vector(Nalux-1 downto 0);
		irA : in std_logic_vector(Nalux-1 downto 0);
		clk : in std_logic;
		AluSource: in std_logic;
		MuxOut : out std_logic_vector(Nalux-1 downto 0)
	);

	End Component;

	Component MuxPC
	generic (Nmuxpc: positive := 8);
	port
	(	Jump : in std_logic_vector(Nmuxpc-1 downto 0);
		Adder : in std_logic_vector(Nmuxpc-1 downto 0);
		clk : in std_logic;
		PcSource: in std_logic;
		MuxOut : out std_logic_vector(Nmuxpc-1 downto 0)
	);

	End Component;

	Component Pc
	generic (Npc: positive := 8 ; Mpc: positive := 16);
	port
	(	MuxPc : in std_logic_vector(Npc-1 downto 0);
		PcOut : out std_logic_vector(Npc-1 downto 0);
		clk : in std_logic;
		PcSig: in std_logic
	);

	End Component;

	Component Ram
	generic (Nram: positive := 20 ; Mram: positive := 8);
	port(
		clk, WriteMem: in std_logic;
		data_in: in std_logic_vector(Nram-1 downto 0);
		wr_address, rd_address: in std_logic_vector(Mram-1 downto 0);
		data_out: out std_logic_vector(Nram-1 downto 0)
	);

	End Component;

	Component Rom
	generic (Nrom: positive := 20 ; Mrom: positive := 8);
	port
	(	clk: std_logic;
		address: in std_logic_vector(Mrom-1 downto 0);
		data_out: out std_logic_vector(Nrom-1 downto 0)
	);

	End Component;

	Component RegisterFile
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
	End Component;

	Component AluOut

	generic (NAluOut: positive := 8);
	port(
		dataAlu : in std_logic_vector(NAluOut-1 downto 0);
		RESULOUT: out std_logic_vector(NAluOut-1 downto 0);	
		oeAluOut: in std_logic
	);

	End Component;

	Component Adder
	generic (Nadder: positive := 8);
	port
	(	Pc: in std_logic_vector(Nadder-1 downto 0);
		OUTADDER: out std_logic_vector(Nadder-1 downto 0)
	);

	End Component;

	Component IR 
	generic (Nir: positive := 20 ; Mir: positive := 4 ; Pir: positive := 8);

	port
	(	instruccion: in std_logic_vector(Nir-1 		downto 0);
		oeir,irwrite,oeirj: inout std_logic;
		clk : in std_logic;
		opcode : out std_logic_vector(Mir-1 downto 0);
		outrd,outrs,outrt : out std_logic_vector(Mir-1 downto 0):="0000"
		outjump, constante, constante_dir : out std_logic_vector(Pir-1 downto 0);
	);


	signal OPCODEALU : std_logic_vector(3 downto 0);
	signal AALU : std_logic_vector(7 downto 0);
	signal BALU : std_logic_vector(7 downto 0);
	signal CALU : std_logic_vector(7 downto 0);
	signal ALURESUL : std_logic_vector(7 downto 0);
	signal JUMPIR : std_logic_vector(7 downto 0);
	signal ADDEROUT : std_logic_vector( 7 downto 0);
	signal PCSOURCEMUX : std_logic;
	signal PCIN : std_logic_vector(7 downto 0);
	signal OUTPC : std_logic_vector(7 downto 0);
	signal SIGPC : std_logic; 
	signal ROMOUT : std_logic_vector(19 downto 0);
	signal OPCODEALU : std_logic_vector(3 downto 0);
	signal IROE : std_logic;
	signal WRITEIR : std_logic;
	signal IRJOE : std_logic;
	signal IROPCODE : std_logic_vector(19 downto 0);
	signal RDIR : std_logic_vector(3 downto 0);
	signal RSIR : std_logic_vector(3 downto 0);
	signal RTIR : std_logic_vector(3 downto 0);
	signal JUMPIR : std_logic_vector(7 downto 0);
	signal CONSTANTEIR : std_logic_vector(7 downto 0);
	signal CONSTANTEDIR : std_logic_vector(7 downto 0);
	signal WRITEREG : std_logic;
	signal MEMREG : std_logic;
	signal OUTREGISTER : std_logic_vector(7 downto 0);
	signal ALUREGISTER : std_logic_vector(7 downto 0);
	signal MUXREGISTER : std_logic_vector(7 downto 0);
	signal SOURCEALU : std_logic;
	signal OUTMUX : std_logic_vector(7 downto 0);
	signal ALUOUTOE : std_logic;
	signal ALUOUTSAL : std_logic_vector(7 downto 0);





begin	
	

	AluC1: Alu_v1 generic map (NAlu=>ADDR_WIDTH,MAlu=>OPCODE_WIDTH)
	port map (OPCODE => OPCODEALU, A => ALUREGISTER, B => OUTMUX, RESUL => ALURESUL);

	MuxPc1: MuxPc_v1 generic map (Nmuxpc => ADDR_WIDTH)
	port map (Jump => JUMPIR, Adder => ADDEROUT, PcSource => PCSOURCEMUX, MUXOUT => PCIN);

	PC1: PC_v1 generic map ( Npc => ADDR_WIDTH )
	port map (MuxPc => PCIN, PCOut => OUTPC, PCSig => SIGPC);

	ADDERC1: Adder_v1 generic map (Nadder => ADDR_WITH)
	port map (Pc => OUTPC, OUTADDER => ADDEROUT );

	ROMC1: Rom_v1 generic map (Nrom => DATA_WIDTH)
	port map (addres => OUTPC, data_out => ROMOUT);

	IRC1: IR_v1 generic map (Nir => DATA_WIDTH, Mir => OPCODE_WIDTH, Pir => ADDR_WIDTH)
	port map (instruccion => ROMOUT, oeir => IROE, irwrite => WRITEIR, oeirj => IRJOE, opcodeir => IROPCODE, outrd => RDIR, outrs => RSIR, outrt => RTIR, outjump => JUMPIR, constante => CONSTANTEIR, constante_dir => CONSTANTEDIR );

	REGC1 Register_v1 generic map (Nreg => OPCODE_WIDTH, Mreg => ADDR_WIDTH)
	port map (regWrite => WRITEREG, regMem => MEMREG, rd => RDIR, rs => RSIR, rt => RTIR, Register_bus => OUTREGISTER, Register_alu => ALUREGISTER, Register_mux => MUXREGISTER);

	MuxAluC1: MuxAlu_v1 generic map (Nalux => ADDR_WIDTH)
	port map (registerFile => ALUREGISTER, irA => CONSTANTEIR, AluSource => SOURCEALU, MuxOut => OUTMUX);

	AluC1: Alu_v1 generic map (NAlu=>ADDR_WIDTH,MAlu=>OPCODE_WIDTH)
	port map (OPCODE => OPCODEALU, A => ALUREGISTER, B => OUTMUX, RESUL => ALURESUL);

	AluOutC1: Ali_Out_v1 generic map (NAluOut => ADDR_WIDTH)
	port map (dataAlu => ALURESUL,RESULOUT => ALUOUTSAL, oeAluOut => ALUOUTOE);

	RAMC1: Ram_v1 generic map (Mram => ADDR_WIDTH)
	port map (data_in => entrada , wr_address => CONSTANTEDIR, rd_address => CONSTANTEDIR, data_out => )








End Architecture;