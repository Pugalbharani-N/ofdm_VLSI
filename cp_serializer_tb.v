`timescale 1ns / 1ps

module cp_serializer_tb();

    // Parameters
    parameter CLK_PERIOD = 10;  // 10 ns clock period

    // Signals
    reg clk;
    reg reset;
    reg valid;
    reg [303:0] cp_out;
    wire [15:0] data_out;
    wire valid_out;

    // ------------------ FIX: Declare array at module scope ------------------
    integer i;  // For loop index
    reg [303:0] cp_vectors [0:15]; // 16-element array, each 304 bits

    // Instantiate the Device Under Test (DUT)
    cp_serializer uut (
        .clk(clk),
        .reset(reset),
        .cp_out(cp_out),
        .valid(valid),
        .data_out(data_out),
        .valid_out(valid_out)
    );

    // Clock generation (50 MHz)
    always #(CLK_PERIOD/2) clk = ~clk;

    // Stimulus process
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        valid = 0;
        
        // Apply reset
        #20 reset = 0;

        // ------------------ Pre-load the cp_vectors array ------------------
        cp_vectors[0]  = 304'h0007000500080000000000000000000700020005000100000000000000000002000000000007;
        cp_vectors[1]  = 304'h0006000500060000000000000000000600030005000300000000000000000003000000000006;
        cp_vectors[2]  = 304'h000a0005000b0000000000000000000a00000004fffe0000000000000000000000000000000a;
        cp_vectors[3]  = 304'h00080005000a0000000000000000000800010005ffff00000000000000000001000000000008;
        cp_vectors[4]  = 304'h0006000300070000000000000000000600010003000000000000000000000001000000000006;
        cp_vectors[5]  = 304'h0005000300050000000000000000000500020003000200000000000000000002000000000005;
        cp_vectors[6]  = 304'h00080003000a00000000000000000008fffe0003fffc0000000000000000fffe000000000008;
        cp_vectors[7]  = 304'h0007000300080000000000000000000700000003fffe00000000000000000000000000000007;
        cp_vectors[8]  = 304'h0005000200050000000000000000000500000002ffff00000000000000000000000000000005;
        cp_vectors[9]  = 304'h0003000200040000000000000000000300010002000000000000000000000001000000000003;
        cp_vectors[10] = 304'h00070002000900000000000000000007fffd0002fffb0000000000000000fffd000000000007;
        cp_vectors[11] = 304'h00060002000700000000000000000006fffe0002fffd0000000000000000fffe000000000006;
        cp_vectors[12] = 304'h00030001000400000000000000000003fffe0001fffd0000000000000000fffe000000000003;
        cp_vectors[13] = 304'h0002000100020000000000000000000200000001ffff00000000000000000000000000000002;
        cp_vectors[14] = 304'h00060001000800000000000000000006fffc0001fffa0000000000000000fffc000000000006;
        cp_vectors[15] = 304'h00050001000600000000000000000005fffd0001fffc0000000000000000fffd000000000005;

        // Send each vector one by one
        for (i = 0; i < 16; i = i + 1) begin
            cp_out = cp_vectors[i];

            // Start serialization
            #10 valid = 1;

            // Wait for 19 cycles (19 * 10 ns = 190 ns) + some buffer
            #200 valid = 0;
            
            // Wait a little before next input
            #20;
        end

        // End simulation
        #50 $stop;
    end

    // Monitor the output
    initial begin
        $monitor("Time=%0t ns | cp_out=%h | data_out=%h | valid_out=%b", 
                 $time, cp_out, data_out, valid_out);
    end

endmodule



