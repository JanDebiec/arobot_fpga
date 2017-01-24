----------------------------------------------------------------------
--! @file doxy_styleguide.vhd 
--! @brief  
--!
--!
--! @author 
--! @date 
--! @version  
--! 
--! note 
--! @todo 
--! 
--! @test 
--! @bug  
--!
----------------------------------------------------------------------
--! @page style_guide Style-guide 
--! | item | meaning  |       example |
--! |:------:|:--------:|:-------------:|
--! | name | @ref style_name |  |
--! | prefix | @ref style_prefix |  |
--! | postfix | @ref style_postfix |  |
--!
--!
--! @page style_name Style-guide names\n
--! \t name os signals:\n
--! [Unit with driver for signal_] Type_Name [postfix]\n
--! Unit with driver for signal_ : if signal driven from external instance\n
--! syntax: uNameOfUnit\n
--! u: as identifier of external unit\n
--! NameOfUnit: name in CamelCase\n
--! \n
--! Type: defined in prefix @ref style_prefix\n
--! \n
--! Name: SignalNameInCamelCase\n
--! \n
--! Postfix: see the table: @ref style_postfix\n
--! \n
--! | example | meaning  |       example |
--! |:------:|:--------:|:-------------:|
--! | slv16_BufferCounter | local signal (Nty-Arch),\n std_logic_vector(15 downto 0)\n name = BufferCounter   |  |
--! | uCtr_sl_Enable | local signal, std_logic,\n driven from instance of unit Ctr |  |
--! |  |  |  |
--! |  |  |  |
--!
--!
--!
--!
--! @page style_prefix Style-guild prefix meaning
--! | prefix | meaning  |       example |
--! |:------:|:--------:|:-------------:|
--! | g_     | generic in component | g_eClkTickCount |
--! | c_     | constant | c_eClkTickCount |
--! | t_     | typedef | t_IlxGenSM |
--! | i      | input in port | isl_clk50Mhz |
--! | o      | output in port | osl_IlxVD |
--! | sl     | standard_logic | sl_TimerTick |
--! | slvN   | standard_logic_vector ( N-1 downto 0) | slv32_ScanTimeCounter |
--! | sm     | state machine |  |
--! | un32   | unsigned 32 bits | un32_ScanTimeCounter |
--! |  |  |  |
--!
--!
--!
--!
--! @page style_postfix Style-guild postfix meaning
--! | postfix | meaning    |       example |
--! |:-------:|:----------:|:-------------:|
--! |     _n  | active low |  |
--! |      _r | registered |  |
--! |      _d | delayed 1 clock |  |
--! |     _d2 | delayed 2 clocks |  |
--! |      _m | monoshot   |  |
--! |  |  |  |
--! |  |  |  |
--! |  |  |  |
--! |  |  |  |
--! |  |  |  |
--! |  |  |  |
