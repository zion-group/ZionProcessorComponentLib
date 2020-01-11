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
  `ZionProcessorComponentLib_InterfaceDef(ImportName,LsuItf)           \
  `ZionProcessorComponentLib_InterfaceDef(ImportName,PcSetChannelItf)  \
  `ZionProcessorComponentLib_InterfaceDef(ImportName,RfRdChannelItf)   \
  `ZionProcessorComponentLib_InterfaceDef(ImportName,RfWrChannelItf)   \
  `ZionProcessorComponentLib_ModuleDef(ImportName, PcGen)              \
  `ZionProcessorComponentLib_ModuleDef(ImportName, Fetch)              \
  `ZionProcessorComponentLib_ModuleDef(ImportName, ForwardMux)         \
  `ZionProcessorComponentLib_ModuleDef(ImportName, RegFile)            \
  `ZionProcessorComponentLib_ModuleDef(ImportName, RegFile0)           \
  `ZionProcessorComponentLib_ModuleDef(ImportName, StoreDatGen)        \
  `ZionProcessorComponentLib_ModuleDef(ImportName, TurtleDecoder)      \
  `ZionProcessorComponentLib_ModuleDef(ImportName, WriteBack)          

    
`define Unuse_ZionProcessorComponentLib(ImportName) \
  `undef ImportName``Fetch                          \
  `undef ImportName``ForwardMux                     \
  `undef ImportName``LsuItf                         \
  `undef ImportName``PcGen                          \
  `undef ImportName``PcSetChannelItf                \
  `undef ImportName``RegFile                        \
  `undef ImportName``RegFile0                       \
  `undef ImportName``RfRdChannelItf                 \
  `undef ImportName``RfWrChannelItf                 \
  `undef ImportName``StoreDatGen                    \
  `undef ImportName``TurtleDecoder                  \
  `undef ImportName``WriteBack  

            
  
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







