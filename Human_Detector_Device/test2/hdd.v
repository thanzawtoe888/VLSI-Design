module human_tracking_device (
    input clk,               // Clock signal
    input reset,             // Reset signal
    input human_detected,    // Pulse signal from the human detector
    output reg alarm,        // Alarm LED signal
    output reg [6:0] seg1,   // 7-segment display for units digit
    output reg [6:0] seg2    // 7-segment display for tens digit
);

    // Internal counter to track the number of people
    reg [6:0] counter; // 7-bit counter (0 to 99)

    // 7-segment display encoding (common cathode)
    function [6:0] decode_7segment(input [3:0] digit);
        case (digit)
            4'd0: decode_7segment = 7'b1000000;
            4'd1: decode_7segment = 7'b1111001;
            4'd2: decode_7segment = 7'b0100100;
            4'd3: decode_7segment = 7'b0110000;
            4'd4: decode_7segment = 7'b0011001;
            4'd5: decode_7segment = 7'b0010010;
            4'd6: decode_7segment = 7'b0000010;
            4'd7: decode_7segment = 7'b1111000;
            4'd8: decode_7segment = 7'b0000000;
            4'd9: decode_7segment = 7'b0010000;
            default: decode_7segment = 7'b1111111; // Blank display
        endcase
    endfunction

    // Main logic for counting and alarm
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 7'd0;   // Reset the counter
            alarm <= 1'b0;     // Deactivate the alarm
        end else if (human_detected) begin
            if (counter < 7'd80) begin
                counter <= counter + 1; // Increment the counter
            end else begin
                alarm <= 1'b1; // Activate the alarm when counter exceeds 80
            end
        end
    end

    // Update 7-segment displays
    always @(counter) begin
        seg1 = decode_7segment(counter % 10); // Units digit
        seg2 = decode_7segment(counter / 10); // Tens digit
    end

endmodule
