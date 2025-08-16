module qam16_demapper(
  input  wire [15:0] in_phase,   // 16-bit input from inverse symbol generator (I)
  input  wire [15:0] quad_phase, // 16-bit input from inverse symbol generator (Q)
  output reg  [3:0]  demapped_bits // 4-bit recovered data
);

  reg [1:0] bits_i;
  reg [1:0] bits_q;

  always @(*) begin
    // Map In-phase component (I)
    case(in_phase)
      16'h0014: bits_i = 2'b00; // 20
      16'h000a: bits_i = 2'b01; // 10
      16'h0028: bits_i = 2'b10; // 40
      16'h001e: bits_i = 2'b11; // 30
      default:  bits_i = 2'b00;
    endcase

    // Map Quad-phase component (Q)
    case(quad_phase)
      16'h0028: bits_q = 2'b00; // 40
      16'h001e: bits_q = 2'b01; // 30
      16'h0014: bits_q = 2'b10; // 20
      16'h000a: bits_q = 2'b11; // 10
      default:  bits_q = 2'b00;
    endcase

    // Combine Q (MSBs) and I (LSBs) to form 4-bit output.
    demapped_bits = {bits_q, bits_i};
  end

endmodule

