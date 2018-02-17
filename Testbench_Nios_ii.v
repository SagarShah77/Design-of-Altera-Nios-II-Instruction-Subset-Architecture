`include "Nios_ii.v"
module NIOS_II_TB();
reg clk_18 = 0;
wire[31:0] alu_out_WB_18,Rd_D_18;
NIOS_II DUT(.clk_18(clk_18),.alu_out_WB_18(alu_out_WB_18),.Rd_WB_18(Rd_WB_18));
always
#5 clk_18 = ~clk_18;

initial begin

$dumpfile("nios.vcd");

$dumpvars(0, NIOS_II_TB);

end

endmodule
