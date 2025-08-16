module inverse_cyclic_prefix (
    input  wire [303:0] symbol_out, // 304-bit input
    output wire [127:0] I_FFT,      // 128-bit In-phase output
    output wire [127:0] Q_FFT       // 128-bit Quadrature output
);

    // Remove first 48 bits (MSB)
    wire [255:0] useful_data;
    assign useful_data = symbol_out[255:0]; // Keep last 256 bits

    // Split into I_FFT and Q_FFT
    assign I_FFT = useful_data[255:128]; // Upper 128 bits -> I_FFT
    assign Q_FFT = useful_data[127:0];   // Lower 128 bits -> Q_FFT

endmodule
