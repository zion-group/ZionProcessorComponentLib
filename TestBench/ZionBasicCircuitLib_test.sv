module ZionBasicCircuitLib_test;
`Use_ZionBasicCircuitLib(Bc)

parameter WIDTH_ADDR = 8,
          WIDTH_OUT  = 32,
          WIDTH_BIT  = 32,
		      MASK_FLAG  = 0;
logic     [WIDTH_ADDR-1:0] iAddr;
logic     [WIDTH_OUT -1:0] oDat50;
`BcBitMaskGen     ( U_BitMaskGen,
                      iAddr,
				              oDat50,
				              WIDTH_BIT,
				              MASK_FLAG
                  );

parameter WIDTH_DATA_IN   = 32,
          WIDTH_DATA_OUT  = 32;		  
logic     [WIDTH_DATA_IN -1:0] iDat51;
logic     [WIDTH_DATA_OUT-1:0] oDat51;
`BcBitRead        ( U_BitRead,
                      iAddr,
				              iDat51,
				              oDat51
                  );
   
logic     [WIDTH_DATA_IN -1:0]  iDat52;
logic     [WIDTH_DATA_OUT-1:0]  oDat52;
`BcBitWrite       ( U_BitWrite,
                      iAddr,
				              iDat52,
				              oDat52
                  );


parameter int WIDTH_TYPE_NUM        = 2,
              MULTI_DATA_WIDTH[2]   = {32'd16,32'd8},
			        ADDR_TYPE             = 0;
logic     [WIDTH_TYPE_NUM-1:0] iEn;
// logic     [WIDTH_DATA_IN -1:0] iDat53;
// logic     [WIDTH_DATA_OUT-1:0] oDat53;
// `BcDatRead        ( U_DatRead,
//                       iEn,
//                       iAddr,
// 				              iDat53,
// 				              oDat53,
// 				              MULTI_DATA_WIDTH,
// 				              ADDR_TYPE
//                   );

logic     [WIDTH_DATA_IN -1:0] iDat54;
logic     [WIDTH_DATA_OUT-1:0] oDat54;				
`BcWriteDatExtd   ( U_WriteDatExtd,
                      iEn,
                      iAddr,
				              iDat54,
				              oDat54,
				              MULTI_DATA_WIDTH,
				              ADDR_TYPE
                  );

parameter int MASK_WIDTH[2] = {32'd16,32'd8};
logic     [WIDTH_DATA_OUT-1:0] oDat55;
`BcWriteMaskExtd  ( U_WriteMaskExtd,
                      iEn,
                      iAddr,
				              oDat55,
                      MASK_WIDTH,
				              ADDR_TYPE,
				              MASK_FLAG
                  );

parameter WIDTH_IN1    = 32,
          WIDTH_ADDR1  = 32,   
          WIDTH_OUT1   = 32;
// logic                  clk1,rst1;
// logic                  iEn1 ;
// logic                  iClr1;
// logic [WIDTH_IN1 -1:0] iDat1;
// logic [WIDTH_OUT1-1:0] oDat1;
// `BcClrEnRapDff    (U_ClrEnRapDff,
//                      clk1,rst1,iEn1,iClr1,iDat1, 
//                      oDat1                                
//                   );


// logic                  clk2,rst2;
// logic                  iEn2 ;
// logic                  iClr2;
// logic [WIDTH_IN1 -1:0] iDat2;
// logic [WIDTH_OUT1-1:0] oDat2;
// `BcClrEnRanDff    (U_ClrEnRanDff,
//                      clk2,rst2,iEn2,iClr2,iDat2, 
//                      oDat2                           
//                   );
  
logic                  clk3,rst3;
logic                  iEn3 ;
logic                  iClr3;
logic [WIDTH_IN1 -1:0] iDat3;
logic [WIDTH_OUT1-1:0] oDat3;
`BcClrEnRcDff     (U_ClrEnRcDff,           
                     clk3,rst3,iEn3,iClr3,iDat3,    
                     oDat3                          
                  );

// logic                  clk4,rst4;
// logic                  iEn4 ;
// logic                  iClr4;
// logic [WIDTH_IN1 -1:0] iDat4;
// logic [WIDTH_OUT1-1:0] oDat4;
// `BcClrEnRsnDff    (U_ClrEnRsnDff,
//                      clk4,rst4,iEn4,iClr4,iDat4, 
//                      oDat4                                
//                   );

// logic                  clk5,rst5;
// logic                  iEn5 ;
// logic                  iClr5;
// logic [WIDTH_IN1 -1:0] iDat5;
// logic [WIDTH_OUT1-1:0] oDat5;
// `BcClrEnRspDff    (U_ClrEnRspDff,
//                      clk5,rst5,iEn5,iClr5,iDat5,
//                      oDat5                             
//                   );

// logic                  clk6,rst6;
// logic                  iClr6;
// logic [WIDTH_IN1 -1:0] iDat6;
// logic [WIDTH_OUT1-1:0] oDat6;
// `BcClrRanDff      (U_ClrRanDff,
//                      clk6,rst6,iClr6,iDat6,     
//                      oDat6                              
//                   );

// logic                  clk7,rst7;
// logic                  iClr7;
// logic [WIDTH_IN1 -1:0] iDat7;
// logic [WIDTH_OUT1-1:0] oDat7;
// `BcClrRapDff      (U_ClrRapDff,
//                      clk7,rst7,iClr7,iDat7,     
//                      oDat7               
//                   );

logic                  clk8,rst8;
logic                  iClr8;
logic [WIDTH_IN1 -1:0] iDat8;
logic [WIDTH_OUT1-1:0] oDat8;
`BcClrRcDff       (U_ClrRcDff,
                     clk8,rst8,iClr8,iDat8,         
                     oDat8           
                  );  

// logic                  clk9,rst9;
// logic                  iClr9;
// logic [WIDTH_IN1 -1:0] iDat9;
// logic [WIDTH_OUT1-1:0] oDat9;
// `BcClrRsnDff      (U_ClrRsnDff,
//                      clk9,rst9,iClr9,iDat9,     
//                      oDat9             
//                   );
  
// logic                  clk10,rst10;
// logic                  iClr10;
// logic [WIDTH_IN1 -1:0] iDat10;
// logic [WIDTH_OUT1-1:0] oDat10;
// `BcClrRspDff      (U_ClrRspDff,
//                      clk10,rst10,iClr10,iDat10, 
//                      oDat10     
//                   );
  
// logic                  clk11;
// logic [WIDTH_IN1 -1:0] iDat11;
// logic [WIDTH_OUT1-1:0] oDat11;
// `BcDff            (U_Dff,
//                      clk11,iDat11,        
//                      oDat11                           
//                   );  

// logic                  clk12;
// logic                  iEn12 ;
// logic [WIDTH_IN1 -1:0] iDat12;
// logic [WIDTH_OUT1-1:0] oDat12;
// `BcEnDff          (U_EnDff,
//                      clk12,iEn12,iDat12,        
//                      oDat12                            
//                   ); 

// logic                  clk13,rst13;
// logic                  iEn13 ;
// logic [WIDTH_IN1 -1:0] iDat13;
// logic [WIDTH_OUT1-1:0] oDat13;
// `BcEnRanDff       (U_EnRanDff,
//                      clk13,rst13,iEn13,iDat13,     
//                      oDat13          
//                   );

// logic                  clk14,rst14;
// logic                  iEn14 ;
// logic [WIDTH_IN1 -1:0] iDat14;
// logic [WIDTH_OUT1-1:0] oDat14;
// `BcEnRapDff       (U_EnRapDff,
//                      clk14,rst14,iEn14,iDat14, 
//                      oDat14     
//                   );

logic                  clk15,rst15;
logic                  iEn15 ;
logic [WIDTH_IN1 -1:0] iDat15;
logic [WIDTH_OUT1-1:0] oDat15;
`BcEnRcDff        (U_EnRcDff,
                     clk15,rst15,iEn15,iDat15,          
                     oDat15       
                  ); 

// logic                  clk16,rst16;
// logic                  iEn16 ;
// logic [WIDTH_IN1 -1:0] iDat16;
// logic [WIDTH_OUT1-1:0] oDat16;
// `BcEnRsnDff       (U_EnRsnDff,
//                      clk16,rst16,iEn16,iDat16,     
//                      oDat16                          
//                   );

// logic                  clk17,rst17;
// logic                  iEn17 ;
// logic [WIDTH_IN1 -1:0] iDat17;
// logic [WIDTH_OUT1-1:0] oDat17;
// `BcEnRspDff       (U_EnRspDff,
//                      clk17,rst17,iEn17,iDat17, 
//                      oDat17        
//                   );

// logic                  clk18,rst18;
// logic [WIDTH_IN1 -1:0] iDat18;
// logic [WIDTH_OUT1-1:0] oDat18;
// `BcRanDff         (U_RanDff,
//                      clk18,rst18,iDat18,          
//                      oDat18             
//                   );

// logic                  clk19,rst19;
// logic [WIDTH_IN1 -1:0] iDat19;
// logic [WIDTH_OUT1-1:0] oDat19;
// `BcRapDff         (U_RapDff,
//                      clk19,rst19,iDat19,    
//                      oDat19       
//                   );

// logic                  clk20,rst20;
// logic [WIDTH_IN1 -1:0] iDat20;
// logic [WIDTH_OUT1-1:0] oDat20;
// `BcRsnDff         (U_RsnDff,
//                      clk20,rst20,iDat20,         
//                      oDat20            
//                   );

// logic                  clk21,rst21;
// logic [WIDTH_IN1 -1:0] iDat21;
// logic [WIDTH_OUT1-1:0] oDat21;
// `BcRspDff         (U_RspDff,
//                      clk21,rst21,iDat21, 
//                      oDat21  
//                   );
  
logic [WIDTH_IN1 -1:0] iDat22;
logic [WIDTH_OUT1-1:0] oDat22;
`BcAbs            ( U_Abs1,
                      iDat22,
                      oDat22
                  );

logic clk,rst,overflow;
// logic [31:0] counter, counter_f;
// Counter_m U_Counter_m(
//                       clk,rst,                     //input
//                       overflow,counter,counter_f   //output        
//                      );

logic [31:0] iDat1_c;
logic [31:0] oDat1_c;
`BcAbs            ( U_Abs,  
                      iDat1_c,                     //input
                      oDat1_c                      //output                             
                  );

logic addEn,subEn;
logic [31:0] datA1_c,datB1_c,oDat11_c;
`BcAddSub         ( U_AddSub,  
                      addEn,subEn,datA1_c,datB1_c, //input
                      oDat11_c                     //output                                   
                  );

logic [9:0] iDat2_c;
logic [9:0] oDat2_c;
`BcBin2Oh         ( U_Bin2Oh,  
                      iDat2_c,                     //input
                      oDat2_c                      //output                                             
                  );

logic [31:0] iDat3_c;
logic [31:0] oDat3_c;
`BcBitmap2Oh      ( U_Bitmap2Oh,  
                      iDat3_c,                     //input
                      oDat3_c                      //output                  
                  );

logic isftR,iSftA,iSftL,iSftC;
logic [31:0] iDat4_c,oDat4_c;
logic [ 4:0] iSftBit;
`BcMultiTypeShift ( U_MultiTypeShift,  
                      isftR,iSftA,iSftL,iSftC,iDat4_c,iSftBit,//input
                      oDat4_c                                 //output        
                  );
                    
logic [ 2:0] iSel5_c;
logic [31:0] iDat5_c;
logic [ 3:0] oDat5_c;
`BcMuxBin         ( U_MuxBin,  
                      iSel5_c,iDat5_c,             //input
                      oDat5_c                      //output        
                  );                   

logic [ 7:0] iSel6_c;
logic [ 3:0] iDat6_c;
logic [31:0] oDat6_c;
`BcMuxBitmap      ( U_MuxBitmap,  
                      iSel6_c,iDat6_c,             //input
                      oDat6_c                      //output        
                  );
                   
logic [ 7:0] iSel7_c;
logic [31:0] iDat7_c;
logic [ 3:0] oDat7_c;
`BcMuxOnehot      ( U_MuxOnehot,  
                      iSel7_c,iDat7_c,             //input
                      oDat7_c                      //output        
                  );
                    
logic [8:0] iDat8_c;
logic [8:0] oDat8_c;
`BcOh2Bin         ( U_Oh2Bin,  
                      iDat8_c,                      //input
                      oDat8_c                       //output        
                  );
                   
logic [31:0] iDat9_c;
logic [31:0] oDat9_c;
`BcOpppsateNum   ( U_OpppsateNum,  
                     iDat9_c,                       //input
                     oDat9_c                        //output        
                 );
                   
logic [9:0] iDat10_c;
logic [9:0] oDat10_c; 
`BcOnehotDefBinM( 
                     iDat10_c,                      //input
				             oDat10_c                       //output  
			         );



`Unuse_ZionBasicCircuitLib(Bc)
endmodule : ZionBasicCircuitLib_test