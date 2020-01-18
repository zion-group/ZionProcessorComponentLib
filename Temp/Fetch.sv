`Use_ZionBasicCircuitLib(Bc) 
`Use_ZionRiscvIsaLib(Rvi)
module Fetch
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
`Unuse_ZionBasicCircuitLib(Bc) 
`Unuse_ZionRiscvIsaLib(Rvi)
