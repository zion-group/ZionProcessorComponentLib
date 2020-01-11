///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Macro name   : ZionProcessorComponentLib_PcSetChannelItf
// Author       : Wenheng Ma
// Date         : 2019-10-14
// Version      : 2.0
// Parameter    : 
//   RV64       -indicate the instruction is 32 bits or 64 bits,if RV64 = 1 means the instruction is 64 bits. 
// Description  :
//   This interface is used to choose PC.Include en and tgtPc two singals,to indicate whether choose the set PC or not.  
// Modification History:
//    Date    |   Author   |   Version   |   Change Description
//======================================================================================================================
// 2019-11-08 | Wenheng Ma |     1.0     |   Original Version
// 2019-11-09 |  Yudi Gao  |     2.0     |   add testbench
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// `ifndef Disable_ZionProcessorComponentLib_PcSetChannelItf
// `ifdef ZionProcessorComponentLib_PcSetChannelItf
//   //`__DefErr__(ZionProcessorComponentLib_PcSetChannelItf)
//   $error("****");
// `else
//   `define ZionProcessorComponentLib_PcSetChannelItf
//   `endif 

interface ZionProcessorComponentLib_PcSetChannelItf
#(RV64 = 0);

  logic en;
  logic [32*(1+RV64)-1:0] tgtPc;

  localparam ALL_DATA_WIDTH = $bits(en) + $bits(tgtPc);
  function automatic logic[ALL_DATA_WIDTH-1:0] GetItfDat;
    return {en,tgtPc};
  endfunction : GetItfDat
  function automatic void SetItfDat(logic [ALL_DATA_WIDTH-1:0] iDat);
    {en,tgtPc} = iDat;
  endfunction : SetItfDat
  
  modport in (input  en, tgtPc);
  modport out(output en, tgtPc);

endinterface : ZionProcessorComponentLib_PcSetChannelItf
//`endif

