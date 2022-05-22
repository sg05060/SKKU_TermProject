module Display_module(
    input clock_100Mhz, // 100 Mhz clock source on Basys 3 FPGA
    input reset, // reset

    input reg_en,
    input [7:0] c11_sa,
    input [7:0] c12_sa,
    input [7:0] c21_sa,
    input [7:0] c22_sa,
    input [7:0] c11_custom,
    input [7:0] c12_custom,
    input [7:0] c21_custom,
    input [7:0] c22_custom,

    output is_done_o,
    output reg [3:0] Anode_Activate, // anode signals of the 7-segment LED display
    output reg [6:0] LED_out// cathode patterns of the 7-segment LED display
    );
    reg [3:0] sel;
    reg [26:0] one_second_counter; // counter for generating 1 second clock enable
    wire one_second_enable;// one second enable for counting numbers
    reg [15:0] displayed_number [0:7]; // counting number to be displayed
    reg [3:0] LED_BCD;
    reg [19:0] refresh_counter; // 20-bit for creating 10.5ms refresh period or 380Hz refresh rate
             // the first 2 MSB bits for creating 4 LED-activating signals with 2.6ms digit period
    wire [1:0] LED_activating_counter; 
                 // count     0    ->  1  ->  2  ->  3
              // activates    LED1    LED2   LED3   LED4
             // and repeat
    always @(posedge clock_100Mhz or posedge reset)
    begin
        if(reset==1)
            one_second_counter <= 0;
        else begin
            if(one_second_counter>=99999999)
            //if(one_second_counter>=10)  
                one_second_counter <= 0;
            else
                one_second_counter <= one_second_counter + 1;
        end
    end 
    assign one_second_enable = (one_second_counter==99999999)?1:0;
    //assign one_second_enable = (one_second_counter==10)?1:0;
    always @(posedge clock_100Mhz or posedge reset)
    begin
        if(reset==1) begin
            displayed_number[0] <= 16'b0;
            displayed_number[1] <= 16'b0;
            displayed_number[2] <= 16'b0;
            displayed_number[3] <= 16'b0;
            displayed_number[4] <= 16'b0;
            displayed_number[5] <= 16'b0;
            displayed_number[6] <= 16'b0;
            displayed_number[7] <= 16'b0;
        end
        else if(reg_en == 1'b1) begin
            displayed_number[0] <= {8'b0,c11_sa};
            displayed_number[1] <= {8'b0,c12_sa};
            displayed_number[2] <= {8'b0,c21_sa};
            displayed_number[3] <= {8'b0,c22_sa};
            displayed_number[4] <= {8'b0,c11_custom};
            displayed_number[5] <= {8'b0,c12_custom};
            displayed_number[6] <= {8'b0,c21_custom};
            displayed_number[7] <= {8'b0,c22_custom};
        end
    end

    always @(posedge clock_100Mhz or posedge reset)
    begin
        if(reset==1)
            sel <= 4'b0;
        else if(one_second_enable==1) //&& en == 1'b1)
            sel <= sel + 1;
    end
    assign is_done_o = (sel == 4'b1000); //&& en;

    always @(posedge clock_100Mhz or posedge reset)
    begin 
        if(reset==1)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end 
    assign LED_activating_counter = refresh_counter[19:18];
    //assign LED_activating_counter = refresh_counter[1:0];
    // anode activating signals for 4 LEDs, digit period of 2.6ms
    // decoder to generate anode signals 
    always @(*)
    begin
        case(LED_activating_counter)
        2'b00: begin
            Anode_Activate = 4'b0111; 
            // activate LED1 and Deactivate LED2, LED3, LED4
            LED_BCD = displayed_number[sel[2:0]]/1000;
            // the first digit of the 16-bit number
            end 
        2'b01: begin 
            Anode_Activate = 4'b1011; 
            // activate LED2 and Deactivate LED1, LED3, LED4
            LED_BCD = (displayed_number[sel[2:0]] % 1000)/100;
            // the second digit of the 16-bit number
            end
        2'b10: begin 
            Anode_Activate = 4'b1101; 
            // activate LED3 and Deactivate LED2, LED1, LED4 
            LED_BCD = ((displayed_number[sel[2:0]] % 1000)%100)/10;
            // the third digit of the 16-bit number
                end
        2'b11: begin
            Anode_Activate = 4'b1110; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            LED_BCD = ((displayed_number[sel[2:0]] % 1000)%100)%10;
            // the fourth digit of the 16-bit number    
            end
        endcase
    end
    // Cathode patterns of the 7-segment LED display 
    always @(*)
    begin
        /*
        case(LED_BCD)
        4'b0000: LED_out = 7'b0111111; // "0"     
        4'b0001: LED_out = 7'b0000110; // "1" 
        4'b0010: LED_out = 7'b1011011; // "2" 
        4'b0011: LED_out = 7'b1001111; // "3" 
        4'b0100: LED_out = 7'b1100110; // "4" 
        4'b0101: LED_out = 7'b1101101; // "5" 
        4'b0110: LED_out = 7'b1111101; // "6" 
        4'b0111: LED_out = 7'b0100111; // "7" 
        4'b1000: LED_out = 7'b1111111; // "8"     
        4'b1001: LED_out = 7'b1101111; // "9" 
        default: LED_out = 7'b0111111; // "0"
        endcase
        */
        case(LED_BCD)
        4'b0000: LED_out = 7'b0000001; // "0"  
        4'b0001: LED_out = 7'b1001111; // "1" 
        4'b0010: LED_out = 7'b0010010; // "2" 
        4'b0011: LED_out = 7'b0000110; // "3" 
        4'b0100: LED_out = 7'b1001100; // "4" 
        4'b0101: LED_out = 7'b0100100; // "5" 
        4'b0110: LED_out = 7'b0100000; // "6" 
        4'b0111: LED_out = 7'b0001111; // "7" 
        4'b1000: LED_out = 7'b0000000; // "8"  
        4'b1001: LED_out = 7'b0000100; // "9" 
        default: LED_out = 7'b0000001; // "0"
        endcase
    end
endmodule