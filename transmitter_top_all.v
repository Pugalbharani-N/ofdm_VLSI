module transmitter_top_all (
    input  wire        clk,
    input  wire        reset,
    // Expose all intermediate outputs:
    output wire [3:0]  bitstream_out,   // From bitstream generator
    output wire [15:0] qam_i,           // QAM Mapper in-phase
    output wire [15:0] qam_q,           // QAM Mapper quadrature
    output wire [63:0] sym_phase,       // Symbol generator in-phase
    output wire [63:0] sym_quad,        // Symbol generator quadrature
    output wire [127:0] pad_phase,      // Zero padding in-phase
    output wire [127:0] pad_quad,       // Zero padding quadrature
    output wire [127:0] ifft_phase,     // IFFT in-phase output
    output wire [127:0] ifft_quad,      // IFFT quadrature output
    output wire [303:0] cp_symbol,      // Cyclic prefix output
    // Serializer outputs
    output wire [15:0] serializer_data_out,
    output wire        serializer_valid_out,
    output wire        serializer_done,
    output wire        serializer_ready
);

    // Internal signals for connecting blocks
    wire [3:0]   bs_data;
    wire [15:0]  qam_i_int, qam_q_int;
    wire [63:0]  sym_phase_int, sym_quad_int;
    wire [127:0] pad_phase_int, pad_quad_int;
    wire [127:0] time_phase, time_quad;
    wire [303:0] cp_symbol_int;

    // Instantiate Bitstream Generator (4-bit generator)
    bitstream_generator bs_gen (
        .clk(clk),
        .reset(reset),
        .data(bs_data)
    );
    assign bitstream_out = bs_data;

    // Instantiate 16-QAM Mapper
    qam16_mapper qam_map (
        .in_data(bs_data),
        .i_out(qam_i_int),
        .q_out(qam_q_int)
    );
    assign qam_i = qam_i_int;
    assign qam_q = qam_q_int;

    // Instantiate Symbol Generator (dual-channel: replicates 16-bit to 64-bit)
    symbol_generator_dual sym_gen (
        .in_phase(qam_i_int),
        .quad_phase(qam_q_int),
        .out_phase(sym_phase_int),
        .out_quad(sym_quad_int)
    );
    assign sym_phase = sym_phase_int;
    assign sym_quad  = sym_quad_int;

    // Instantiate Zero Padding (dual-channel: pads 64-bit inputs to 128-bit)
    zero_padding_dual pad_inst (
        .in_phase(sym_phase_int),
        .in_quad(sym_quad_int),
        .out_phase(pad_phase_int),
        .out_quad(pad_quad_int)
    );
    assign pad_phase = pad_phase_int;
    assign pad_quad  = pad_quad_int;

    // Instantiate Dual IFFT (processes in-phase and quadrature channels separately)
    dual_ifft8 ifft_inst (
        .freq_in_phase(pad_phase_int),
        .freq_in_quad(pad_quad_int),
        .time_out_phase(time_phase),
        .time_out_quad(time_quad)
    );
    assign ifft_phase = time_phase;
    assign ifft_quad  = time_quad;

    // Instantiate Cyclic Prefix Adder
    cyclic_prefix_256 cp_inst (
        .phase(time_phase),
        .quad(time_quad),
        .symbol_out(cp_symbol_int)
    );
    assign cp_symbol = cp_symbol_int;

    // In this example, assume a symbol is always ready (i.e. symbol_valid is high).
    wire symbol_valid = 1'b1;

    // Instantiate the Output Serializer (converts 304-bit symbol to 16-bit chunks)
    output_module_304to16 out_mod (
        .clk(clk),
        .reset(reset),
        .valid_in(symbol_valid),
        .data_in(cp_symbol_int),
        .data_out(serializer_data_out),
        .valid_out(serializer_valid_out),
        .done(serializer_done),
        .ready_out(serializer_ready)
    );

endmodule


