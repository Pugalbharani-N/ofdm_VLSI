module symbol_generator_dual (
    input  wire [15:0] in_phase,   // 16-bit in-phase input (e.g., 0014)
    input  wire [15:0] quad_phase, // 16-bit quadrature input (e.g., 0028)
    output wire [63:0] out_phase,  // 64-bit in-phase output (e.g., 0014001400140014)
    output wire [63:0] out_quad    // 64-bit quadrature output (e.g., 0028002800280028)
);
    // Replicate the 16-bit inputs four times to form 64-bit outputs.
    assign out_phase = {in_phase, in_phase, in_phase, in_phase};
    assign out_quad  = {quad_phase, quad_phase, quad_phase, quad_phase};
endmodule





