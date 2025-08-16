module bitstream_generator (
    input wire clk,
    input wire reset,
    output reg [3:0] data // Modified for 16-QAM (4-bit data)
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            data <= 4'b0000; // Reset to zero
        else
            data <= data + 1; // Increment sequentially from 0000 to 1111
    end
endmodule

