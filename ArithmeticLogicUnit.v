`timescale 1ns / 1ps 

module ArithmeticLogicUnit(
    input wire [15:0] A,
    input wire [15:0] B,
    input wire [4:0] FunSel,
    input wire WF,
    input wire Clock,
    output reg [15:0] ALUOut,
    output reg [3:0] FlagsOut
);

reg Z = 0;
reg C = 0;
reg N = 0;
reg O = 0;

always @(posedge Clock) begin
    case (FunSel)
        5'b00000: ALUOut[7:0] = A[7:0]; 
        5'b10000: ALUOut = A; 

        5'b00001: ALUOut[7:0] = B[7:0] ;
        5'b10001: ALUOut = B ;

        5'b00010: ALUOut[7:0] = ~A[7:0]; // 8-bit NOT
        5'b10010: ALUOut = ~A; // 16-bit NOT

        5'b00011: ALUOut[7:0] = ~B[7:0]; // 8-bit NOT
        5'b10011: ALUOut = ~B; // 16-bit NOT

        5'b00100: begin
            {C, ALUOut[7:0]} = A[7:0] + B[7:0]; // 8-bit addition
            O = (A[7] == B[7]) && (B[7] != ALUOut[7]);
        end

        5'b10100: begin
            {C, ALUOut} = A + B; // 16-bit addition
            O = (A[15] == B[15]) && (B[15] != ALUOut[15]);
        end

        5'b00101: begin
            {C, ALUOut[7:0]} = {1'b0, A[7:0]} + {1'b0, B[7:0]} + {8'd0, C};
            O = (A[7] == B[7]) && (B[7] != ALUOut[7]);
        end

        5'b10101: begin
            {C, ALUOut} = {1'b0, A} + {1'b0, B} + {15'd0, C};
            O = (A[15] == B[15]) && (B[15] != ALUOut[15]);
        end

        5'b00110: begin
            {C, ALUOut[7:0]} = {1'b0, A[7:0]} + {1'b0, (~B[7:0] + 8'd1)}; // 8-bit subtraction
            O = (B[7] == ALUOut[7]) && (B[7] != ALUOut[7]);
        end

        5'b10110: begin
            {C, ALUOut} = {1'b0, A} + {1'b0, (~B + 16'd1)}; // 16-bit subtraction
            O = (B[15] == ALUOut[15]) && (B[15] != ALUOut[15]);
        end

        5'b01110: begin
            ALUOut = {A[6:0], A[7]}; 
            C = A[7]; 
            N = ALUOut[7];
        end

        5'b11110: begin
            ALUOut = {A[14:0], A[15]}; 
            C = A[14]; 
            N = ALUOut[14];
        end

        5'b01111: begin
            ALUOut = {C, A[7:1]};
            C = A[0];
            N = ALUOut[7];
        end

        5'b11111: begin
            ALUOut = {C, A[15:1]};
            C = A[0];
            N = ALUOut[15];
        end
    endcase

    if (WF) begin
        if(FunSel[4] == 1'b0) 
            Z = (ALUOut[7:0] == 8'b0);
        else 
            Z = (ALUOut == 16'b0);
    end

    FlagsOut <= {Z,C,N,O};    
end

endmodule
