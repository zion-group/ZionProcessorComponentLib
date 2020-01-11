///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Macro name   : ZionProcessorComponentLib_StoreDatGen
// Author       : Wenheng Ma
// Date         : 2019-10-14
// Version      : 2.0
// Parameter    : 
//   NONE
// Description  :
//   To store data.
// Modification History:
//    Date    |   Author   |   Version   |   Change Description
//======================================================================================================================
// 2019-11-08 | Wenheng Ma |     1.0     |   Original Version
// 2019-11-09 |  Yudi Gao  |     2.0     |   add testbench
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef Disable_ZionProcessorComponentLib_StoreDatGen
`ifdef ZionProcessorComponentLib_StoreDatGen
  //`__DefErr__(ZionProcessorComponentLib_StoreDatGen)
  $error("***********");
`else
  `define ZionProcessorComponentLib_StoreDatGen(UnitName,iStoreIf_MT,oWrMask_MT,oWrDat_MT)\
ZionProcessorComponentLib_StoreDatGen  #()                     \
                                UnitName(                      \
                                   .iStoreIf(iStoreIf_MT),     \
                                   .oWrMask(oWrMask_MT),       \
                                   .oWrDat(oWrDat_MT)          \
                                );
  `endif 
module ZionProcessorComponentLib_StoreDatGen
`Use_ZionProcessorComponentLib(Pcl)
( `PclLsuItf.in iStoreIf,//memEn, load, store, unsignedFlg, memWidth, storeDat, memAddr
  output logic [31:0] oWrMask,
  output logic [31:0] oWrDat  
);
  
//  localparam  intp [2:0]STORE_WIDTH = {32'd8,32'd16,32'd32};
  localparam  intp [2:0]STORE_WIDTH = {32'd32,32'd16,32'd8};
  wire [1:0] storeAddr = iStoreIf.memAddr[1:0];
  logic [2:0] storeWidthOh, storeWidthOhTmp;

  `BcBin2Oh(U_storeWidthOhGen, iStoreIf.memWidth, storeWidthOhTmp);
  assign storeWidthOh = `BcMaskM(iStoreIf.store,storeWidthOhTmp);
  `BcWriteMaskExtd(U_MaskGen,storeWidthOh,storeAddr,oWrMask,STORE_WIDTH);
  `BcWriteDatExtd(U_DatGen,storeWidthOh,storeAddr,iStoreIf.storeDat,oWrDat,STORE_WIDTH);
`Unuse_ZionProcessorComponentLib(Pcl)
endmodule
`endif