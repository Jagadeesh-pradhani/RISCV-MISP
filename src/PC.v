module PC_Module(clk,rst,NPC,PC);
    input clk,rst;
    input [31:0] NPC;
    output [31:0] PC;
    reg [31:0] PC;

    always @(posedge clk)
    begin
        if(rst == 1'b0)
            PC <= {32{1'b0}};
        else
            PC <= NPC;
    end
endmodule