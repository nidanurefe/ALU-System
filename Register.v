`timescale 1ns / 1ps

module Register(
    input wire Clock, //Clock input
    input wire E,  //Enable input 
    input wire [2:0] FunSel, // 3-bit function select input 
    input wire [15:0] I, //Input data
    output reg [15:0] Q // 16-bit output register
    
);

//This block is triggered by positive edge of clock
always @(posedge Clock) 
    begin
    if (E == 1'b0)  //If enable is low
        begin
            Q <= Q;  // Retain current value of Q
        end
    else begin
        case (FunSel)
            3'b000: Q <= Q - 1;  // Decrement operation
            3'b001: Q <= Q + 1;  // Increment operation
            3'b010: Q <= I;      // Load operation
            3'b011: Q <= 16'b0;   // Clear operation
            3'b100: begin //Clear(High) and Write low(Low)
                        Q[15:8] <= 8'b0;  
                        Q[7:0] <= I[7:0]; 
                    end
            3'b101: Q[7:0] <= I[7:0]; // Only Write Low
            3'b110: Q[15:8] <= I[7:0]; // Only Write High
            3'b111: begin // Sign extend I(7) and Write Low
                        Q[15:8] <= {{8{I[7]}}, I[7:0]};  
                        Q[7:0] <= I[7:0];  
                    end
        endcase
    end
endmodule

