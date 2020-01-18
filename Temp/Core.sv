//`include "/home/train/gaoyudi/MacroCircuitLib/src/ZionProcessorComponentLib/ZionProcessorComponentLibb.sv"
module Core
`Use_ZionProcessorComponentLib(Pcl_)
`Use_ZionRiscvIsaLib(Rvi_)
`Use_ZionBasicCircuitLib(Bc_)
#(START_ADDR = "_",
  RST_CFG    =  4 ,
  RV64       =  0 ,
  TWO_PIPE   =  1 
)(
  input clk,rst,
  input  logic [31:0] iInsDat,
  output logic        oFetchEn,
  output logic [31:0] oInsAddr,

  input  logic [31:0] iMemDat,
  output logic        oMemEn,
  output logic        oMemWrEn,
  output logic [11:0] oMemAddr,
  output logic [31:0] oMemWrMask,
  output logic [31:0] oMemWrDat
);

  logic [31:0] pc;
  logic [ 4:0] rd;
  logic rdVld; 
  ZionProcessorComponentLib_PcSetChannelItf bjBusIf();
  ZionProcessorComponentLib_LsuItf          lsuExIf();
  `Rvi_IntInsExItf                          intExIf();
  ZionProcessorComponentLib_RfRdChannelItf  rfRdIf[2]();
  ZionProcessorComponentLib_RfWrChannelItf  rfWrChIf();
  ZionProcessorComponentLib_RfWrChannelItf  rfWrIf();
  ZionProcessorComponentLib_RfWrChannelItf  rfFwdIf[1]();

  assign oMemEn   = lsuExIf.memEn;
  assign oMemWrEn = lsuExIf.store;
  assign oMemAddr = intExIf.memAddr[13:2];

  Fetch #(.START_ADDR(START_ADDR),
            .RST_CFG(RST_CFG),
            .TWO_PIPE(TWO_PIPE))  
    U_Fetch(
             clk, rst, lsuExIf.load, bjBusIf.in,
             oFetchEn, pc, oInsAddr
            );  
  `Pcl_TurtleDecoder  (U_Decode,
                         pc,iInsDat,
                         rfRdIf,
                         rd,intExIf.IntBjMemDeOut,lsuExIf.OutNoAddr,rdVld
                      );


  `Pcl_RegFile(U_RegFile,
                 clk, rst, rfRdIf, 
                           rfWrIf.in,
                           rfFwdIf
              );
                
  ZionRiscvIsaLib_IntEx  U_IntEx(.iDat(intExIf.IntBjMemExIn),
                                 .oDat(intExIf.IntBjMemExOut)
                                );

  always_comb bjBusIf.SetItfDat({intExIf.bjEn,intExIf.BjTgt});

  StoreDatGen U_StoreDatGen(
                              lsuExIf.in,
                              oMemWrMask,
                              oMemWrDat
                            );

  assign lsuExIf.memAddr = intExIf.memAddr;

  WriteBack #(RV64,TWO_PIPE,RST_CFG)
    U_WriteBack(clk, 
                rst, 
                lsuExIf.in, 
                iMemDat, 
                rd, 
                intExIf.intRslt,
                rfWrIf.out,
                rfFwdIf[0]
               );
  Autosim U_Autosim(.clk(clk),
                    .rst(rst),
                    .ins(iInsDat),
                    .pc(pc),
                    .RfWrChannel(rfWrIf),
                    .fetchstl(~oFetchEn)
                   ); 
ZionProcessorComponentLib_LsuItf   MEMExIf();


`Unuse_ZionBasicCircuitLib(Bc_)
`Unuse_ZionRiscvIsaLib(Rvi_)
`Unuse_ZionProcessorComponentLib(Pcl_)
endmodule :  Core
