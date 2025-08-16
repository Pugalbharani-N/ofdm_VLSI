module transmitter_top_all_wave_tb;
    // Clock and reset signals
    reg clk;
    reg reset;

    // Wires to capture all outputs from the transmitter
    wire [3:0]  bitstream_out;
    wire [15:0] qam_i, qam_q;
    wire [63:0] sym_phase, sym_quad;
    wire [127:0] pad_phase, pad_quad;
    wire [127:0] ifft_phase, ifft_quad;
    wire [303:0] cp_symbol;
    wire [15:0] serializer_data_out;
    wire        serializer_valid_out;
    wire        serializer_done;
    wire        serializer_ready;
    
    // Instantiate the top-level transmitter module with all signals exposed
    transmitter_top_all uut (
        .clk(clk),
        .reset(reset),
        .bitstream_out(bitstream_out),
        .qam_i(qam_i),
        .qam_q(qam_q),
        .sym_phase(sym_phase),
        .sym_quad(sym_quad),
        .pad_phase(pad_phase),
        .pad_quad(pad_quad),
        .ifft_phase(ifft_phase),
        .ifft_quad(ifft_quad),
        .cp_symbol(cp_symbol),
        .serializer_data_out(serializer_data_out),
        .serializer_valid_out(serializer_valid_out),
        .serializer_done(serializer_done),
        .serializer_ready(serializer_ready)
    );
    
    // Dump all signals to a VCD file for waveform viewing
    initial begin
        $dumpfile("transmitter.vcd");
        // Dump all variables in this testbench hierarchy (level 0)
        $dumpvars(0, transmitter_top_all_wave_tb);
    end

    // Clock generation: 50MHz (20 ns period)
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    
    // Reset generation and simulation control
    initial begin
        reset = 1;
        #30;       // Hold reset for 30 ns
        reset = 0;
        #1000;     // Run simulation long enough to observe several symbol cycles
        $finish;
    end

endmodule

