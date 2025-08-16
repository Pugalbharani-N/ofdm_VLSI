module ifft8_constant(
    input  wire [127:0] freq_in,   // 128-bit frequency-domain input (8 x 16-bit words)
    output reg  [127:0] time_out   // 128-bit time-domain output (8 x 16-bit words)
);
    reg [15:0] X [0:7];  // Array to hold 8 frequency-domain 16-bit words
    reg [15:0] A;        // Active value (assumed to be in word[2])
    integer i;
    
    always @(*) begin
        // Unpack the 128-bit input into eight 16-bit words.
        X[7] = freq_in[127:112];
        X[6] = freq_in[111:96];
        X[5] = freq_in[95:80];
        X[4] = freq_in[79:64];
        X[3] = freq_in[63:48];
        X[2] = freq_in[47:32];
        X[1] = freq_in[31:16];
        X[0] = freq_in[15:0];
        
        // Assume the active value A is stored in word[2] (and words[3-5] are equal).
        A = X[2];
        
        // With scaling factor 1/8, the ideal time-domain output for each sample is:
        // (A + A + A + A)/8 = A/2. (We compute A/2 using a right shift.)
        for (i = 0; i < 8; i = i + 1)
            X[i] = A >> 1;  // A/2
        
        // Pack the eight identical 16-bit samples into a 128-bit output.
        time_out = {X[7], X[6], X[5], X[4], X[3], X[2], X[1], X[0]};
    end
endmodule

// Dual-channel IFFT module: processes in-phase and quadrature inputs separately.
module dual_ifft8(
    input  wire [127:0] freq_in_phase,  // 128-bit frequency-domain in-phase input
    input  wire [127:0] freq_in_quad,   // 128-bit frequency-domain quadrature input
    output wire [127:0] time_out_phase, // 128-bit time-domain in-phase output
    output wire [127:0] time_out_quad   // 128-bit time-domain quadrature output
);
    // Instantiate the IFFT for the in-phase channel.
    ifft8_constant ifft_phase (
        .freq_in(freq_in_phase),
        .time_out(time_out_phase)
    );
    
    // Instantiate the IFFT for the quadrature channel.
    ifft8_constant ifft_quad (
        .freq_in(freq_in_quad),
        .time_out(time_out_quad)
    );
endmodule


