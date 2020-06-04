----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:13:20 06/04/2020 
-- Design Name: 
-- Module Name:    ClassicMult16 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ClassicMult16 is
	Port ( A16 : in  STD_LOGIC_VECTOR (15 downto 0);
           B16 : in  STD_LOGIC_VECTOR (15 downto 0);
           prod16 : out  STD_LOGIC_VECTOR (31 downto 0));
end ClassicMult16;

architecture Behavioral of ClassicMult16 is
component ClassicMultiplier is
	Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           P: out  STD_LOGIC_VECTOR (15 downto 0));
end component;	
signal mLow , mHigh , nLow, nHigh: STD_LOGIC_VECTOR (7 downto 0);
signal mLow_nLow ,mHigh_nLow ,mLow_nHigh,mHigh_nHigh  :STD_LOGIC_VECTOR (15 downto 0);
signal mHigh_nHigh2: STD_LOGIC_VECTOR (31 downto 0);

signal first,second,third,fourth,answer : integer;		  
begin
mLow <= A16(7 downto 0);
mHigh <= A16(15 downto 8);
nLow <= B16(7 downto 0);
nHigh <= B16(15 downto 8);
----8 bit Multiplier 
m00 :ClassicMultiplier port map(mLow,nLow,mLow_nLow);
m01 :ClassicMultiplier port map (mHigh,nLow,mHigh_nLow);
m02 :ClassicMultiplier port map (mLow,nHigh,mLow_nHigh);
m03 :ClassicMultiplier port map (mHigh,nHigh,mHigh_nHigh);

mHigh_nHigh2(15 downto 0) <= mHigh_nHigh(15 downto 0);


first <= to_integer(unsigned(mLow_nLow));
second <= to_integer(unsigned(mHigh_nLow));
third <= to_integer(unsigned(mLow_nHigh));

fourth <= to_integer(shift_left(unsigned(mHigh_nHigh2),16));

answer <= first+(second+third)*256+fourth;

prod16 <=std_logic_vector(to_signed(answer,32));
end Behavioral;

