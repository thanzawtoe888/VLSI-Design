module waveform_detection_tb;
    reg clk;               // Clock signal
    reg detect;            // Input detection signal
    wire alarm;            // Alarm LED output
    wire display_a, display_b; // Outputs for displays

    // Instantiate the Design Under Test (DUT)
    waveform_detection_system uut (
        .clk(clk),
        .detect(detect),
        .alarm(alarm),
        .display_a(display_a),
        .display_b(display_b)
    );

    // Generate a clock signal
    always #5 clk = ~clk;

    // Testbench initial block
    initial begin
        // Initialize signals
        clk = 0;
        detect = 0;

        // Enable waveform dumping
        $dumpfile("waveform_detection.vcd");   // Specify the VCD file name
        $dumpvars(0, waveform_detection_tb);   // Dump all variables in the testbench hierarchy

        // Test stimulus based on waveform image
        #10 detect = 1;    // Simulate detection high at counter 76
        #10 detect = 0;    // Detect low at counter 77
        #20 detect = 1;    // Detect high again at counter 78-79
        #20 detect = 0;    // Detect low at counter 80 onwards
        #50 $finish;       // End simulation
    end
endmodule

// DUT: Waveform Detection System
module waveform_detection_system (
    input clk,
    input detect,
    output reg alarm,
    output reg display_a,
    output reg display_b
);
    reg [6:0] counter; // Counter for time intervals

    // Counter logic to track time intervals
    always @(posedge clk) begin
        counter <= counter + 1;
    end

    // Detect logic
    always @(posedge clk) begin
        if (detect) begin
            if (counter == 76 || counter == 78) begin
                alarm <= 1;       // Set alarm on specific detection intervals
                display_a <= 1;   // Activate display_a during detection
            end else begin
                alarm <= 0;
                display_a <= 0;
            end
        end else begin
            display_b <= (counter == 80); // Activate display_b on specific counter
        end
    end
endmodule
