//`include "/home/train/gaoyudi/MacroCircuitLib/src/ZionBceLib/ZionBasicCircuitLib.sv"
`Use_ZionBasicCircuitLib(Bc) 
`Use_ZionRiscvIsaLib(Rvi)

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
//   `__DefErr__(ZionProcessorComponentLib_PcSetChannelItf)
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
//   `__DefErr__(ZionProcessorComponentLib_RfRdChannelItf)
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
//   `__DefErr__(ZionProcessorComponentLib_RfWrChannelItf)
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
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Macro name             : ZionProcessorComponentLib_ForwardMux
// Author                 : Wenheng Ma
// Date                   : 2019-10-14
// Version                : 2.0
// Parameter              : 
//   FWD_PORT_NUM         - Number of forward ports,in case of non-pipeline processor is defaulr as 0
//   INPUT_RS_DATA_WIDTH  - The width of input RS data
//   OUTPUT_RS_DATA_WIDTH - The width of output RS data
// Description            :
//   Forwardmux
// Modification History:
//    Date    |   Author   |   Version   |   Change Description
//======================================================================================================================
// 2019-11-08 | Wenheng Ma |     1.0     |   Original Version
// 2019-11-09 |  Yudi Gao  |     2.0     |   add testbench
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef Disable_ZionProcessorComponentLib_ForwardMux
`ifdef ZionProcessorComponentLib_ForwardMux
  `__DefErr__(ZionProcessorComponentLib_ForwardMux)
`else
  `define ZionProcessorComponentLib_ForwardMux(UnitName,iFwdBusIf_MT,iRs_MT,iRsDat_MT,oDatHazard_MT,oFnlRsDat_MT)  \
ZionProcessorComponentLib_ForwardMux  #( .FWD_PORT_NUM(1),                           \
                                         .INPUT_RS_DATA_WIDTH($bits(iRsDat_MT)),        \
                                         .OUTPUT_RS_DATA_WIDTH($bits(oFnlRsDat_MT)))    \
                                UnitName(                                            \
                                   .iFwdBusIf(iFwdBusIf_MT),                         \
                                   .iRs(iRs_MT),                                     \
                                   .iRsDat(iRsDat_MT),                               \
                                   .oDatHazard(oDatHazard_MT),                       \
                                   .oFnlRsDat(oFnlRsDat_MT)                          \
                                );
  `endif 
module ZionProcessorComponentLib_ForwardMux
#(FWD_PORT_NUM = "_",
  INPUT_RS_DATA_WIDTH  = "_", //$bits(iRsDat)   //
  OUTPUT_RS_DATA_WIDTH = "_"  //$bits(oFnlRsDat)//
)( 
  ZionProcessorComponentLib_RfWrChannelItf.in iFwdBusIf[FWD_PORT_NUM],
  input  [4:0] iRs,
  input  [INPUT_RS_DATA_WIDTH -1:0] iRsDat,
  output                            oDatHazard,
  output [OUTPUT_RS_DATA_WIDTH-1:0] oFnlRsDat
);
  localparam DATA_WIDTH = $bits(iFwdBusIf[0].dat);
  wire rsVld = |iRs;
  logic [FWD_PORT_NUM:0] datVld, datSelBitmap, datSelOh;
  logic [FWD_PORT_NUM:0][OUTPUT_RS_DATA_WIDTH-1:0] allDat;

    for(genvar i=0;i<FWD_PORT_NUM;i++) begin
      assign datVld[i]       = iFwdBusIf[i].vld;
      assign datSelBitmap[i] = (iFwdBusIf[i].rd==iRs) & rsVld;
      assign allDat[i]       = iFwdBusIf[i].dat;
    end
    assign datVld[FWD_PORT_NUM] = rsVld;
    assign datSelBitmap[FWD_PORT_NUM] = rsVld;
    assign allDat[FWD_PORT_NUM]       = iRsDat;

  `BcOnehotDefBitmap(datSelOh, datSelBitmap);
  if(FWD_PORT_NUM==0)
  assign oDatHazard = |(datSelOh & ~datVld);
  else
  assign oDatHazard = |(datSelOh[FWD_PORT_NUM-1:0] & ~datVld[FWD_PORT_NUM-1:0]);
  `BcMuxOnehot(U_MuxOnehot, datSelOh, allDat, oFnlRsDat);

  // TODO: parameter check. width check
endmodule : ZionProcessorComponentLib_ForwardMux
`endif
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Macro name             : ZionProcessorComponentLib_PcGen
// Author                 : Wenheng Ma
// Date                   : 2019-10-14
// Version                : 2.0
// Parameter              : 
//   PORT_NUM             -bits of iSetEn              
//   INPUT_SET_PC_WIDTH   -bits of input set PC 
//   STEP_WIDTH           -bits of step between current PC and next PC      
//   OUTPUT_PC_WIDTH      -bits of current output PC 
//   OUTPUT_NEXT_PC_WIDTH -bits of next output PC 
//   START_ADDR           -bits of start address
//   RST_CFG              -type of reset,meaning that whether asynchronous or synchronous reset and reset active low or high 
// Description            :
//   To generate the value of PC
// Modification History:
//    Date    |   Author   |   Version   |   Change Description
//======================================================================================================================
// 2019-11-08 | Wenheng Ma |     1.0     |   Original Version
// 2019-11-09 |  Yudi Gao  |     2.0     |   add testbench
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef Disable_ZionProcessorComponentLib_PcGen
`ifdef ZionProcessorComponentLib_PcGen
  `__DefErr__(ZionProcessorComponentLib_PcGen)
`else
  `define ZionProcessorComponentLib_PcGen(UnitName,clk_MT,rst_MT,iStall_MT,iSetEn_MT,iSetPc_MT,iNxtPcStep_MT,oPc_MT,oNxtPc_MT,START_ADDR,RST_CFG)\
ZionProcessorComponentLib_PcGen  #(.PORT_NUM($bits(iSetEn)),            \
                                   .INPUT_SET_PC_WIDTH($bits(iSetPc)),  \
                                   .STEP_WIDTH($bits(iNxtPcStep)),      \
                                   .OUTPUT_PC_WIDTH($bits(oPc)),        \
                                   .OUTPUT_NEXT_PC_WIDTH($bits(oNxtPc)),\
                                   .START_ADDR(START_ADDR),             \
                                   .RST_CFG(4))                         \
                                UnitName(                            \
                                   .clk(clk_MT),                     \
                                   .rst(rst_MT),                     \
                                   .iStall(iStall_MT),               \
                                   .iSetEn(iSetEn_MT),               \
                                   .iSetPc(iSetPc_MT),               \
                                   .iNxtPcStep(iNxtPcStep_MT),       \
                                   .oPc(oPc_MT),                     \
                                   .oNxtPc(oNxtPc_MT)                \
                                );
  `endif 
module ZionProcessorComponentLib_PcGen
#(PORT_NUM             = "_", //$bits(iSetEn)    //
  INPUT_SET_PC_WIDTH   = "_", //$bits(iSetPc)    //
  STEP_WIDTH           = "_", //$bits(iNxtPcStep)//
  OUTPUT_PC_WIDTH      = "_", //$bits(oPc)       //
  OUTPUT_NEXT_PC_WIDTH = "_", //$bits(oNxtPc)    //
  START_ADDR           = "_",
  RST_CFG              = 4,
localparam
  SET_PC_WIDTH         = INPUT_SET_PC_WIDTH/PORT_NUM
)(
  input  logic                                          clk,rst,
  input  logic                                          iStall,
  input  logic               [PORT_NUM            -1:0] iSetEn,
  input  logic [PORT_NUM-1:0][SET_PC_WIDTH        -1:0] iSetPc,
  input  logic               [STEP_WIDTH          -1:0] iNxtPcStep,
  output logic               [OUTPUT_PC_WIDTH     -1:0] oPc,
  output logic               [OUTPUT_NEXT_PC_WIDTH-1:0] oNxtPc
);
  // Reset flag. When rRstFlg is 1'b0, the core is reset. Otherwise, the core is running.
  // En port of the DFF is ~rRstFlg, so that the clock is enabled only in the first cycle after reset.
  logic rRstFlg;                        //active low
  `BcEnRcDff  (U_EnRcDff_rRstFlg,
                 clk,rst,~rRstFlg,1'b1, // input
                 rRstFlg,               // output
                 1'b0,RST_CFG           // parameter 
              );
  // Get next PC 
  logic [SET_PC_WIDTH-1:0] PrioPc;
  logic [PORT_NUM    -1:0] setEnOh;
  `BcOnehotDefBitmap(setEnOh, iSetEn);//form low to high to find 1st
  `BcMuxOnehot(U_MuxOnehot, setEnOh, iSetPc, PrioPc);

  wire [SET_PC_WIDTH-1:0] nxtStepPc = oPc + `BcMaskM(rRstFlg,iNxtPcStep);
  wire stepPcVld = (setEnOh=='0) | ~rRstFlg;
  assign oNxtPc = (stepPcVld)? nxtStepPc : PrioPc;
  // PC register
  `BcEnRcDff  (U_EnRcDff_oPc,
                 clk,rst,~iStall,oNxtPc, // input
                 oPc,                    // output
                 START_ADDR,RST_CFG      // parameter 
              );

  // TODO: Parameter check. Width check
endmodule : ZionProcessorComponentLib_PcGen
`endif
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Macro name   : ZionProcessorComponentLib_Fetch
// Author       : Wenheng Ma
// Date         : 2019-10-14
// Version      : 2.0
// Parameter    : 
//   START_ADDR -bits of start address
//   RST_CFG    -type of reset,meaning that whether asynchronous or synchronous reset and reset active low or high 
//   TWO_PIPE   -
// Description  :
//   To fetch instructions
// Modification History:
//    Date    |   Author   |   Version   |   Change Description
//======================================================================================================================
// 2019-11-08 | Wenheng Ma |     1.0     |   Original Version
// 2019-11-09 |  Yudi Gao  |     2.0     |   add testbench
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// `ifndef Disable_ZionProcessorComponentLib_Fetch
// `ifdef ZionProcessorComponentLib_Fetch
//   `__DefErr__(ZionProcessorComponentLib_Fetch)
// `else
//   `define ZionProcessorComponentLib_Fetch(UnitName,clk_MT,rst_MT,iLoadEn_MT,iBjBus_MT,oFetchEn_MT,oPc_MT,oNxtPc_MT,START_ADDR)\
// ZionProcessorComponentLib_Fetch  #(.START_ADDR(START_ADDR),          \
//                                    .RST_CFG(4),                      \
//                                    .TWO_PIPE(1))                     \
//                                 UnitName(                            \
//                                    .clk(clk_MT),                     \
//                                    .rst(rst_MT),                     \
//                                    .iLoadEn(iLoadEn_MT),             \
//                                    .iBjBus(iBjBus_MT),               \
//                                    .oFetchEn(oFetchEn_MT),           \
//                                    .oPc(oPc_MT),                     \
//                                    .oNxtPc(oNxtPc_MT)                \
//                                 );
//   `endif 
module ZionProcessorComponentLib_Fetch
`Use_ZionProcessorComponentLib(Pcl)
#(START_ADDR = "_" ,
  RST_CFG    = "_" , 
  TWO_PIPE   = "_" 
)(
  input clk,rst,
  input iLoadEn,
  ZionProcessorComponentLib_PcSetChannelItf.in iBjBus,
  output        oFetchEn,
  output [31:0] oPc,
  output [31:0] oNxtPc
);

  logic fetchStall;
  `gen_if(TWO_PIPE==0) begin
    logic loadStall, loadStall_r;
    assign loadStall = iLoadEn & (~loadStall_r);
    `BcEnRcDff  (U_oFeStall_r,
                clk,rst,1'b1,loadStall, // input
                loadStall_r,            // output
                '0,RST_CFG              // parameter 
              ); 
    assign fetchStall = loadStall   ;
  end `gen_else begin
    assign fetchStall = 1'b0;
  end

  wire [ 2:0] step       = 3'b100      ;
  wire        pcSetEn    = iBjBus.en   ;
  wire [31:0] pcSetTgt   = iBjBus.tgtPc;
  assign      oFetchEn   = ~fetchStall ;

  logic       iSetEn;//[ 3:0]
  logic      [31:0] iSetPc;
  logic      [ 2:0] iNxtPcStep;
  `PclPcGen (U_PcGen, 
              clk,rst,fetchStall,pcSetEn,pcSetTgt,step,
              oPc,oNxtPc,
              START_ADDR, RST_CFG 
            );
`Unuse_ZionProcessorComponentLib(Pcl)
endmodule
//`endif

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
//   `__DefErr__(ZionProcessorComponentLib_LsuItf)
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

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Macro name             : ZionProcessorComponentLib_TurtleDecoder
// Author                 : Wenheng Ma
// Date                   : 2019-10-14
// Version                : 2.0
// Parameter              : 
//   FWD_PORT_NUM         - Number of forward ports,in case of non-pipeline processor is defaulr as 0
//   INPUT_RS_DATA_WIDTH  - The width of input RS data
//   OUTPUT_RS_DATA_WIDTH - The width of output RS data
// Description            :
//   Decode
// Modification History:
//    Date    |   Author   |   Version   |   Change Description
//======================================================================================================================
// 2019-11-08 | Wenheng Ma |     1.0     |   Original Version
// 2019-11-09 |  Yudi Gao  |     2.0     |   add testbench
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 `ifndef Disable_ZionProcessorComponentLib_TurtleDecoder
 `ifdef ZionProcessorComponentLib_TurtleDecoder
   `__DefErr__(ZionProcessorComponentLib_TurtleDecoder)
 `else
  `define ZionProcessorComponentLib_TurtleDecoder(UnitName,iPc_MT,iIns_MT,bRfRdIf_MT,oRd_MT,oIntDeRsltIf_MT,oLsuDeRsltIf_MT)  \
ZionProcessorComponentLib_TurtleDecoder #()                                    \
                                UnitName(                                      \
                                   .iPc(iPc_MT),                               \
                                   .iIns(iIns_MT),                             \
                                   .bRfRdIf(bRfRdIf_MT),                       \
                                   .oRd(oRd_MT),                               \
                                   .oIntDeRsltIf(oIntDeRsltIf_MT),             \
                                   .oLsuDeRsltIf(oLsuDeRsltIf_MT)              \
                                   )
  `endif 
module ZionProcessorComponentLib_TurtleDecoder
( 
  input [31:0] iPc,
  input [31:0] iIns,
  ZionProcessorComponentLib_RfRdChannelItf.read bRfRdIf[2],
  output logic [4:0] oRd,
  `RviIntInsExItf.IntBjMemDeOut oIntDeRsltIf, 
  ZionProcessorComponentLib_LsuItf.OutNoAddr oLsuDeRsltIf
);

  `RviRvimazDecodeItf RvDeIf(iIns);

  wire rs1Vld = RvDeIf.rs1Enable;
  wire rs2Vld = RvDeIf.rs2Enable;
  wire rdVld  = RvDeIf.rdEnable ;
  wire [4:0] rs1 = RvDeIf.rs1;
  wire [4:0] rs2 = RvDeIf.rs2;
  assign     oRd = rdVld ? RvDeIf.rd : '0;
  // TODO: add functions for rs selection.
  always_comb begin
    bRfRdIf[0].rs   = `BcMaskM(rs1Vld,rs1);
    bRfRdIf[1].rs   = `BcMaskM(rs2Vld,rs2);
    unique case(1'b1)
      rs1Vld          : oIntDeRsltIf.s1 = bRfRdIf[0].dat;
      RvDeIf.Jal()    : oIntDeRsltIf.s1 = iPc;
      RvDeIf.insUtype : oIntDeRsltIf.s1 = RvDeIf.immUtype;
      default         : oIntDeRsltIf.s1 = '0;
    endcase
    unique case(1'b1)
      rs2Vld & ~RvDeIf.insStype : oIntDeRsltIf.s2 = bRfRdIf[1].dat;
      RvDeIf.insItype & (~RvDeIf.Jalr()) :
        oIntDeRsltIf.s2 =  RvDeIf.SltUnsigned() ? RvDeIf.UimmItype : RvDeIf.immItype;
      RvDeIf.insStype   : oIntDeRsltIf.s2 = RvDeIf.immStype;
      RvDeIf.csrUimmFlg : oIntDeRsltIf.s2 = RvDeIf.uimm;
      RvDeIf.JumpIns() | RvDeIf.Auipc() :
        oIntDeRsltIf.s2 = iPc;
      RvDeIf.SftIns()& RvDeIf.intImmInsFlg : oIntDeRsltIf.s2 = RvDeIf.shamt;
      default           : oIntDeRsltIf.s2 = '0;
    endcase
    unique case(1'b1)
      RvDeIf.Jalr()   : oIntDeRsltIf.offset = RvDeIf.immItype;
      RvDeIf.insJtype : oIntDeRsltIf.offset = RvDeIf.immJtype;
      RvDeIf.insBtype : oIntDeRsltIf.offset = RvDeIf.immBtype;
      default         : oIntDeRsltIf.offset = '0;
    endcase
    oIntDeRsltIf.pc         = iPc;
    oIntDeRsltIf.flags[0]    = RvDeIf.BranchUnsigned() | RvDeIf.SltUnsigned();
    oIntDeRsltIf.addSubIns  = RvDeIf.AddSubIns() | RvDeIf.Auipc() | RvDeIf.Lui();
    oIntDeRsltIf.addEn      = RvDeIf.AddIns() | RvDeIf.AddWIns() | RvDeIf.Auipc() | RvDeIf.LoadStoreIns() | RvDeIf.JumpIns() | RvDeIf.Lui(); //TODO: add AddAddWIns()
    oIntDeRsltIf.subEn      = RvDeIf.Sub() | RvDeIf.Subw() | RvDeIf.BranchSizeCmp() | RvDeIf.SltIns();//TODO: add SubSubWIns()
    oIntDeRsltIf.andEn      = RvDeIf.AndIns();
    oIntDeRsltIf.orEn       = RvDeIf.OrIns();
    oIntDeRsltIf.xorEn      = RvDeIf.XorIns();
    oIntDeRsltIf.sftLeft    = RvDeIf.SllIns() | RvDeIf.SllWIns(); //TODO: add SllSllWIns()
    oIntDeRsltIf.sftRight   = RvDeIf.SrIns()  | RvDeIf.SrWIns(); //TODO: add SrSrWIns()
    oIntDeRsltIf.sftA       = RvDeIf.SraIns() | RvDeIf.SraWIns(); //TODO: add SraSraWIns()
    oIntDeRsltIf.sltEn      = RvDeIf.SltIns();
    oIntDeRsltIf.bjIns      = RvDeIf.BranchJumpIns();
    oIntDeRsltIf.branch     = RvDeIf.BranchIns();
    oIntDeRsltIf.beq        = RvDeIf.Beq();
    oIntDeRsltIf.bne        = RvDeIf.Bne();
    oIntDeRsltIf.blt        = RvDeIf.Blt() | RvDeIf.Bltu();
    oIntDeRsltIf.bge        = RvDeIf.Bge() | RvDeIf.Bgeu();
    oIntDeRsltIf.jump       = RvDeIf.JumpIns();
    oIntDeRsltIf.memEn      = RvDeIf.LoadStoreIns();
    oIntDeRsltIf.memwrEn    = RvDeIf.StoreIns(); 
    oIntDeRsltIf.linkOffset = 2'b10 & ({2{RvDeIf.JumpIns()}});
  end

  always_comb begin
    oLsuDeRsltIf.memEn       = RvDeIf.LoadStoreIns();
    oLsuDeRsltIf.load        = RvDeIf.LoadIns();
    oLsuDeRsltIf.store       = RvDeIf.StoreIns();
    oLsuDeRsltIf.unsignedFlg = RvDeIf.LoadUnsigned();
    oLsuDeRsltIf.memWidth    = RvDeIf.LoadStoreWidth();
    oLsuDeRsltIf.storeDat    = (oLsuDeRsltIf.store)? bRfRdIf[1].dat : '0;
  end
endmodule : ZionProcessorComponentLib_TurtleDecoder
`endif

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
`ifndef Disable_ZionProcessorComponentLib_RegFile
`ifdef ZionProcessorComponentLib_RegFile
  `__DefErr__(ZionProcessorComponentLib_RegFile)
`else
  `define ZionProcessorComponentLib_RegFile(UnitName,clk_MT,rst_MT,iRdPort_MT,iWrPort_MT,iFwdPort_MT)  \
ZionProcessorComponentLib_RegFile  #(.REG_NUM(32),                      \
                                     .RD_PORT_NUM(2),                   \
                                     .FWD_PORT_NUM(1),                  \
                                     .RST_CFG(4))                       \
                                UnitName(                               \
                                   .clk(clk_MT),                        \
                                   .rst(rst_MT),                        \
                                   .iRdPort(iRdPort_MT),                \
                                   .iWrPort(iWrPort_MT),                \
                                   .iFwdPort(iFwdPort_MT)               \
                                )
  `endif 
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
`endif
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
  `__DefErr__(ZionProcessorComponentLib_StoreDatGen)
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
`endif
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
`ifndef Disable_ZionProcessorComponentLib_WriteBack
`ifdef ZionProcessorComponentLib_WriteBack
  `__DefErr__(ZionProcessorComponentLib_WriteBack)
`else
  `define ZionProcessorComponentLib_WriteBack(UnitName,clk_MT,rst_MT,iLoadIf_MT,iMemDat_MT,iRd_MT,iIntRslt_MT,oWbBus_MT,oFwdBus_MT,RV64,TWO_PIPE,RST_CFG)\
ZionProcessorComponentLib_WriteBack #(.RV64(RV64),                   \
                                   .TWO_PIPE(TWO_PIPE),              \
                                   .RST_CFG(RST_CFG))                \
                                UnitName(                            \
                                   .clk(clk_MT),                     \
                                   .rst(rst_MT),                     \
                                   .iLoadIf(iLoadIf_MT),             \
                                   .iMemDat(iMemDat_MT),             \
                                   .iRd(iRd_MT),                     \
                                   .iIntRslt(iIntRslt_MT),           \
                                   .oWbBus(oWbBus_MT),               \
                                   .oFwdBus(oFwdBus_MT)              \
                                );
  `endif 
module ZionProcessorComponentLib_WriteBack
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
`endif

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
`Unuse_ZionBasicCircuitLib(Bc) 
`Unuse_ZionRiscvIsaLib(Rvi)
