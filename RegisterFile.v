`timescale 1ns / 1ps
`include "Register.v"

module RegisterFile (
    input wire [15:0] I, // 16-bit input data
    input wire [2:0] OutASel, OutBSel, // 3-bit outputA and outputB select input
    input wire [3:0] RegSel, ScrSel, // 4-bit register and scratch register select input
    input wire [2:0] FunSel, // 3-bit function select input
    output wire [15:0] OutA, OutB, //Outputs A and B
    input wire Clock // Clock signal for synchronous operation
);

// Declare the output of the registers and scratch registers
wire [15:0] R1Output, R2Output, R3Output, R4Output; 
wire [15:0] S1Output, S2Output, S3Output, S4Output; 

// Instantiate the registers and scratch registers using the Register module
Register R1(
    .I(I),
    .E(~RegSel[3]),
    .FunSel(FunSel), 
    .Clock(Clock), 
    .Q(R1Output)
);

Register R2(
    .I(I), 
    .E(~RegSel[2]), 
    .FunSel(FunSel), 
    .Clock(Clock), 
    .Q(R2Output)
);

Register R3(
    .I(I), 
    .E(~RegSel[1]), 
    .FunSel(FunSel), 
    .Clock(Clock), 
    .Q(R3Output)
);

Register R4(
    .I(I), 
    .E(~RegSel[0]), 
    .FunSel(FunSel), 
    .Clock(Clock), 
    .Q(R4Output)
);


Register S1(
    .I(I), 
    .E(~ScrSel[3]), 
    .FunSel(FunSel), 
    .Clock(Clock), 
    .Q(S1Output)
);

Register S2(
    .I(I), 
    .E(~ScrSel[2]), 
    .FunSel(FunSel), 
    .Clock(Clock), 
    .Q(S2Output)
);

Register S3(
    .I(I), 
    .E(~ScrSel[1]), 
    .FunSel(FunSel), 
    .Clock(Clock), 
    .Q(S3Output)
);

Register S4(
    .I(I), 
    .E(~ScrSel[0]), 
    .FunSel(FunSel), 
    .Clock(Clock), 
    .Q(S4Output)
);

// Assign OutA based on OutASel
assign OutA = OutASel == 3'b000 ? R1Output:
              OutASel == 3'b001 ? R2Output :
              OutASel == 3'b010 ? R3Output :
              OutASel == 3'b011 ? R4Output:
              OutASel == 3'b100 ? S1Output :
              OutASel == 3'b101 ? S2Output:
              OutASel == 3'b110 ? S3Output:
                                   S4Output;  // 3'b111

assign OutB = OutBSel == 3'b000 ? R1Output:
              OutBSel == 3'b001 ? R2Output:
              OutBSel == 3'b010 ? R3Output :
              OutBSel == 3'b011 ? R4Output :
              OutBSel == 3'b100 ? S1Output:
              OutBSel == 3'b101 ? S2Output :
              OutBSel == 3'b110 ? S3Output :
                                   S4Output;  // 3'b111

endmodule
