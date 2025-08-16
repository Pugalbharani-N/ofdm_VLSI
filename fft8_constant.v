module fft8_constant(
    input  wire [127:0] fft_in,   // 128-bit input
    output reg  [127:0] fft_out   // 128-bit output
);
    reg [15:0] active;
    
    always @(*) begin
        // Extract the active value from word2 (bits [47:32])
        active = fft_in[47:32];
        
        // Build the output: word7, word6, word1, and word0 are zero,
        // words 5,4,3,2 are set to the active value.
        fft_out = {16'h0000, 16'h0000, active, active, active, active, 16'h0000, 16'h0000};
    end
endmodule

// dual_fft8.v
// This module instantiates two fft8_constant modules:
// one for the in-phase channel and one for the quadrature channel.
module dual_fft8(
    input  wire [127:0] fft_in_phase,  // 128-bit in-phase input
    input  wire [127:0] fft_in_quad,   // 128-bit quadrature input
    output wire [127:0] fft_out_phase, // 128-bit in-phase output
    output wire [127:0] fft_out_quad   // 128-bit quadrature output
);
    fft8_constant fft_phase (
        .fft_in(fft_in_phase),
        .fft_out(fft_out_phase)
    );
    
    fft8_constant fft_quad (
        .fft_in(fft_in_quad),
        .fft_out(fft_out_quad)
    );
endmodule


