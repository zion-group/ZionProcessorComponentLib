///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Macro name   : ZionProcessorComponentLib_RfWrChannelItf
// Author       : Wenheng Ma
// Date         : 2019-10-14
// Version      : 2.0
// Parameter    : 
//   RV64       -indicate the instruction is 32 bits or 64 bits,if RV64 = 1 means the instruction is 64 bits. 
// Description  :
//   This interface is used to generate vld,rd and dat from iDat.
// Modification History:
//    Date    |   Author   |   Version   |   Change Description
//======================================================================================================================
// 2019-11-08 | Wenheng Ma |     1.0     |   Original Version
// 2019-11-09 |  Yudi Gao  |     2.0     |   add testbench
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// `ifndef Disable_ZionProcessorComponentLib_RfWrChannelItf
// `ifdef ZionProcessorComponentLib_RfWrChannelItf
//   //`__DefErr__(ZionProcessorComponentLib_RfWrChannelItf)
//   $error("*****");
// `else
//   `define ZionProcessorComponentLib_RfWrChannelItf
//   `endif 

interface ZionProcessorComponentLib_RfWrChannelItf
#(RV64 = 0);

  logic                   vld;
  logic [            4:0] rd ;
  logic [32*(1+RV64)-1:0] dat;

  localparam ALL_DATA_WIDTH = $bits(vld) + $bits(rd) + $bits(dat);
  function automatic logic[ALL_DATA_WIDTH-1:0] GetItfDat;
    return {vld,rd,dat};
  endfunction : GetItfDat
  function automatic void SetItfDat(logic [ALL_DATA_WIDTH-1:0] iDat);
    {vld,rd,dat} = iDat;
  endfunction : SetItfDat

  modport in (input  vld, rd, dat);
  modport out(output vld, rd, dat);

endinterface : ZionProcessorComponentLib_RfWrChannelItf
//`endif