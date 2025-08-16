module inverse_cyclic_prefix (
    input  wire       clk,
    input  wire       reset,
    input  wire       valid_in,  // from serializer's valid_out
    input  wire [15:0] data_out,  // 16-bit from serializer
    output reg [127:0] out_I,    // top 128 bits
    output reg [127:0] out_Q     // bottom 128 bits
);

    // We expect 19 cycles per symbol:
    //  - The first 16 cycles are the useful data
    //  - The last 3 cycles are the cyclic prefix (ignored)
    reg [4:0]   count;       // counts 0..18
    reg [255:0] symbol_reg;  // holds 16 samples x 16 bits = 256 bits

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count       <= 0;
            symbol_reg  <= 256'd0;
            out_I       <= 128'd0;
            out_Q       <= 128'd0;
        end 
        else if (valid_in) begin
            // For cycles 0..15, store data_in into symbol_reg
            if (count < 16) begin
                // Place data_in into correct portion
                // sample0 => [255:240], sample1 => [239:224], etc.
                symbol_reg[255 - (count * 16) -: 16] <= data_out;
            end

            // If we reach cycle 18 => we've completed a 19-cycle frame
            if (count == 18) begin
                // Now out_I = top 128 bits, out_Q = bottom 128 bits
                out_I <= symbol_reg[255:128];
                out_Q <= symbol_reg[127:0];
                count <= 0; // Ready for next frame
            end 
            else begin
                count <= count + 1;
            end
        end
        else begin
            // valid_in is LOW => do nothing, remain in current count
        end
    end
endmodule



