module dual_fft8_tb;
    reg [127:0] fft_in_phase;
    reg [127:0] fft_in_quad;
    wire [127:0] fft_out_phase;
    wire [127:0] fft_out_quad;
    integer i;
    
    // Instantiate the dual channel FFT module.
    dual_fft8 uut (
        .fft_in_phase(fft_in_phase),
        .fft_in_quad(fft_in_quad),
        .fft_out_phase(fft_out_phase),
        .fft_out_quad(fft_out_quad)
    );
    
    // Define arrays of 128-bit test vectors.
    // The active value is placed in word2 (bits [47:32]), while the rest is zero.
    reg [127:0] test_phase [0:15];
    reg [127:0] test_quad  [0:15];
    
    initial begin
        // In-Phase Test Vectors:
        // Index: active value (A)
        // 0 -> 0x0014, 1 -> 0x000A, 2 -> 0x0028, 3 -> 0x001E, 4 -> 0x0014, 
        // 5 -> 0x000A, 6 -> 0x0028, 7 -> 0x001E, 8 -> 0x0014, 9 -> 0x000A,
        // 10 -> 0x0028, 11 -> 0x001E, 12 -> 0x0014, 13 -> 0x000A, 14 -> 0x0028, 15 -> 0x001E.
        test_phase[0]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0014, 16'h0000, 16'h0000};
        test_phase[1]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h000A, 16'h0000, 16'h0000};
        test_phase[2]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0028, 16'h0000, 16'h0000};
        test_phase[3]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h001E, 16'h0000, 16'h0000};
        test_phase[4]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0014, 16'h0000, 16'h0000};
        test_phase[5]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h000A, 16'h0000, 16'h0000};
        test_phase[6]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0028, 16'h0000, 16'h0000};
        test_phase[7]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h001E, 16'h0000, 16'h0000};
        test_phase[8]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0014, 16'h0000, 16'h0000};
        test_phase[9]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h000A, 16'h0000, 16'h0000};
        test_phase[10] = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0028, 16'h0000, 16'h0000};
        test_phase[11] = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h001E, 16'h0000, 16'h0000};
        test_phase[12] = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0014, 16'h0000, 16'h0000};
        test_phase[13] = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h000A, 16'h0000, 16'h0000};
        test_phase[14] = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0028, 16'h0000, 16'h0000};
        test_phase[15] = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h001E, 16'h0000, 16'h0000};
        
        // Quad-Phase Test Vectors:
        // For quad phase the active values are:
        // Indices 0-3: 0x0028, Indices 4-7: 0x001E,
        // Indices 8-11: 0x0014, Indices 12-15: 0x000A.
        test_quad[0]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0028, 16'h0000, 16'h0000};
        test_quad[1]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0028, 16'h0000, 16'h0000};
        test_quad[2]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0028, 16'h0000, 16'h0000};
        test_quad[3]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0028, 16'h0000, 16'h0000};
        test_quad[4]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h001E, 16'h0000, 16'h0000};
        test_quad[5]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h001E, 16'h0000, 16'h0000};
        test_quad[6]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h001E, 16'h0000, 16'h0000};
        test_quad[7]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h001E, 16'h0000, 16'h0000};
        test_quad[8]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0014, 16'h0000, 16'h0000};
        test_quad[9]  = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0014, 16'h0000, 16'h0000};
        test_quad[10] = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0014, 16'h0000, 16'h0000};
        test_quad[11] = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0014, 16'h0000, 16'h0000};
        test_quad[12] = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h000A, 16'h0000, 16'h0000};
        test_quad[13] = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h000A, 16'h0000, 16'h0000};
        test_quad[14] = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h000A, 16'h0000, 16'h0000};
        test_quad[15] = {16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'h000A, 16'h0000, 16'h0000};
        
        // Display header.
        $display("Index  FFT_Out_Phase (128-bit)                 FFT_Out_Quad (128-bit)");
        // Loop through test cases.
        for (i = 0; i < 16; i = i + 1) begin
            fft_in_phase = test_phase[i];
            fft_in_quad  = test_quad[i];
            #10;  // Allow propagation.
            $display("Index %0d: %032h   %032h", i, fft_out_phase, fft_out_quad);
        end
        $finish;
    end
endmodule


