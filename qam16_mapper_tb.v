module qam16_mapper_tb;

    reg [3:0] in_data;
    wire [15:0] i_out, q_out;
    
    // Instantiate the QAM16 mapper module
    qam16_mapper uut (
        .in_data(in_data),
        .i_out(i_out),
        .q_out(q_out)
    );
    
    integer i;
    initial begin
        $display("Time\t in_data\t i_out\t q_out");
        // Iterate through all 16 possible values
        for (i = 0; i < 16; i = i + 1) begin
            in_data = i;
            #10;
            $display("%0t\t %b\t %04h\t %04h", $time, in_data, i_out, q_out);
        end
        $finish;
    end

endmodule

