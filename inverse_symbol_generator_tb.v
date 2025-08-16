`timescale 1ns/1ps
module tb_inverse_symbol_generator;

    // Arrays holding the 64-bit inputs for In-phase and Quad-phase data.
    reg [63:0] in_phase_array [0:15];
    reg [63:0] quad_phase_array [0:15];
    
    // Registers to drive the module inputs.
    reg [63:0] in_data_inphase;
    reg [63:0] in_data_quad;
    
    // Wires to capture the 16-bit outputs.
    wire [15:0] out_inphase;
    wire [15:0] out_quad;
    
    // Instantiate the inverse symbol generator for In-phase.
    inverse_symbol_generator uut_in (
        .in_data(in_data_inphase),
        .out_data(out_inphase)
    );
    
    // Instantiate the inverse symbol generator for Quad-phase.
    inverse_symbol_generator uut_quad (
        .in_data(in_data_quad),
        .out_data(out_quad)
    );
    
    integer i;  // Loop index
    
    initial begin
        // Initialize the In-phase array (from CSV table)
        in_phase_array[0]  = 64'h0014001400140014;
        in_phase_array[1]  = 64'h000a000a000a000a;
        in_phase_array[2]  = 64'h0028002800280028;
        in_phase_array[3]  = 64'h001e001e001e001e;
        in_phase_array[4]  = 64'h0014001400140014;
        in_phase_array[5]  = 64'h000a000a000a000a;
        in_phase_array[6]  = 64'h0028002800280028;
        in_phase_array[7]  = 64'h001e001e001e001e;
        in_phase_array[8]  = 64'h0014001400140014;
        in_phase_array[9]  = 64'h000a000a000a000a;
        in_phase_array[10] = 64'h0028002800280028;
        in_phase_array[11] = 64'h001e001e001e001e;
        in_phase_array[12] = 64'h0014001400140014;
        in_phase_array[13] = 64'h000a000a000a000a;
        in_phase_array[14] = 64'h0028002800280028;
        in_phase_array[15] = 64'h001e001e001e001e;
        
        // Initialize the Quad-phase array (from CSV table)
        quad_phase_array[0]  = 64'h0028002800280028;
        quad_phase_array[1]  = 64'h0028002800280028;
        quad_phase_array[2]  = 64'h0028002800280028;
        quad_phase_array[3]  = 64'h0028002800280028;
        quad_phase_array[4]  = 64'h001e001e001e001e;
        quad_phase_array[5]  = 64'h001e001e001e001e;
        quad_phase_array[6]  = 64'h001e001e001e001e;
        quad_phase_array[7]  = 64'h001e001e001e001e;
        quad_phase_array[8]  = 64'h0014001400140014;
        quad_phase_array[9]  = 64'h0014001400140014;
        quad_phase_array[10] = 64'h0014001400140014;
        quad_phase_array[11] = 64'h0014001400140014;
        quad_phase_array[12] = 64'h000a000a000a000a;
        quad_phase_array[13] = 64'h000a000a000a000a;
        quad_phase_array[14] = 64'h000a000a000a000a;
        quad_phase_array[15] = 64'h000a000a000a000a;
        
        // Display header for the outputs.
        $display("Index\tFFT_Out_In (16-bit)\tFFT_Out_Quad (16-bit)");
        
        // Loop through each index, drive the inputs, and display the outputs.
        for (i = 0; i < 16; i = i + 1) begin
            in_data_inphase = in_phase_array[i];
            in_data_quad    = quad_phase_array[i];
            #10; // Wait for outputs to update
            $display("%0d\t%h\t\t\t%h", i, out_inphase, out_quad);
        end
        
        $finish;
    end

endmodule

