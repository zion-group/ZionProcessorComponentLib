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
  //`__DefErr__(ZionProcessorComponentLib_PcGen)
  $error("*****");
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
  `BcOnehotDefBitmap(setEnOh, iSetEn);//form low to high to find first 1
/*  initial begin
    $display("iSetEn=%0d,setEnOh=%0d",iSetEn,setEnOh);
  end*/
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