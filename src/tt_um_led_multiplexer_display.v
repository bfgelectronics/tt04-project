`default_nettype none

module tt_um_led_multiplexer_display #( parameter MAX_COUNT = 24'd10_000_000 ) (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    wire reset = ! rst_n;
   
    wire [4:0] input_data = ui_in[3:0];
    wire [1:0] input_char_position = ui_in[5:4];
    wire input_load = ui_in[6];
    
    wire [3:0] out_column_to_display_count = uo_out[3:0];
    wire [3:0] line = uo_out[7:4];
   
    char_multiplexer_display char_multiplexer_display(
    .data(input_data),
    .clk(clk),
    .load(input_load),
    .reset(reset),
    .char_position(input_char_position),
    .column_to_display_count(out_column_to_display_count),
    .line(line)
    );
    

endmodule
