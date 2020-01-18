`Use_ZionBasicCircuitLib(Bc) 
`Use_ZionRiscvIsaLib(Rvi)
module StoreDatGen
`Use_ZionProcessorComponentLib(Pcl)
( ZionProcessorComponentLib_LsuItf.in iStoreIf,
  output logic [31:0] oWrMask,
  output logic [31:0] oWrDat  
);
  
  localparam  intp [2:0]STORE_WIDTH = {32'd32,32'd16,32'd8};
  wire [1:0] storeAddr = iStoreIf.memAddr[1:0];
  logic [2:0] storeWidthOh, storeWidthOhTmp;

  `BcBin2Oh(U_storeWidthOhGen, iStoreIf.memWidth, storeWidthOhTmp);
  assign storeWidthOh = `BcMaskM(iStoreIf.store,storeWidthOhTmp);
  `BcWriteMaskExtd(U_MaskGen,storeWidthOh,storeAddr,oWrMask,STORE_WIDTH);
  `BcWriteDatExtd(U_DatGen,storeWidthOh,storeAddr,iStoreIf.storeDat,oWrDat,STORE_WIDTH);
`Unuse_ZionProcessorComponentLib(Pcl)
endmodule
`Unuse_ZionBasicCircuitLib(Bc) 
`Unuse_ZionRiscvIsaLib(Rvi)
