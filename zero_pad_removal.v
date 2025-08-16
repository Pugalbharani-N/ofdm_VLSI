module zero_pad_removal (
    input  wire [127:0] in_data,  // 128-bit input word
    output wire [63:0]  out_data  // 64-bit output word
);
    // Keep the middle 64 bits: bits [95:32]
    assign out_data = in_data[95:32];
endmodule


