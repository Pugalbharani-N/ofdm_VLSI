module symbol_generator_dual_tb;

    reg [15:0] in_phase;
    reg [15:0] quad_phase;
    wire [63:0] out_phase;
    wire [63:0] out_quad;
    
    // Instantiate the symbol generator
    symbol_generator_dual uut (
        .in_phase(in_phase),
        .quad_phase(quad_phase),
        .out_phase(out_phase),
        .out_quad(out_quad)
    );
    
    // Arrays to hold test values (matching your mapping table)
    reg [15:0] test_in_phase [0:15];
    reg [15:0] test_quad_phase [0:15];
    integer idx;
    
    initial begin
        // Initialize test vectors according to your mapping:
        // in_data 0: I_out = 0014, Q_out = 0028
        test_in_phase[0]  = 16'h0014;
        test_quad_phase[0]  = 16'h0028;
        
        // in_data 1: I_out = 000A, Q_out = 0028
        test_in_phase[1]  = 16'h000A;
        test_quad_phase[1]  = 16'h0028;
        
        // in_data 2: I_out = 0028, Q_out = 0028
        test_in_phase[2]  = 16'h0028;
        test_quad_phase[2]  = 16'h0028;
        
        // in_data 3: I_out = 001E, Q_out = 0028
        test_in_phase[3]  = 16'h001E;
        test_quad_phase[3]  = 16'h0028;
        
        // in_data 4: I_out = 0014, Q_out = 001E
        test_in_phase[4]  = 16'h0014;
        test_quad_phase[4]  = 16'h001E;
        
        // in_data 5: I_out = 000A, Q_out = 001E
        test_in_phase[5]  = 16'h000A;
        test_quad_phase[5]  = 16'h001E;
        
        // in_data 6: I_out = 0028, Q_out = 001E
        test_in_phase[6]  = 16'h0028;
        test_quad_phase[6]  = 16'h001E;
        
        // in_data 7: I_out = 001E, Q_out = 001E
        test_in_phase[7]  = 16'h001E;
        test_quad_phase[7]  = 16'h001E;
        
        // in_data 8: I_out = 0014, Q_out = 0014
        test_in_phase[8]  = 16'h0014;
        test_quad_phase[8]  = 16'h0014;
        
        // in_data 9: I_out = 000A, Q_out = 0014
        test_in_phase[9]  = 16'h000A;
        test_quad_phase[9]  = 16'h0014;
        
        // in_data 10: I_out = 0028, Q_out = 0014
        test_in_phase[10] = 16'h0028;
        test_quad_phase[10] = 16'h0014;
        
        // in_data 11: I_out = 001E, Q_out = 0014
        test_in_phase[11] = 16'h001E;
        test_quad_phase[11] = 16'h0014;
        
        // in_data 12: I_out = 0014, Q_out = 000A
        test_in_phase[12] = 16'h0014;
        test_quad_phase[12] = 16'h000A;
        
        // in_data 13: I_out = 000A, Q_out = 000A
        test_in_phase[13] = 16'h000A;
        test_quad_phase[13] = 16'h000A;
        
        // in_data 14: I_out = 0028, Q_out = 000A
        test_in_phase[14] = 16'h0028;
        test_quad_phase[14] = 16'h000A;
        
        // in_data 15: I_out = 001E, Q_out = 000A
        test_in_phase[15] = 16'h001E;
        test_quad_phase[15] = 16'h000A;
        
        // Display table header
        $display("Idx\t in_phase\t quad_phase\t out_phase\t\t\t\t out_quad");
        // Iterate through all test cases
        for (idx = 0; idx < 16; idx = idx + 1) begin
            in_phase  = test_in_phase[idx];
            quad_phase = test_quad_phase[idx];
            #10; // Allow propagation
            $display("%0d\t %04h\t\t %04h\t\t %016h\t %016h",
                     idx, in_phase, quad_phase, out_phase, out_quad);
        end
        
        $finish;
    end

endmodule

