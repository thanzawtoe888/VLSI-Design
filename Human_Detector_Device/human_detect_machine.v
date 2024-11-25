module human_counter(
    input clk,                 // Clock signal
    input reset,               // Reset signal
    input human_detected,      // Input signal from human detector (pulse)
    output reg [6:0] seg1,     // 7-segment display 1 (units digit)
    output reg [6:0] seg2,     // 7-segment display 2 (tens digit)
    output reg alarm           // Alarm signal
);

// Internal signals
reg [6:0] counter;             // 7-bit counter to store the number of people (max: 127)

// 7-segment display encoding (common anode)
function [6:0] decode_7segment(input [3:0] digit);
    case (digit)
        4'd0: decode_7segment = 7'b0111111;
        4'd1: decode_7segment = 7'b0000110;
        4'd2: decode_7segment = 7'b1011011;
        4'd3: decode_7segment = 7'b1001111;
        4'd4: decode_7segment = 7'b1100110;
        4'd5: decode_7segment = 7'b1101101;
        4'd6: decode_7segment = 7'b1111101;
        4'd7: decode_7segment = 7'b0000111;
        4'd8: decode_7segment = 7'b1111111;
        4'd9: decode_7segment = 7'b1101111;
        default: decode_7segment = 7'b0000000; // Blank display
    endcase
endfunction

// Main logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        counter <= 7'd0;       // Reset counter
        alarm <= 1'b0;         // Reset alarm
    end else if (human_detected) begin
        if (counter < 7'd80) begin
            counter <= counter + 1; // Increment counter
        end else begin
            alarm <= 1'b1;         // Activate alarm when count exceeds 80
        end
    end
end

// Update 7-segment displays
always @(counter) begin
    seg1 = decode_7segment(counter % 10);       // Units digit
    seg2 = decode_7segment(counter / 10);       // Tens digit
end

endmodule
