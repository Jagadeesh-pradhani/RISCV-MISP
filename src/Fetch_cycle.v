`include "Mux.v"
`include "PC_Adder.v"
`include "PC.v"
`include "Instruction_Memory.v"

module IF_cycle(clk, rst, EX_MEM_ALUout, EX_MEM_Cond, NPC, IR);

    input clk, rst;
    input EX_MEM_Cond;
    input [31:0] EX_MEM_ALUout;
    output [31:0] NPC, IR;

    //intermediate wires
    wire [31:0] PC_Plus4, PC_Next, NEW_PC;
    wire [31:0] IF_IR;

    //output registers
    reg [31:0] NPC_reg, IR_reg;



    //Modules
    
    //MUX
    Mux PC_Mux(
            .a(PC_Plus4),
            .b(EX_MEM_ALUout),
            .s(EX_MEM_Cond),
            .c(PC_Next)
            );

    //PC counter
    PC_Module Program_Counter(
                        .clk(clk),
                        .rst(rst),
                        .NPC(PC_Next),
                        .PC(NEW_PC)
                        );

    //Instruction memory
    Instruction_Memory IMEM(
                        .rst(rst),
                        .A(NEW_PC),
                        .RD(IF_IR)
                        );

    //Adder For PC
    PC_Adder PC_adder(
                    .a(NEW_PC),
                    .b(32'h00000004),
                    .c(PC_Plus4)
                    );

    //IF reg logic
    always @(posedge clk or negedge rst)  begin
        if(rst == 1'b0)begin
            NPC_reg <= 32'h00000000;
            IR_reg <= 32'h00000000;
        end
        else begin
            NPC_reg <= PC_Next;
            IR_reg <= IF_IR;
        end
    end

    //Assigning reg to output ports
    assign NPC = (rst == 1'b0) ? 32'h00000000 : NPC_reg;
    assign IR = (rst == 1'b0) ? 32'h00000000 : IR_reg;


    
endmodule