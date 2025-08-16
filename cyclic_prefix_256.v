module cyclic_prefix_256(
    input  wire [127:0] phase,      // 128-bit In-phase input
    input  wire [127:0] quad,       // 128-bit Quadrature input
    output wire [303:0] symbol_out  // 304-bit output
);
    // Concatenate the two 128-bit inputs into a 256-bit word.
    // We assume the ordering: phase forms the MSB and quad forms the LSB.
    wire [255:0] symbol_in = {phase, quad};
    
    // Copy the last 48 bits (i.e. the least-significant 48 bits) from symbol_in
    // and prepend them to symbol_in. This yields a final width of 48+256 = 304 bits.
    assign symbol_out = { symbol_in[47:0], symbol_in };
endmodule

