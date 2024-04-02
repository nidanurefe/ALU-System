`timescale 1ns / 1ps
`include "Register.v"

module AddressRegisterFile(
    input wire [15:0] I, // 16-bit input data 
    input wire [1:0] OutCSel, OutDSel, // 2-bit output C and D select input
    input wire [2:0] FunSel, // 3-bit function select input
    input wire [2:0] RegSel, // 4-bit register select input
    input wire Clock, // Clock signal for synchronous operation
    output wire [15:0] OutC, OutD //Outputs A and B
);

wire [15:0] PCOutput, AROutput, SPOutput;  // Declare the output of the registers

// Instantiate the registers for PC, AR, and SP using the Register module

Register PC(
    .I(I), 
    .E(~RegSel[2]),  // Enable logic for PC
    .FunSel(FunSel), 
    .Clock(Clock), 
    .Q(PCOutput)
);

Register AR(
    .I(I), 
    .E(~RegSel[1]),  // Enable logic for AR
    .FunSel(FunSel), 
    .Clock(Clock), 
    .Q(AROutput)
);

Register SP(
    .I(I), 
    .E(~RegSel[0]),  // Enable logic for SP
    .FunSel(FunSel), 
    .Clock(Clock), 
    .Q(SPOutput)
);

// Output the selected register to OutC
assign OutC = OutCSel == 2'b00 ? PCOutput :
              OutCSel == 2'b01 ? PCOutput :
              OutCSel == 2'b10 ? AROutput :
                                  SPOutput; // 2'b11

// Output the selected register to OutD
assign OutD = OutDSel == 2'b00 ? PCOutput :
              OutDSel == 2'b01 ? PCOutput :
              OutDSel == 2'b10 ? AROutput :
                                  SPOutput; // 2'b11

endmodule




