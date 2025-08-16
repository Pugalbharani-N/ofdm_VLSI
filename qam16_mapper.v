module qam16_mapper (
    input  wire [3:0] in_data,
    output reg  [15:0] i_out,  // In-phase component as a 16-bit value
    output reg  [15:0] q_out   // Quadrature component as a 16-bit value
);

    always @(*) begin
        case (in_data)
            4'b0000: begin
                i_out = 16'h0014; // 20 decimal → 0014
                q_out = 16'h0028; // 40 decimal → 0028
            end
            4'b0001: begin
                i_out = 16'h000A; // 10 decimal → 000A
                q_out = 16'h0028;
            end
            4'b0010: begin
                i_out = 16'h0028;
                q_out = 16'h0028;
            end
            4'b0011: begin
                i_out = 16'h001E; // 30 decimal → 001E
                q_out = 16'h0028;
            end
            4'b0100: begin
                i_out = 16'h0014;
                q_out = 16'h001E;
            end
            4'b0101: begin
                i_out = 16'h000A;
                q_out = 16'h001E;
            end
            4'b0110: begin
                i_out = 16'h0028;
                q_out = 16'h001E;
            end
            4'b0111: begin
                i_out = 16'h001E;
                q_out = 16'h001E;
            end
            4'b1000: begin
                i_out = 16'h0014;
                q_out = 16'h0014;
            end
            4'b1001: begin
                i_out = 16'h000A;
                q_out = 16'h0014;
            end
            4'b1010: begin
                i_out = 16'h0028;
                q_out = 16'h0014;
            end
            4'b1011: begin
                i_out = 16'h001E;
                q_out = 16'h0014;
            end
            4'b1100: begin
                i_out = 16'h0014;
                q_out = 16'h000A;
            end
            4'b1101: begin
                i_out = 16'h000A;
                q_out = 16'h000A;
            end
            4'b1110: begin
                i_out = 16'h0028;
                q_out = 16'h000A;
            end
            4'b1111: begin
                i_out = 16'h001E;
                q_out = 16'h000A;
            end
            default: begin
                i_out = 16'h0000;
                q_out = 16'h0000;
            end
        endcase
    end

endmodule


