----------------------------------------------------------------------
--! @file  spi_output.vhd
--! @brief dpram with spi shift reg
--!
--!
--! @author 
--! @date 
--! @version  
--! 
--! note 
--! @todo 
--! @test 
--! @bug  
--!
----------------------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

--!
package spi_output_pkg is
    component spi_output 
    generic(
        bModelSim           : boolean := FALSE
    );
    port (
-- spi side
    isl_SpiClk       : in std_logic; --! output clock 
    isl_TxActive     : in std_logic;
    osl_miso         : out std_logic;
-- system side
    isl_SystemClock  : in STD_LOGIC ;
    isl_reset        : in std_logic;
    isl_dataValid    : in std_logic;
    islv8_MagicWord  : in std_logic_vector(7 downto 0);
    islv8_Header     : in std_logic_vector(7 downto 0);
    islv32_DataL     : in std_logic_vector(31 downto 0);
    islv32_DataR     : in std_logic_vector(31 downto 0)
    );        
    end component spi_output;
            
end package spi_output_pkg;

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
Library work;           
    use work.arobot_constant_pkg.all;
    use work.arobot_component_pkg.all;
    use work.arobot_typedef_pkg.all;
    use work.flipflop_d1_pkg.all;
    use work.monoshot_pkg.all;
    use work.mono_on_border_pkg.all;
    use work.spi_transmitter_pkg.all;
    use work.spi_output_prepare_pkg.all;

entity spi_output is
    generic(
        bModelSim           : boolean := FALSE
    );
    port (
-- spi side
    isl_SpiClk       : in std_logic; --! output clock 
    isl_TxActive     : in std_logic;
    osl_miso         : out std_logic;
-- system side
    isl_SystemClock  : in STD_LOGIC ;
    isl_reset        : in std_logic;
    isl_dataValid    : in std_logic;
    islv8_MagicWord  : in std_logic_vector(7 downto 0);
    islv8_Header     : in std_logic_vector(7 downto 0);
    islv32_DataL     : in std_logic_vector(31 downto 0);
    islv32_DataR     : in std_logic_vector(31 downto 0)
 --   islv11_OutWrAddr : in STD_LOGIC_VECTOR (10 DOWNTO 0);
--    isl_SysClkEna    : in STD_LOGIC;
--    isl_OutWrEna     : in STD_LOGIC;
--    islv8_WrData     : in STD_LOGIC_VECTOR (7 DOWNTO 0)
    );
end entity spi_output;

--!
--! @brief
--!
--! @detail 
--! 
--!
architecture RTL of spi_output is
-- signals globals
    signal sl_Reset : std_logic;

-- signals for transmitter
    signal sl_SpiClk : std_logic;
    --signal sl_TxActive : std_logic;
    signal sl_validData : std_logic;
    signal uTxPrep_slv8_Data : std_logic_vector(7 downto 0);
    signal uTx_sl_dataReqSpi : std_logic;
--    signal sl_dataReqSpiDel : std_logic;
--    signal sl_dataReqSpi2Del : std_logic;
    
--    signal sl_dataReqSys : std_logic;
    signal uTx_sl_TxReady : std_logic;
    signal uTx_sl_miso : std_logic;
    signal uM_sl_TxActive_m : std_logic;
    
    signal uTxPrep_sl_firstByteValid : std_logic;
    signal uTxPrep_sl_DataValid : std_logic;
    signal uTxPrep_sl_txActive : std_logic;
    signal sl_txActive : std_logic;
---- signals for DpRam
---- read side    
    signal sl_SystemClock : STD_LOGIC ;
    signal sl_DataReq      : std_logic;
    signal sl_InputDataValid : std_logic;
    
begin
    
    
    sl_SystemClock <= isl_SystemClock;
    sl_Reset <= isl_Reset;
    --sl_TxActive <= isl_TxActive;
    
--    uTxPrep_slv8_Data <= islv8_status;-- when (u16_RdAddrCnt(0) = '0') else
                --islv8_command;
--    sl_validData <= uTx_sl_dataReqSpi;--uM_sl_TxActive_m;-- or sl_dataReqSpi2Del;
    
-- input signals for transmitter    
    osl_miso <= uTx_sl_miso;
    sl_SpiClk <= isl_SpiClk;
    
    -- if buf not ready, then tx only status, command,
    -- first wenn buf ready tx the whole buf
--    sl_BufReady <= islv8_status(0);
    
-- delay for valid data, 2 ticks    
--U_DataReqDel : flipflop_d1 port map(sl_SpiClk, uTx_sl_dataReqSpi, '1', '0', sl_dataReqSpiDel );
--U_DataReq2Del : flipflop_d1 port map(sl_SpiClk, sl_dataReqSpiDel, '1', '0', sl_dataReqSpi2Del );


--P_RdAddrCntNext : process( uTx_sl_dataReqSpi,  uM_sl_TxActive_m)
--    variable vu16_RdAddrCnt : unsigned(15 downto 0);
--begin
--    vu16_RdAddrCnt := u16_RdAddrCnt;
--    if (uTx_sl_dataReqSpi = '1') or (uM_sl_TxActive_m = '1') then
--        vu16_RdAddrCnt := vu16_RdAddrCnt + 1;
----    else
----        if(vu16_RdAddrCnt >= 2) then
----            if(sl_BufReady = '0')then
----                vu16_RdAddrCnt := x"0000";
----            end if;
----        end if;        
--  --      vu16_RdAddrCnt := vu16_RdAddrCnt;
--    end if;
--    u16_RdAddrCntNext <= vu16_RdAddrCnt;
--end process;

--p_RdAddrCnt : process(sl_reset, sl_SpiClk)
--begin
--    IF (sl_reset = '1') THEN
--        u16_RdAddrCnt <= x"0000";
--    elsif (rising_edge(sl_SpiClk)) then
--        u16_RdAddrCnt <= u16_RdAddrCntNExt;
--    end if;
--end process;

uM : monoshot 
    --generic(
    --    bModelSim           : boolean := FALSE
    --);
    port map     (
        isl_clk        => sl_SystemClock,--: in std_logic; --! master clock 50 MHz
        isl_rst             => isl_reset,--: in std_logic; --! master reset active high
        isl_input           => isl_TxActive,--: in std_logic; --!
        osl_outputMono      => uM_sl_TxActive_m--: out std_logic --! pwm output
    );        
 
    
uTx : spi_transmitter
port map
(
--! signals on OutputCLock domain
    isl_SpiClk       => sl_SpiClk,
    isl_reset        => sl_Reset,--: in std_logic;
    isl_TxActive     => uTxPrep_sl_txActive,--: in std_logic;
    isl_FirstByteValid => uTxPrep_sl_firstByteValid,
    isl_validData    => uTxPrep_sl_DataValid,--: in std_logic;
    islv8_Data       => uTxPrep_slv8_Data,--: in std_logic_vector(7 downto 0);
    osl_dataReq      => uTx_sl_dataReqSpi,--
    osl_TxReady      => uTx_sl_TxReady,--
    osl_miso         => uTx_sl_miso--: out std_logic := 'Z'
);

uTxPrep : spi_output_prepare
port map
(
-- system side
    isl_SystemClock  => sl_SystemClock,--: in STD_LOGIC ;
    islv8_MagicWord  => islv8_MagicWord  ,--: in std_logic_vector(7 downto 0);
    islv8_Header     => islv8_Header     ,--: in std_logic_vector(7 downto 0);
    islv32_DataL     => islv32_DataL     ,--: in std_logic_vector(31 downto 0);
    islv32_DataR     => islv32_DataR     ,--: in std_logic_vector(31 downto 0);
    osl_DataReq      => sl_DataReq,--: out std_logic;
    isl_dataValid    => sl_InputDataValid,--: in std_logic;
    isl_reset        => sl_reset,--: in std_logic;

 -- spi clock
    isl_SpiClock     => sl_SpiClk,--: in std_logic;    
    isl_transferData => isl_TxActive ,--: in std_logic;
    isl_trDataReq    => uTx_sl_dataReqSpi,
    isl_trReady      => uTx_sl_TxReady,
    oslv8_outData    => uTxPrep_slv8_Data    ,--: out std_logic_vector(7 downto 0);
    osl_firstByteValid  => uTxPrep_sl_firstByteValid,--: out std_logic;
    osl_DataValid    => uTxPrep_sl_DataValid,--: out std_logic;
    osl_txActive     => uTxPrep_sl_txActive--: out std_logic;
);

end architecture RTL;
