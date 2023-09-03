module char_multiplexer_display(
    input [3:0] data,
    input clk,
    input load,
    input reset,
    input [1:0] char_position,
    output reg [3:0] column_to_display_count,
    output reg [3:0] line
);

    reg [1:0] chars_to_display [3:0];
    reg [15:0] charmap [3:0];
    reg [1:0] current_character;
    reg [1:0] current_character_column;

    always @(posedge clk) begin
    
      if(reset) begin
            current_character <= 2'b0;
            current_character_column <= 2'b0;
            column_to_display_count <= 4'b0;
            line <= 4'b0;
            charmap[0]  <= 16'b1111_1001_1001_1111;
            charmap[1]  <= 16'b1111_0010_0010_1111;
            charmap[2]  <= 16'b1111_0010_0100_1111;
            charmap[3]  <= 16'b1111_0111_0001_1111;
            charmap[4]  <= 16'b1001_1001_1111_0001;
            charmap[5]  <= 16'b1111_1000_1111_0111;
            charmap[6]  <= 16'b1000_1111_1001_1111;
            charmap[7]  <= 16'b1111_0001_0001_0001;
            charmap[8]  <= 16'b1110_1011_1101_0111;
            charmap[9]  <= 16'b1111_1001_1111_0001;
            charmap[10] <= 16'b1111_1001_1111_1001;
            charmap[11] <= 16'b1100_1010_1101_1010;
            charmap[12] <= 16'b1111_1000_1000_1111;
            charmap[13] <= 16'b1110_1001_1001_1110;
            charmap[14] <= 16'b1111_1110_1000_1111;
            charmap[15] <= 16'b1111_1000_1110_1000;
      end else begin

        if(load) begin
            chars_to_display[char_position] <= data;
        end else begin 

            column_to_display_count <= current_character * 4 + current_character_column;

            line <= {
                charmap[chars_to_display[current_character]][3-current_character_column],
                charmap[chars_to_display[current_character]][7-current_character_column],
                charmap[chars_to_display[current_character]][11-current_character_column],
                charmap[chars_to_display[current_character]][15-current_character_column]
                
            };

            if(current_character_column == 2'b11) begin
                if(current_character == 2'b11) begin
                    current_character <= 2'b0;
                end else begin
                    current_character <= current_character + 2'b1;
                end
                current_character_column <= 2'b0;
            end else begin
                current_character_column <= current_character_column + 2'b1;
            end

        end

      end

    end

endmodule
