///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Macro name   : ZionProcessorComponentLib_WriteBack
// Author       : Wenheng Ma
// Date         : 2019-10-14
// Version      : 2.0
// Parameter    : 
//   NONE
// Description  :
//   Write back.
// Modification History:
//    Date    |   Author   |   Version   |   Change Description
//======================================================================================================================
// 2019-11-08 | Wenheng Ma |     1.0     |   Original Version
// 2019-11-09 |  Yudi Gao  |     2.0     |   add testbench
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// `ifndef Disable_ZionProcessorComponentLib_WriteBack
// `ifdef ZionProcessorComponentLib_WriteBack
//   //`__DefErr__(ZionProcessorComponentLib_WriteBack)
//   $error("**********");
// `else
//   `define ZionProcessorComponentLib_WriteBack(UnitName,clk_MT,rst_MT,iLoadIf_MT,iMemDat_MT,iRd_MT,iIntRslt_MT,oWbBus_MT,oFwdBus_MT,RV64,TWO_PIPE,RST_CFG)\
// ZionProcessorComponentLib_WriteBack #(.RV64(RV64),                   \
//                                    .TWO_PIPE(TWO_PIPE),              \
//                                    .RST_CFG(RST_CFG))                \
//                                 UnitName(                            \
//                                    .clk(clk_MT),                     \
//                                    .rst(rst_MT),                     \
//                                    .iLoadIf(iLoadIf_MT),             \
//                                    .iMemDat(iMemDat_MT),             \
//                                    .iRd(iRd_MT),                     \
//                                    .iIntRslt(iIntRslt_MT),           \
//                                    .oWbBus(oWbBus_MT),               \
//                                    .oFwdBus(oFwdBus_MT)              \
//                                 );
//   `endif 
module ZionProcessorComponentLib_WriteBack
`Use_ZionProcessorComponentLib(Pcl)
#(RV64     = 0,
  TWO_PIPE = 1,
  RST_CFG  = 4,
localparam 
  DATA_WIDTH = 32*(1+RV64)
)(
  input                         clk,rst   ,
  `PclLsuItf.in                 iLoadIf   ,
  input  logic [DATA_WIDTH-1:0] iMemDat   ,
  input  logic [           4:0] iRd       ,
  input  logic [DATA_WIDTH-1:0] iIntRslt  ,
  `PclRfWrChannelItf.out        oWbBus    ,
  `PclRfWrChannelItf.out        oFwdBus    

);

  logic [4:0] rd;
  logic       loadEn;
  logic [DATA_WIDTH-1:0] exDatTmp, exDat, loadRslt;
  assign exDatTmp = iIntRslt | DATA_WIDTH'({iLoadIf.memAddr[1:0],iLoadIf.memWidth,iLoadIf.unsignedFlg});
  `gen_if(TWO_PIPE == 0) begin
    assign rd        = iRd         ;
    assign loadEn    = iLoadIf.load;
    assign exDat     = exDatTmp    ;
  end `gen_else begin
    logic [$bits(rd)+$bits(loadEn)+$bits(exDatTmp)-1:0] allDat, allDat_r;
    `BcEnRcDff(U_PipeReg,clk,rst,1'b1,allDat,allDat_r,RST_CFG);//iDatHazard
    assign allDat = {iRd,iLoadIf.load,exDatTmp};
    assign {rd,loadEn,exDat} = allDat_r;
  end
  //localparam intp [2:0] LOAD_WIDTH = {32'd8,32'd16,32'd32};
  localparam intp [2:0] LOAD_WIDTH = {32'd32,32'd16,32'd8};
  wire       loadSigned = ~exDat[0] ;
  wire [1:0] loadWidth  = exDat[2:1];
  wire [1:0] loadAddr   = exDat[4:3];
  logic [2:0] loadWidthOh, loadWidthOhTmp;
  `BcBin2Oh(U_LoadWidthOhGen, loadWidth, loadWidthOhTmp);
  assign loadWidthOh = (loadEn)? loadWidthOhTmp : '0;
  //`BcDatRead(U_LoadUnit,~iLoadIf.unsignedFlg,loadWidthOh,loadAddr,iMemDat,loadRslt,LOAD_WIDTH,0);//TODO: add unsigned
    `BcDatRead(U_LoadUnit,loadSigned,loadWidthOh,loadAddr,iMemDat,loadRslt,LOAD_WIDTH,0);//TODO: add unsign    ed
    // UnitName,iSignedRd_MT,iEn_MT,iAddr_MT,iDat_MT,oDat_MT,MULTI_DATA_WIDTH_MT={0},ADDR_TYPE_MT=0
  assign oWbBus.vld = |rd;
  assign oWbBus.rd  = rd;
  assign oWbBus.dat = (loadEn)? loadRslt : exDat;

  assign oFwdBus.vld = |rd;
  assign oFwdBus.rd  = rd;
  assign oFwdBus.dat = (loadEn)? loadRslt : exDat;

`Unuse_ZionProcessorComponentLib(Pcl)
endmodule
//`endif