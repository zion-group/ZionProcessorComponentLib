`Use_ZionBasicCircuitLib(Bc) 
`Use_ZionRiscvIsaLib(Rvi)
module WriteBack
`Use_ZionProcessorComponentLib(Pcl)
#(RV64     = 0,
  TWO_PIPE = 1,
  RST_CFG  = 4,
localparam 
  DATA_WIDTH = 32*(1+RV64)
)(
  input                                         clk,rst   ,
  ZionProcessorComponentLib_LsuItf.in           iLoadIf   ,
  input  logic [DATA_WIDTH-1:0]                 iMemDat   ,
  input  logic [           4:0]                 iRd       ,
  input  logic [DATA_WIDTH-1:0]                 iIntRslt  ,
  ZionProcessorComponentLib_RfWrChannelItf.out  oWbBus    ,
  ZionProcessorComponentLib_RfWrChannelItf.out  oFwdBus    

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
    `BcEnRcDff(U_PipeReg,clk,rst,1'b1,allDat,allDat_r,RST_CFG);
    assign allDat = {iRd,iLoadIf.load,exDatTmp};
    assign {rd,loadEn,exDat} = allDat_r;
  end
  localparam intp [2:0] LOAD_WIDTH = {32'd32,32'd16,32'd8};
  wire       loadSigned = ~exDat[0] ;
  wire [1:0] loadWidth  = exDat[2:1];
  wire [1:0] loadAddr   = exDat[4:3];
  logic [2:0] loadWidthOh, loadWidthOhTmp;
  `BcBin2Oh(U_LoadWidthOhGen, loadWidth, loadWidthOhTmp);
  assign loadWidthOh = (loadEn)? loadWidthOhTmp : '0;
  `BcDatRead(U_LoadUnit,loadSigned,loadWidthOh,loadAddr,iMemDat,loadRslt,LOAD_WIDTH,0);//TODO: add unsign
    
  assign oWbBus.vld = |rd;
  assign oWbBus.rd  = rd;
  assign oWbBus.dat = (loadEn)? loadRslt : exDat;

  assign oFwdBus.vld = |rd;
  assign oFwdBus.rd  = rd;
  assign oFwdBus.dat = (loadEn)? loadRslt : exDat;

`Unuse_ZionProcessorComponentLib(Pcl)
endmodule
`Unuse_ZionBasicCircuitLib(Bc) 
`Unuse_ZionRiscvIsaLib(Rvi)

