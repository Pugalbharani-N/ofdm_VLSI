module cyclic_prefix_256_tb;
    reg [127:0] phase;
    reg [127:0] quad;
    wire [303:0] symbol_out;
    integer idx;
    
    // Instantiate the cyclic prefix module.
    cyclic_prefix_256 uut (
        .phase(phase),
        .quad(quad),
        .symbol_out(symbol_out)
    );
    
    // Define arrays for the 16 test vectors (each 128 bits) for phase and quad,
    // taken from your table.
    reg [127:0] phase_array [0:15];
    reg [127:0] quad_array  [0:15];
    
    initial begin
        // Index 0
        phase_array[0] = 128'h000a000a000a000a000a000a000a000a;
        quad_array[0]  = 128'h00140014001400140014001400140014;
        // Index 1
        phase_array[1] = 128'h00050005000500050005000500050005;
        quad_array[1]  = 128'h00140014001400140014001400140014;
        // Index 2
        phase_array[2] = 128'h00140014001400140014001400140014;
        quad_array[2]  = 128'h00140014001400140014001400140014;
        // Index 3
        phase_array[3] = 128'h000f000f000f000f000f000f000f000f;
        quad_array[3]  = 128'h00140014001400140014001400140014;
        // Index 4
        phase_array[4] = 128'h000a000a000a000a000a000a000a000a;
        quad_array[4]  = 128'h000f000f000f000f000f000f000f000f;
        // Index 5
        phase_array[5] = 128'h00050005000500050005000500050005;
        quad_array[5]  = 128'h000f000f000f000f000f000f000f000f;
        // Index 6
        phase_array[6] = 128'h00140014001400140014001400140014;
        quad_array[6]  = 128'h000f000f000f000f000f000f000f000f;
        // Index 7
        phase_array[7] = 128'h000f000f000f000f000f000f000f000f;
        quad_array[7]  = 128'h000f000f000f000f000f000f000f000f;
        // Index 8
        phase_array[8] = 128'h000a000a000a000a000a000a000a000a;
        quad_array[8]  = 128'h000a000a000a000a000a000a000a000a;
        // Index 9
        phase_array[9] = 128'h00050005000500050005000500050005;
        quad_array[9]  = 128'h000a000a000a000a000a000a000a000a;
        // Index 10
        phase_array[10] = 128'h00140014001400140014001400140014;
        quad_array[10]  = 128'h000a000a000a000a000a000a000a000a;
        // Index 11
        phase_array[11] = 128'h000f000f000f000f000f000f000f000f;
        quad_array[11]  = 128'h000a000a000a000a000a000a000a000a;
        // Index 12
        phase_array[12] = 128'h000a000a000a000a000a000a000a000a;
        quad_array[12]  = 128'h00050005000500050005000500050005;
        // Index 13
        phase_array[13] = 128'h00050005000500050005000500050005;
        quad_array[13]  = 128'h00050005000500050005000500050005;
        // Index 14
        phase_array[14] = 128'h00140014001400140014001400140014;
        quad_array[14]  = 128'h00050005000500050005000500050005;
        // Index 15
        phase_array[15] = 128'h000f000f000f000f000f000f000f000f;
        quad_array[15]  = 128'h00050005000500050005000500050005;
        
        $display("Final 304-bit Cyclic Prefix Outputs (76 hex digits each):");
        // Loop through all test vectors.
        for (idx = 0; idx < 16; idx = idx + 1) begin
            phase = phase_array[idx];
            quad  = quad_array[idx];
            #10;  // Allow propagation.
            $display("%076h", symbol_out);
        end
        $finish;
    end
endmodule


