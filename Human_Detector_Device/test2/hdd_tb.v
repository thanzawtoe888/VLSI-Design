module human_tracking_device_tb;

    // Testbench signals
    reg clk;                // Clock signal
    reg reset;              // Reset signal
    reg human_detected;     // Signal from the human detector
    wire alarm;             // Alarm LED signal
    wire [6:0] seg1;        // 7-segment display for units digit
    wire [6:0] seg2;        // 7-segment display for tens digit

    // Instantiate the DUT (Device Under Test)
    human_tracking_device dut (
        .clk(clk),
        .reset(reset),
        .human_detected(human_detected),
        .alarm(alarm),
        .seg1(seg1),
        .seg2(seg2)
    );

    // Clock generator
    always #5 clk = ~clk; // Generate a 1 kHz clock (10 ns period)

    // Testbench initial block
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;  // Assert reset
        human_detected = 0;

        // Enable waveform dumping
        $dumpfile("human_tracking_device.vcd");  // Specify the VCD file name
        $dumpvars(0, human_tracking_device_tb);  // Dump all variables

        // Test scenario
        #10 reset = 0;  // Deassert reset
        #20 human_detected = 1; #10 human_detected = 0;  // Detect 1 person
        #20 human_detected = 1; #10 human_detected = 0;  // Detect 2nd person
        repeat (80) begin
            #20 human_detected = 1; #10 human_detected = 0;  // Detect up to 80 people
        end
        #20 human_detected = 1; #10 human_detected = 0;  // Detect 81st person, alarm should activate
        #50 $finish;  // End simulation
    end

endmodule
