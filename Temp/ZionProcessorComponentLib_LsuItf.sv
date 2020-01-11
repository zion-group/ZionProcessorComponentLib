///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Macro name   : ZionProcessorComponentLib_LsuItf
// Author       : Wenheng Ma
// Date         : 2019-10-14
// Version      : 2.0
// Parameter    : 
//   RV64       -indicate the instruction is 32 bits or 64 bits,if RV64 = 1 means the instruction is 64 bits. 
// Description  :
//   This interface is used to load or store unsigned or signed data.
// Modification History:
//    Date    |   Author   |   Version   |   Change Description
//======================================================================================================================
// 2019-11-08 | Wenheng Ma |     1.0     |   Original Version
// 2019-11-09 |  Yudi Gao  |     2.0     |   add testbench
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// `ifndef Disable_ZionProcessorComponentLib_LsuItf
// `ifdef ZionProcessorComponentLib_LsuItf
//   //`__DefErr__(ZionProcessorComponentLib_LsuItf)
//   $error("******");
// `else
//   `define ZionProcessorComponentLib_LsuItf
//   `endif 

interface ZionProcessorComponentLib_LsuItf
 #(RV64=0);
   localparam DATA_WIDTH = 32*(1+RV64);
   logic memEn, load, store, unsignedFlg;
   logic [1:0] memWidth;
   logic [DATA_WIDTH-1:0] storeDat, memAddr;
 
   modport in (input  memEn, load, store, unsignedFlg, memWidth, storeDat, memAddr);
   modport out(output memEn, load, store, unsignedFlg, memWidth, storeDat, memAddr);
   modport OutNoAddr(output memEn, load, store, unsignedFlg, memWidth, storeDat);
   modport OutAddr(output memAddr);
 
 endinterface : ZionProcessorComponentLib_LsuItf
//`endif
