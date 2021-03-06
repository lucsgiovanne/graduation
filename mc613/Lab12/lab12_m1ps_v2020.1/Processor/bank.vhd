LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY Processor;
USE Processor.Processor_pack.reg;

ENTITY bank IS
	GENERIC (
		WORDSIZE : NATURAL := 32 -- Tamanho da palavra de dados
	);
	PORT (
		WR_EN : IN STD_LOGIC; -- Permissao de escrita (ativo em nivel alto)
		RD_EN : IN STD_LOGIC; -- Permissao de leitura (ativo em nivel alto)
		clear : IN STD_LOGIC; -- Limpar todos os registradores (ativo em nivel alto)
		clock : IN STD_LOGIC; -- Clock
		WR_ADDR : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- Registrador para escrita
		RD_ADDR1 : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- Registrador para leitura 1
		RD_ADDR2 : IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- Registrador para leitura 2
		DATA_IN : IN STD_LOGIC_VECTOR (WORDSIZE-1 DOWNTO 0); -- Entrada de dados
		DATA_OUT1 : OUT STD_LOGIC_VECTOR (WORDSIZE-1 DOWNTO 0); -- Saida de dados 1
		DATA_OUT2 : OUT STD_LOGIC_VECTOR (WORDSIZE-1 DOWNTO 0) -- Saida de dados 2
	);
END ENTITY;

ARCHITECTURE Behavior OF bank IS

	COMPONENT reg IS
		GENERIC (
			WORDSIZE	: NATURAL := 32
		);
		PORT (
			clock,
			load,
			clear	: IN	STD_LOGIC;
			datain	: IN	STD_LOGIC_VECTOR(WORDSIZE-1 DOWNTO 0);
			dataout : OUT	STD_LOGIC_VECTOR(WORDSIZE-1 DOWNTO 0)
		);
	END COMPONENT;

	component dec5_to_32 is
		port(en: in std_logic;
			 w: in std_logic_vector(4 downto 0);
			 y: out std_logic_vector(31 downto 0));
	end component;

	component zbuffer is
		generic (N : integer := 4);
		port (X: in std_logic_vector(N-1 downto 0);
			E: in std_logic;
			F: out std_logic_vector(N-1 downto 0));
	end component ;
	  
	signal memory: std_logic_vector(1023 downto 0);
	signal selection_rdA, selection_rdB, selection_wr: std_logic_vector(31 downto 0);

BEGIN

	r0: reg generic map(WORDSIZE=>32) port map(clock, '0', '1', DATA_IN, memory(31 downto 0)); 
	g1: for i in 1 to 31 generate
		regs: reg generic map(WORDSIZE=>32) port map(clock, selection_wr(i), clear, DATA_IN, memory(i*32+31 downto i*32)); 
	end generate;

	dec_rdA: dec5_to_32 port map(RD_EN, RD_ADDR1, selection_rdA);
	dec_rdB: dec5_to_32 port map(RD_EN, RD_ADDR2, selection_rdB);
	dec_wr: dec5_to_32 port map(WR_EN, WR_ADDR, selection_wr);

	g2: for i in 0 to 31 generate
		buffersA: zbuffer generic map(N=>32) port map(memory(i*32+31 downto i*32), selection_rdA(i), DATA_OUT1);
		buffersB: zbuffer generic map(N=>32) port map(memory(i*32+31 downto i*32), selection_rdB(i), DATA_OUT2);
  	end generate;


END ARCHITECTURE;