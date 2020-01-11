///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Macro name   : ZionProcessorComponentLib_RfRdChannelItf
// Author       : Wenheng Ma
// Date         : 2019-10-14
// Version      : 2.0
// Parameter    : 
//   RV64       -indicate the instruction is 32 bits or 64 bits,if RV64 = 1 means the instruction is 64 bits. 
// Description  :
//   This interface is used to save data into register or take data from register.
// Modification History:
//    Date    |   Author   |   Version   |   Change Description
//======================================================================================================================
// 2019-11-08 | Wenheng Ma |     1.0     |   Original Version
// 2019-11-09 |  Yudi Gao  |     2.0     |   add testbench
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// `ifndef Disable_ZionProcessorComponentLib_RfRdChannelItf
// `ifdef ZionProcessorComponentLib_RfRdChannelItf
//   //`__DefErr__(ZionProcessorComponentLib_RfRdChannelItf)
//   $error("*****");
// `else
//   `define ZionProcessorComponentLib_RfRdChannelItf
//   `endif 

interface ZionProcessorComponentLib_RfRdChannelItf
#(RV64 = 0);

  logic [            4:0] rs ;
  logic [32*(1+RV64)-1:0] dat;

  localparam ALL_DATA_WIDTH = $bits(rs) + $bits(dat);
  function automatic logic[ALL_DATA_WIDTH-1:0]  GetItfDat;
    return {rs,dat};
  endfunction : GetItfDat
  function automatic void  SetItfDat(logic [ALL_DATA_WIDTH-1:0] iDat);
    {rs,dat} = iDat;
  endfunction : SetItfDat

  modport read  (input dat, output rs );
  modport regfile(input rs , output dat);
 
endinterface : ZionProcessorComponentLib_RfRdChannelItf
//`endif