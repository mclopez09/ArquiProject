entity par_detector is
	generic (bits: positive);
	port (
		input: in bit_vector(bits-1 downto 0);
		output: out bit
		);
end par_detector;

architecture behavior of par_detector is
	begin process (input)
	variable temp: bit;
	begin
		temp := '0';
		for i in input'range loop
			temp := temp XOR input (i);
		end loop;
		output <= temp;
	end process;
end behavior;	
		