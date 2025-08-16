module zero_padding_dual (
    input  wire [63:0] in_phase,   // 64-bit in-phase input
    input  wire [63:0] in_quad,    // 64-bit quadrature input
    output wire [127:0] out_phase, // 128-bit in-phase output after padding
    output wire [127:0] out_quad   // 128-bit quadrature output after padding
);
    assign out_phase = {32'b0, in_phase, 32'b0};
    assign out_quad  = {32'b0, in_quad, 32'b0};
endmodule
