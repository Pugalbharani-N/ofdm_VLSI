module dual_ifft8_tb;
    reg [127:0] freq_in_phase;
    reg [127:0] freq_in_quad;
    wire [127:0] time_out_phase;
    wire [127:0] time_out_quad;
    integer idx;
    
    // Instantiate the dual IFFT module.
    dual_ifft8 uut (
        .freq_in_phase(freq_in_phase),
        .freq_in_quad(freq_in_quad),
        .time_out_phase(time_out_phase),
        .time_out_quad(time_out_quad)
    );
    
    // Define arrays of test frequency-domain inputs (128-bit) for in-phase and quadrature.
    // These values are taken from your table (i.e. the outputs from your zero-padding block).
    reg [127:0] test_phase [0:15];
    reg [127:0] test_quad  [0:15];
    
    initial begin
        // Initialize the test vectors as provided.
        test_phase[0]  = 128'h00000000001400140014001400000000;
        test_quad[0]   = 128'h00000000002800280028002800000000;
        
        test_phase[1]  = 128'h00000000000A000A000A000A00000000;
        test_quad[1]   = 128'h00000000002800280028002800000000;
        
        test_phase[2]  = 128'h00000000002800280028002800000000;
        test_quad[2]   = 128'h00000000002800280028002800000000;
        
        test_phase[3]  = 128'h00000000001E001E001E001E00000000;
        test_quad[3]   = 128'h00000000002800280028002800000000;
        
        test_phase[4]  = 128'h00000000001400140014001400000000;
        test_quad[4]   = 128'h00000000001E001E001E001E00000000;
        
        test_phase[5]  = 128'h00000000000A000A000A000A00000000;
        test_quad[5]   = 128'h00000000001E001E001E001E00000000;
        
        test_phase[6]  = 128'h00000000002800280028002800000000;
        test_quad[6]   = 128'h00000000001E001E001E001E00000000;
        
        test_phase[7]  = 128'h00000000001E001E001E001E00000000;
        test_quad[7]   = 128'h00000000001E001E001E001E00000000;
        
        test_phase[8]  = 128'h00000000001400140014001400000000;
        test_quad[8]   = 128'h00000000001400140014001400000000;
        
        test_phase[9]  = 128'h00000000000A000A000A000A00000000;
        test_quad[9]   = 128'h00000000001400140014001400000000;
        
        test_phase[10] = 128'h00000000002800280028002800000000;
        test_quad[10]  = 128'h00000000001400140014001400000000;
        
        test_phase[11] = 128'h00000000001E001E001E001E00000000;
        test_quad[11]  = 128'h00000000001400140014001400000000;
        
        test_phase[12] = 128'h00000000001400140014001400000000;
        test_quad[12]  = 128'h00000000000A000A000A000A00000000;
        
        test_phase[13] = 128'h00000000000A000A000A000A00000000;
        test_quad[13]  = 128'h00000000000A000A000A000A00000000;
        
        test_phase[14] = 128'h00000000002800280028002800000000;
        test_quad[14]  = 128'h00000000000A000A000A000A00000000;
        
        test_phase[15] = 128'h00000000001E001E001E001E00000000;
        test_quad[15]  = 128'h00000000000A000A000A000A00000000;
        
        // Display header for outputs only.
        $display("Time_Domain_Output_Phase (128-bit)        Time_Domain_Output_Quad (128-bit)");
        // Loop through all test cases.
        for (idx = 0; idx < 16; idx = idx + 1) begin
            freq_in_phase = test_phase[idx];
            freq_in_quad  = test_quad[idx];
            #10;  // Allow propagation.
            $display("%032h   %032h", time_out_phase, time_out_quad);
        end
        $finish;
    end
endmodule

