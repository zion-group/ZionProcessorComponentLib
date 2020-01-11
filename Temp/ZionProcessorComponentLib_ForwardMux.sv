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
  //`__DefErr__(ZionProcessorComponentLib_ForwardMux)
  $error("****");
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
  //localparam DATA_WIDTH = $bits(iFwdBusIf.dat);
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