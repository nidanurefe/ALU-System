`timescale 1ns / 1ps


module InstructionRegister (
    input wire Clock,           // Clock signal
    input wire Write,           // Write control signal
    input wire [7:0] I,         // 8-bit data input
    input wire LH,              // Control which byte to be written
    output reg [15:0] IROut     // 16-bit data output
);

// Load input data into appropriate byte during write operation
always @(posedge Clock) begin
        if (Write) begin
            if (LH == 1'b0) begin
                IROut[7:0] <= I; // LSB
            end else begin
                IROut[15:8] <= I; // MSB
            end
        end
    end

endmodule