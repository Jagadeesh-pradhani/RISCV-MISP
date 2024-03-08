module IF_tb();

    reg clk = 1, rst, EX_MEM_Cond;
    reg [31:0] EX_MEM_ALUout;

    wire [31:0] NPC, IR;

    //DUT
    IF_cycle idut(
        .clk(clk), 
        .rst(rst), 
        .EX_MEM_ALUout(EX_MEM_ALUout), 
        .EX_MEM_Cond(EX_MEM_Cond), 
        .NPC(NPC), 
        .IR(IR)
        );

    //clock cycle
    always begin
        clk = ~clk;
        #50;
    end

    initial begin
        rst <= 1'b0;
        #200;
        rst <= 1'b1;
        EX_MEM_Cond <= 1'b0;
        EX_MEM_ALUout <= 32'h00000000;
        #500;
        $finish;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end

    
endmodule