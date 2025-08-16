module bitstream_generator_tb;

    // Testbench signals
    reg clk;
    reg reset;
    wire [3:0] data;

    // Instantiate the DUT (Device Under Test)
    bitstream_generator uut (
        .clk(clk),
        .reset(reset),
        .data(data)
    );

    // Clock generation (50 MHz, 20 ns period)
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Toggle clock every 10 ns
    end

    // Test sequence
    initial begin
        // Monitor signals
        $monitor("Time = %0t | Reset = %b | Data = %b", $time, reset, data);

        // Initialize and apply reset
        reset = 1;        // Apply reset
        #20;              // Hold reset for 20 ns
        reset = 0;        // Release reset

        #300;             // Run for 300 ns to observe the sequence
        $stop;            // End simulation
    end

endmodule