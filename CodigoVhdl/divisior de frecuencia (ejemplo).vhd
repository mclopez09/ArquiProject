library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;

entity rom_mif is
port(
	clk,reset: in std_logic;
	address: in integer range 0 to 15;
	clkout: inout std_logic;
	data_out: out std_logic_vector(7 downto 0)
	);
end entity;

architecture rom_mif_arc of rom_mif is
signal reg_address: integer range 0 to 15;
signal clk_sig:std_logic;
type memoria is array (0 to 15) of std_logic_vector(7 downto 0);
--signal rom : memoria;
--attribute ram_init_file: string;
--attribute ram_init_file of rom: signal is "rom_contents.mif";
constant rom : memoria:=(
	2 		 => "10101010",
	3 		 => "11001100",
	others => "00000000"
);
begin
--clock divider section
	p1:process(clk,reset)
	variable cnt:integer;
	begin
		if(reset='0') then
			clk_sig<='0';
			cnt:=0;
		elsif rising_edge(clk) then
			if(cnt=50000000)then
				clk_sig<= not(clk_sig);
				cnt:=0;
			else
				cnt:= cnt + 1;
			end if;
		end if;
	end process;
clkout<= clk_sig;
	process (clkout) is
	begin
		if (rising_edge(clk)) then
			reg_address <= address;
		end if;
	end process;
	data_out <= rom(reg_address);
end architecture;