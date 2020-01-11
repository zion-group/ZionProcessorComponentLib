///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Macro name       : ZionProcessorComponentLib_RegFile
// Author           : Wenheng Ma
// Date             : 2019-10-14
// Version          : 2.0
// Parameter        : 
//   REG_NUM        - Number of registers,is default as 32            
//   RD_PORT_NUM    - Number of read ports,is defaulr as 2
//   FWD_PORT_NUM   - Number of forward ports,in case of non-pipeline processor is defaulr as 0
//   RST_CFG        -Type of reset,meaning that whether asynchronous or synchronous reset and reset active low or high 
// Description      :
//   The definition of regfile
// Modification History:
//    Date    |   Author   |   Version   |   Change Description
//======================================================================================================================
// 2019-11-08 | Wenheng Ma |     1.0     |   Original Version
// 2019-11-09 |  Yudi Gao  |     2.0     |   add testbench
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// `ifndef Disable_ZionProcessorComponentLib_RegFile
// `ifdef ZionProcessorComponentLib_RegFile
//   //`__DefErr__(ZionProcessorComponentLib_RegFile)
//   $error("*********");
// `else
//   `define ZionProcessorComponentLib_RegFile(UnitName,clk_MT,rst_MT,iRdPort_MT,iWrPort_MT,iFwdPort_MT)  \
// ZionProcessorComponentLib_RegFile  #(.REG_NUM(32),                 \
//                                      .RD_PORT_NUM(2),         \
//                                      .FWD_PORT_NUM(1),       \
//                                      .RST_CFG(4))                 \
//                                 UnitName(                               \
//                                    .clk(clk_MT),                        \
//                                    .rst(rst_MT),                        \
//                                    .iRdPort(iRdPort_MT),                \
//                                    .iWrPort(iWrPort_MT),                \
//                                    .iFwdPort(iFwdPort_MT)               \
//                                 )
//   `endif 
module ZionProcessorComponentLib_RegFile
#(REG_NUM      = "-",
  RD_PORT_NUM  = "-",
  FWD_PORT_NUM = "-",
  RST_CFG      = "-"
)(
  input clk,rst,
  ZionProcessorComponentLib_RfRdChannelItf.regfile iRdPort[RD_PORT_NUM],
  ZionProcessorComponentLib_RfWrChannelItf.in      iWrPort,
  ZionProcessorComponentLib_RfWrChannelItf.in      iFwdPort[FWD_PORT_NUM]
);
  logic [REG_NUM-1:0][$bits(iWrPort.dat)-1:0] regFile_r;
  logic [REG_NUM-1:0]wrEnOh;
  `BcOnehotDefBinM(wrEnOh,iWrPort.rd);
  for(genvar i=1;i<REG_NUM;i++)begin : RfRegGen
    `BcEnRcDff(U_RfReg, clk,rst,wrEnOh[i],iWrPort.dat,regFile_r[i],'0,RST_CFG);
  end
  assign regFile_r[0] = '0;
  logic [RD_PORT_NUM-1:0][$bits(iRdPort[0].dat)-1:0] rfRdDat;
  logic [RD_PORT_NUM-1:0]                            fwdHazard;
  for(genvar i=0;i<RD_PORT_NUM;i++)begin : ReadDatGen
    assign rfRdDat[i] = regFile_r[iRdPort[i].rs];
    //`ZionProcessorComponentLib_ForwardMux(U_FwdMux, iFwdPort, iRdPort[i].rs, rfRdDat[i], fwdHazard[i],iRdPort[i].dat);
  ZionProcessorComponentLib_ForwardMux #(.FWD_PORT_NUM(FWD_PORT_NUM),
                                         .INPUT_RS_DATA_WIDTH(32),
                                         .OUTPUT_RS_DATA_WIDTH(32))
                                U_FwdMux(.iFwdBusIf(iFwdPort),
                                         .iRs(iRdPort[i].rs),
                                         .iRsDat(rfRdDat[i]),
                                         .oDatHazard(fwdHazard[i]),
                                         .oFnlRsDat(iRdPort[i].dat)
                                        );
  end
endmodule : ZionProcessorComponentLib_RegFile
//`endif