module inverse_symbol_generator (
    input  wire [63:0] in_data,  // 64-bit input (4 concatenated copies of QAM symbol)
    output wire [15:0] out_data  // 16-bit QAM symbol output
);
    // Extract the most significant 16-bit segment.
    assign out_data = in_data[63:48];
endmodule

