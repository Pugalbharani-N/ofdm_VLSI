module tb_zero_pad_removal;

    // Declare arrays to store all 16 values for In-phase and Quad-phase inputs.
    reg [127:0] in_phase_array [0:15];
    reg [127:0] quad_phase_array [0:15];
    
    // Declare registers to drive the DUT inputs.
    reg [127:0] in_data_inphase;
    reg [127:0] in_data_quad;
    
    // Wires to capture the outputs.
    wire [63:0] out_inphase;
    wire [63:0] out_quad;

    // Instantiate the DUT for In-phase data.
    zero_pad_removal uut_in (
        .in_data(in_data_inphase),
        .out_data(out_inphase)
    );

    // Instantiate the DUT for Quad-phase data.
    zero_pad_removal uut_quad (
        .in_data(in_data_quad),
        .out_data(out_quad)
    );

    integer i; // loop index

    initial begin
        // Initialize the In-phase input array (128-bit values)
        in_phase_array[0]  = 128'h00000000001400140014001400000000;
        in_phase_array[1]  = 128'h00000000000a000a000a000a00000000;
        in_phase_array[2]  = 128'h00000000002800280028002800000000;
        in_phase_array[3]  = 128'h00000000001e001e001e001e00000000;
        in_phase_array[4]  = 128'h00000000001400140014001400000000;
        in_phase_array[5]  = 128'h00000000000a000a000a000a00000000;
        in_phase_array[6]  = 128'h00000000002800280028002800000000;
        in_phase_array[7]  = 128'h00000000001e001e001e001e00000000;
        in_phase_array[8]  = 128'h00000000001400140014001400000000;
        in_phase_array[9]  = 128'h00000000000a000a000a000a00000000;
        in_phase_array[10] = 128'h00000000002800280028002800000000;
        in_phase_array[11] = 128'h00000000001e001e001e001e00000000;
        in_phase_array[12] = 128'h00000000001400140014001400000000;
        in_phase_array[13] = 128'h00000000000a000a000a000a00000000;
        in_phase_array[14] = 128'h00000000002800280028002800000000;
        in_phase_array[15] = 128'h00000000001e001e001e001e00000000;

        // Initialize the Quad-phase input array (128-bit values)
        quad_phase_array[0]  = 128'h00000000002800280028002800000000;
        quad_phase_array[1]  = 128'h00000000002800280028002800000000;
        quad_phase_array[2]  = 128'h00000000002800280028002800000000;
        quad_phase_array[3]  = 128'h00000000002800280028002800000000;
        quad_phase_array[4]  = 128'h00000000001e001e001e001e00000000;
        quad_phase_array[5]  = 128'h00000000001e001e001e001e00000000;
        quad_phase_array[6]  = 128'h00000000001e001e001e001e00000000;
        quad_phase_array[7]  = 128'h00000000001e001e001e001e00000000;
        quad_phase_array[8]  = 128'h00000000001400140014001400000000;
        quad_phase_array[9]  = 128'h00000000001400140014001400000000;
        quad_phase_array[10] = 128'h00000000001400140014001400000000;
        quad_phase_array[11] = 128'h00000000001400140014001400000000;
        quad_phase_array[12] = 128'h00000000000a000a000a000a00000000;
        quad_phase_array[13] = 128'h00000000000a000a000a000a00000000;
        quad_phase_array[14] = 128'h00000000000a000a000a000a00000000;
        quad_phase_array[15] = 128'h00000000000a000a000a000a00000000;

        // Display header for clarity.
        $display("Index\tFFT_Out_In (128-bit)\t\t\tFFT_Out_In (64-bit)\t\tFFT_Out_Quad (128-bit)\t\t\tFFT_Out_Quad (64-bit)");

        // Loop through each index, assign inputs, wait for propagation, and display results.
        for (i = 0; i < 16; i = i + 1) begin
            in_data_inphase = in_phase_array[i];
            in_data_quad    = quad_phase_array[i];
            #10; // wait for outputs to update
            $display("%0d\t%h\t%h\t%h\t%h", i, in_data_inphase, out_inphase, in_data_quad, out_quad);
        end

        $finish;
    end

endmodule

