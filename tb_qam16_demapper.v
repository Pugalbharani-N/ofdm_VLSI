`timescale 1ns/1ps
module tb_qam16_demapper;

  // Arrays to hold the 16-bit inputs for In-phase and Quad-phase.
  reg [15:0] in_phase_array [0:15];
  reg [15:0] quad_phase_array [0:15];

  // Registers for driving the module inputs.
  reg [15:0] in_phase_data;
  reg [15:0] quad_phase_data;

  // Wire to capture the 4-bit output.
  wire [3:0] demapped_bits;

  // Instantiate the demapper module.
  qam16_demapper uut (
    .in_phase(in_phase_data),
    .quad_phase(quad_phase_data),
    .demapped_bits(demapped_bits)
  );

  integer i;

  initial begin
    // Initialize the In-phase array (from your CSV table)
    in_phase_array[0]  = 16'h0014;
    in_phase_array[1]  = 16'h000a;
    in_phase_array[2]  = 16'h0028;
    in_phase_array[3]  = 16'h001e;
    in_phase_array[4]  = 16'h0014;
    in_phase_array[5]  = 16'h000a;
    in_phase_array[6]  = 16'h0028;
    in_phase_array[7]  = 16'h001e;
    in_phase_array[8]  = 16'h0014;
    in_phase_array[9]  = 16'h000a;
    in_phase_array[10] = 16'h0028;
    in_phase_array[11] = 16'h001e;
    in_phase_array[12] = 16'h0014;
    in_phase_array[13] = 16'h000a;
    in_phase_array[14] = 16'h0028;
    in_phase_array[15] = 16'h001e;

    // Initialize the Quad-phase array (from your CSV table)
    quad_phase_array[0]  = 16'h0028;
    quad_phase_array[1]  = 16'h0028;
    quad_phase_array[2]  = 16'h0028;
    quad_phase_array[3]  = 16'h0028;
    quad_phase_array[4]  = 16'h001e;
    quad_phase_array[5]  = 16'h001e;
    quad_phase_array[6]  = 16'h001e;
    quad_phase_array[7]  = 16'h001e;
    quad_phase_array[8]  = 16'h0014;
    quad_phase_array[9]  = 16'h0014;
    quad_phase_array[10] = 16'h0014;
    quad_phase_array[11] = 16'h0014;
    quad_phase_array[12] = 16'h000a;
    quad_phase_array[13] = 16'h000a;
    quad_phase_array[14] = 16'h000a;
    quad_phase_array[15] = 16'h000a;

    // Display header
    $display("Index\tIn-phase\tQuad-phase\tdemapped_bits");
    // Loop through all 16 indices.
    for (i = 0; i < 16; i = i + 1) begin
      in_phase_data  = in_phase_array[i];
      quad_phase_data = quad_phase_array[i];
      #10; // allow time for combinatorial logic to settle
      $display("%0d\t%h\t\t%h\t\t%04b", i, in_phase_data, quad_phase_data, demapped_bits);
    end

    $finish;
  end

endmodule

