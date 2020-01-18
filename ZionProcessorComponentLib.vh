////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright(C) Zion Team. Open source License: MIT.
// ALL RIGHT RESERVED
// Filename : ZionProcessorComponentLib.vh
// Author   : Zion Team
// Date     : 2019-06-20
// Version  : 1.0
// Description :
//     This is a header file of basic circuit element library. 
// Modification History:
//   Date   |   Author    |   Version   |   Change Description
//======================================================================================================================
// 19-07-24 |  Zion Team  |     1.0     |   Original Version
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`define ZionProcessorComponentLib_MacroDef(ImportName, DefName)           \
  `ifdef ImportName``DefName                                              \
    Macro Define Error: ImportName``DefName has already been defined!!    \
  `else                                                                   \
    `define ImportName``DefName `ZionProcessorComponentLib_``DefName      \
  `endif
`define ZionProcessorComponentLib_PackageDef(ImportName, DefName)         \
  `ifdef ImportName``DefName                                              \
    Macro Define Error: ImportName``DefName has already been defined!!    \
  `else                                                                   \
    `define ImportName``DefName ZionProcessorComponentLib_``DefName       \
  `endif
`define ZionProcessorComponentLib_InterfaceDef(ImportName, DefName)       \
  `ifdef ImportName``DefName                                              \
    Macro Define Error: ImportName``DefName has already been defined!!    \
  `else                                                                   \
    `define ImportName``DefName ZionProcessorComponentLib_``DefName       \
  `endif
`define ZionProcessorComponentLib_ModuleDef(ImportName, DefName)          \
  `ifdef ImportName``DefName                                              \
    Macro Define Error: ImportName``DefName has already been defined!!    \
  `else                                                                   \
    `define ImportName``DefName `ZionProcessorComponentLib_``DefName      \
  `endif
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
`define Use_ZionProcessorComponentLib(ImportName)                      \
  `ZionProcessorComponentLib_ModuleDef(ImportName, PcGen)              \
  `ZionProcessorComponentLib_ModuleDef(ImportName, ForwardMux)         \
  `ZionProcessorComponentLib_ModuleDef(ImportName, RegFile)            \
  `ZionProcessorComponentLib_ModuleDef(ImportName, TurtleDecoder)
         

    
`define Unuse_ZionProcessorComponentLib(ImportName) \
  `undef ImportName``ForwardMux                     \
  `undef ImportName``PcGen                          \
  `undef ImportName``RegFile                        \
  `undef ImportName``TurtleDecoder
 

            
  
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







