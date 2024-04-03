`timescale 1ns / 1ps

`include "Register.v"
`include "AddressRegisterFile.v"
`include "ArithmeticLogicUnit.v"
`include "InstructionRegister.v"
`include "RegisterFile.v"
`include "Memory.v"


module MUX4to1(S, D0, D1, D2, D3, Q);
    input wire [1:0] S;
    input wire [15:0] D0; 
    input wire [15:0] D1;
    input wire [15:0] D2;
    input wire [15:0] D3;
    output reg [15:0] Q;

    always@(*) begin
        case(S)
            2'b00: Q = D0;
            2'b01: Q = D1;
            2'b10: Q = D2;
            2'b11: Q = D3;
            default: Q = 16'hXXXX;
        endcase
    end
endmodule


module MUX2TO1(S, D0, Q);
    input wire S;
    input wire [15:0] D0; 
    output reg [7:0] Q;

    always@(*) begin
        case(S)
            1'b0 : Q <= D0[7:0];
            1'b1 : Q <= D0[15:8];
            default: Q = 8'hXX;
        endcase
    end
endmodule



module ArithmeticLogicUnitSystem(
    //RF

    input wire [2:0] RF_OutASel,
    input wire [2:0] RF_OutBSel,
    input wire [2:0] RF_FunSel,
    input wire [3:0] RF_RegSel,
    input wire [3:0] RF_ScrSel,
    output wire [15:0] OutA,
    output wire [15:0] OutB,


    //ALU
    input wire ALU_WF,
    input wire[4:0] ALU_FunSel,
    output wire [3:0] ALUOutFlag,
    output wire [15:0] ALUOut,

    //ARF
    input wire[1:0] ARF_OutCSel,
    input wire[1:0] ARF_OutDSel,
    input wire[2:0] ARF_FunSel,
    input wire[2:0] ARF_RegSel,
    output wire [15:0] OutC,


    // IR
    input wire IR_LH,
    input wire IR_Write,
    output wire[15:0] IROut,

    //Memory
    input wire Mem_WR,
    input wire Mem_CS,
    output wire[7:0] MemOut,

    //MUX
    input wire[1:0] MuxASel,
    output wire [15:0] MuxAOut,

    input wire[1:0] MuxBSel,
    output wire [15:0] MuxBOut,

    input wire MuxCSel,
    output wire [7:0] MuxCOut,
    input wire Clock,
    output wire [15:0] Address

);


        RegisterFile RF(
            .I(MuxAOut), 
            .OutASel(RF_OutASel), 
            .OutBSel(RF_OutBSel), 
            .RegSel(RF_RegSel), 
            .FunSel(RF_FunSel), 
            .ScrSel(RF_ScrSel),
            .OutA(OutA),
            .OutB(OutB),
            .Clock(Clock)
        );

        ArithmeticLogicUnit ALU(
            .A(OutA),
            .B(OutB),
            .FunSel(ALU_FunSel),
            .WF(ALU_WF),
            .ALUOut(ALUOut),
            .FlagsOut(ALUOutFlag),
            .Clock(Clock)
         
        );


        AddressRegisterFile ARF(
            .I(MuxBOut),
            .OutCSel(ARF_OutCSel),
            .OutDSel(ARF_OutDSel),
            .FunSel(ARF_FunSel),
            .RegSel(ARF_RegSel),
            .OutC(OutC),
            .OutD(Address),
            .Clock(Clock)
        );

        InstructionRegister IR(
            .Write(IR_Write),
            .LH(IR_LH),
            .I(MemOut),
            .IROut(IROut),
            .Clock(Clock)

        );

        Memory MEM(
            .WR(Mem_WR),
            .CS(Mem_CS),
            .Address(Address),
            .Data(MuxCOut),
            .MemOut(MemOut),
            .Clock(Clock)
        );

        MUX4to1 MA(
            .S(MuxASel),
            .D0(IROut),
            .D1({8'b0, MemOut}),
            .D2(OutC),
            .D3(ALUOut),
            .Q(MuxAOut)
        );

        MUX4to1 MB(
            .S(MuxBSel),
            .D0(IROut),
            .D1({8'b0, MemOut}),
            .D2(OutC),
            .D3(ALUOut),
            .Q(MuxBOut)
        );

        MUX2TO1 MC(
            .S(MuxCSel),
            .D0(ALUOut),
            .Q(MuxCOut)
            
        );

endmodule

  
    



