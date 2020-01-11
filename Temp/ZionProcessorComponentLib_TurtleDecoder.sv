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
  //`__DefErr__(ZionProcessorComponentLib_TurtleDecoder)
  $error("******");
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
