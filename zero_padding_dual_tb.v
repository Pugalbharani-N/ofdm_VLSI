module zero_padding_dual_tb;

    reg [63:0] in_phase;
    reg [63:0] in_quad;
    wire [127:0] out_phase;
    wire [127:0] out_quad;
    
    // Instantiate the dual zero padding module
    zero_padding_dual uut (
        .in_phase(in_phase),
        .in_quad(in_quad),
        .out_phase(out_phase),
        .out_quad(out_quad)
    );
    
    // Arrays to hold the 64-bit test values (from your table)
    reg [63:0] test_in_phase [0:15];
    reg [63:0] test_in_quad  [0:15];
    integer idx;
    
    initial begin
        // Initialize the test arrays using your table values
        test_in_phase[0]  = 64'h0014001400140014; test_in_quad[0]  = 64'h0028002800280028;
        test_in_phase[1]  = 64'h000A000A000A000A; test_in_quad[1]  = 64'h0028002800280028;
        test_in_phase[2]  = 64'h0028002800280028; test_in_quad[2]  = 64'h0028002800280028;
        test_in_phase[3]  = 64'h001E001E001E001E; test_in_quad[3]  = 64'h0028002800280028;
        test_in_phase[4]  = 64'h0014001400140014; test_in_quad[4]  = 64'h001E001E001E001E;
        test_in_phase[5]  = 64'h000A000A000A000A; test_in_quad[5]  = 64'h001E001E001E001E;
        test_in_phase[6]  = 64'h0028002800280028; test_in_quad[6]  = 64'h001E001E001E001E;
        test_in_phase[7]  = 64'h001E001E001E001E; test_in_quad[7]  = 64'h001E001E001E001E;
        test_in_phase[8]  = 64'h0014001400140014; test_in_quad[8]  = 64'h0014001400140014;
        test_in_phase[9]  = 64'h000A000A000A000A; test_in_quad[9]  = 64'h0014001400140014;
        test_in_phase[10] = 64'h0028002800280028; test_in_quad[10] = 64'h0014001400140014;
        test_in_phase[11] = 64'h001E001E001E001E; test_in_quad[11] = 64'h0014001400140014;
        test_in_phase[12] = 64'h0014001400140014; test_in_quad[12] = 64'h000A000A000A000A;
        test_in_phase[13] = 64'h000A000A000A000A; test_in_quad[13] = 64'h000A000A000A000A;
        test_in_phase[14] = 64'h0028002800280028; test_in_quad[14] = 64'h000A000A000A000A;
        test_in_phase[15] = 64'h001E001E001E001E; test_in_quad[15] = 64'h000A000A000A000A;
        
        // Loop through each test case and display only the final padded outputs.
        for (idx = 0; idx < 16; idx = idx + 1) begin
            in_phase = test_in_phase[idx];
            in_quad  = test_in_quad[idx];
            #10; // wait for propagation
            $display("%032h   %032h", out_phase, out_quad);
        end
        
        $finish;
    end

endmodule

