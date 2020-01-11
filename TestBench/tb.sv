`define INS_FILE "/home/train/huangzili/benchmark_init0/a_add_b/add.dat"
`define DAT_FILE "/home/train/huangzili/benchmark_init0/a_add_b/add.dat"
`define FINISH_TIME 900000000
`define LAST_PC 32'h2b4
`define TWO_PIPE 1  



module tb;
  logic clk,rst;

  CoreTop #(.INS_FILE(`INS_FILE),
            .DAT_FILE(`DAT_FILE),
            .LAST_PC(`LAST_PC))
          U_CoreTop(.clk(clk),
          	        .rst(rst));

  initial begin
    clk = 0;
    forever #10 clk = ~clk;
  end

  initial begin
        rst = 1;
    #3  rst = 0;
    #85 rst = 1;
  end


//initial #10000 $finish;
  `define FSDB
  `ifdef FSDB
  initial begin
    $fsdbDumpfile("tb.fsdb");
    $fsdbDumpvars(0,tb,"+all");
    $fsdbDumpvars();
    #(`FINISH_TIME) $finish;
  end
  `endif
/*
  `ifdef VPD
  initial begin
    $vcdplusfile("tb.vpd");
    $vcdpluson();
  end
  `endif

  `ifdef VCD
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars();
  end
  `endif
*/


endmodule
