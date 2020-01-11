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
//   //`__DefErr__(ZionProcessorComponentLib_Fetch)
//   $error("******");
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
  `PclPcSetChannelItf.in iBjBus,
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
