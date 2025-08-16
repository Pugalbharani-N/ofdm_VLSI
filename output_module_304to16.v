module output_module_304to16 (
    input  wire         clk,
    input  wire         reset,
    input  wire         valid_in,    // Indicates new 304-bit data is available
    output reg          ready_out,   // High when module is ready for new data
    input  wire [303:0] data_in,     // 304-bit input data
    output reg  [15:0]  data_out,    // 16-bit output data (one chunk)
    output reg          valid_out,   // High when data_out is valid
    output reg          done         // High for one clock when entire 304 bits have been sent
);

    localparam NUM_CHUNKS = 19; // 304 / 16

    reg [4:0] chunk_index;      // To count 0..18
    reg       sending;          // Indicates we are transmitting a symbol

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            chunk_index <= 5'd0;
            data_out    <= 16'd0;
            valid_out   <= 1'b0;
            done        <= 1'b0;
            sending     <= 1'b0;
            ready_out   <= 1'b1;
        end else begin
            done <= 1'b0;  // default

            if (!sending) begin
                ready_out <= 1'b1;
                valid_out <= 1'b0;
                if (valid_in) begin
                    // Latch new data and start transmission
                    sending     <= 1'b1;
                    chunk_index <= 5'd0;
                    ready_out   <= 1'b0;
                    valid_out   <= 1'b1;
                    data_out    <= data_in[15:0];  // first chunk (bits [15:0])
                end
            end else begin
                // Currently sending a symbol (19 chunks total)
                if (chunk_index == NUM_CHUNKS - 1) begin
                    // Last chunk was sent on the previous cycle
                    sending   <= 1'b0;
                    valid_out <= 1'b0;
                    done      <= 1'b1;
                    ready_out <= 1'b1;
                    chunk_index <= 5'd0;
                end else begin
                    chunk_index <= chunk_index + 5'd1;
                    // For chunk n (0-indexed), output bits [(n+1)*16-1 : n*16]
                    // Use the Verilog bit-slicing [start -: width]
                    data_out <= data_in[((chunk_index + 1)*16) - 1 -: 16];
                    valid_out <= 1'b1;
                end
            end
        end
    end
endmodule

