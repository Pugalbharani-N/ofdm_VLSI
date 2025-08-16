module output_module_304to16_tb;
    reg         clk;
    reg         reset;
    reg         valid_in;
    wire        ready_out;
    reg  [303:0] data_in;
    wire [15:0] data_out;
    wire        valid_out;
    wire        done;
    
    integer i, j;
    
    // Instantiate the output module
    output_module_304to16 uut (
        .clk(clk),
        .reset(reset),
        .valid_in(valid_in),
        .ready_out(ready_out),
        .data_in(data_in),
        .data_out(data_out),
        .valid_out(valid_out),
        .done(done)
    );
    
    // Clock generation: 20 ns period.
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    
    // Define an array of 16 test vectors (304-bit each), exactly 76 hex digits.
    reg [303:0] test_vectors [0:15];
    
    initial begin
        // TV0
        test_vectors[0]  = 304'h001400140014000a000a000a000a000a000a000a000a00140014001400140014001400140014;
        // TV1
        test_vectors[1]  = 304'h0014001400140005000500050005000500050005000500140014001400140014001400140014;
        // TV2
        test_vectors[2]  = 304'h0014001400140014001400140014001400140014001400140014001400140014001400140014;
        // TV3
        test_vectors[3]  = 304'h001400140014000f000f000f000f000f000f000f000f00140014001400140014001400140014;
        // TV4
        test_vectors[4]  = 304'h000f000f000f000a000a000a000a000a000a000a000a000f000f000f000f000f000f000f000f;
        // TV5
        test_vectors[5]  = 304'h000f000f000f00050005000500050005000500050005000f000f000f000f000f000f000f000f;
        // TV6
        test_vectors[6]  = 304'h000f000f000f00140014001400140014001400140014000f000f000f000f000f000f000f000f;
        // TV7
        test_vectors[7]  = 304'h000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f;
        // TV8
        test_vectors[8]  = 304'h000a000a000a000a000a000a000a000a000a000a000a000a000a000a000a000a000a000a000a;
        // TV9
        test_vectors[9]  = 304'h000a000a000a00050005000500050005000500050005000a000a000a000a000a000a000a000a;
        // TV10
        test_vectors[10] = 304'h000a000a000a00140014001400140014001400140014000a000a000a000a000a000a000a000a;
        // TV11
        test_vectors[11] = 304'h000a000a000a000f000f000f000f000f000f000f000f000a000a000a000a000a000a000a000a;
        // TV12 (updated)
        test_vectors[12] = 304'h000500050005000a000a000a000a000a000a000a000a00050005000500050005000500050005;
        // TV13 (updated)
        test_vectors[13] = 304'h0005000500050005000500050005000500050005000500050005000500050005000500050005;
        // TV14
        test_vectors[14] = 304'h0005000500050014001400140014001400140014001400050005000500050005000500050005;
        // TV15
        test_vectors[15] = 304'h000500050005000f000f000f000f000f000f000f000f00050005000500050005000500050005;
        
        // Initialize control signals and wait for reset.
        reset = 1;
        valid_in = 0;
        data_in = 304'd0;
        #40;
        reset = 0;
        
        $display("Final 304-bit Outputs Sent in 16-bit Chunks (Table Format):");
        // Loop through all 16 test vectors.
        for (i = 0; i < 16; i = i + 1) begin
            // Wait until module is ready.
            @(posedge clk);
            while (!ready_out)
                @(posedge clk);
            
            // Load test vector and pulse valid_in.
            data_in = test_vectors[i];
            valid_in = 1'b1;
            @(posedge clk);
            valid_in = 1'b0;
            
            // Capture and display the 19 chunks for this test vector.
            for (j = 0; j < 19; j = j + 1) begin
                @(posedge clk);
                if (valid_out)
                    $display("TV%0d  Chunk %2d: %04h", i, j, data_out);
            end
            
            // Wait for 'done' before moving to the next test vector.
            while (!done)
                @(posedge clk);
            $display("-----------------------------------------------");
            #20;
        end
        
        // Let simulation run long enough before finishing.
        #7000;
        $finish;
    end
endmodule

