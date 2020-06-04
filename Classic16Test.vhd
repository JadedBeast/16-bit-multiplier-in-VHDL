
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

ENTITY Classic16Test IS
END Classic16Test;
 
ARCHITECTURE behavior OF Classic16Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ClassicMult16    PORT(
         A16 : IN  std_logic_vector(15 downto 0);
         B16 : IN  std_logic_vector(15 downto 0);
         prod16 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A16 : std_logic_vector(15 downto 0) := (others => '0');
   signal B16 : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal prod16 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
	signal clk :std_logic:= '0';
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ClassicMult16  PORT MAP (
          A16 => A16,
          B16 => B16,
          prod16 => prod16
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		A16<="1111111111111111";
		B16<="1111000011110000";

      wait for clk_period*10;
		A16<="1111111111111111";
		B16<="1111111111111111";
		
		wait for clk_period*10;
		A16<="1111111111111111";
		B16<="0000000000000011";

      wait;
   end process;

END;
