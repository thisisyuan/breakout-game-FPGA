module display_logic(   
                        input start,
                        input clk,
                        input reset_n,
                        input [9:0] hcount,
                        input [9:0] vcount,
                        input [9:0] ball_y,
                        input [9:0] ball_x,
                        input [9:0] ball_y1,
                        input [9:0] ball_x1,
                        input [9:0] ball_y2,
                        input [9:0] ball_x2,
                        input [9:0] left_position,
                        input [9:0] right_position,
                        //input reset_n,
                        //input start,
                        //input [5:0] player_position,
                       // input [3:0] block_num,
                        input [12:0] block_to_del,
                        input vsync,
                        input lose,
                        input win,
                        output reg player_en,
                        output reg [12:0]block_en,
                        output reg [2:0] rgb);
    
    `include "defines.v"
    
    `include "defines.v"
    
    reg [2:0] flash;
    reg [3:0] flash_time;
    reg flash_hold;
    reg [19:0] distance;
    
   
        
    //always @ (hcount, vcount, ball_y, ball_x, distance,left_position, right_position, lose, win, flash)
    always@(posedge clk)
    begin       
        player_en = 0;
        block_en = 0;
        if (hcount > `screen_right || vcount > `screen_bottom) rgb <= `green;
        
        else if (win) rgb <= flash;
        
        //else if (lose) rgb <= `red;
        
        else if (vcount < `bottom_edge && hcount < `left_edge) rgb <= `green;
        
        else if (vcount < `bottom_edge && hcount > `right_edge) rgb <= `green;
        
        else if (vcount < `top_edge ) rgb <= `green;
        
        else if (vcount > `bottom_edge) rgb <= `green;
     
        else if (((hcount - ball_x) * (hcount - ball_x) + (vcount - ball_y) * (vcount - ball_y)) < 16)  rgb <= `white;
        else if (((hcount - ball_x1) * (hcount - ball_x1) + (vcount - ball_y1) * (vcount - ball_y1)) < 16)  rgb <= `white;
        else if (((hcount - ball_x2) * (hcount - ball_x2) + (vcount - ball_y2) * (vcount - ball_y2)) < 16)  rgb <= `white;
        
        /*else if (   vcount > `player_vstart && vcount < (`player_vstart + `player_width ) && 
                    hcount > (player_position << 5) - `player_hlength + `left_edge && 
                    hcount < ((player_position << 5) + `player_hlength + `left_edge) ) 
         begin
               rgb <= `red;
               player_en <= 1;
         end 
         */
         
         else if(vcount >= `player_vstart && vcount <= (`player_vstart + `player_width ) &&
                    hcount >= left_position && hcount <= right_position)
        begin
            rgb <= `red;
            player_en <= 1;
        end
                    
        //else if (vcount > `blocks_vstart && vcount <= `blocks_vend && hcount > `blocks_hstart && hcount <= `blocks_hend)
        //begin
            //block_en <= 1;
            //if ( block_num[2:0] ) rgb <= block_num[2:0];
        else if(vcount > 100 && vcount < 110 && hcount > 100 && hcount < 180 )
        begin
                block_en[0] <= 1; 
                rgb <= `white;
                if(block_to_del[0] == 1)
                begin
                    block_en[0] <= 0;
                    rgb <= `black;
                end
                //if(block_to_del[0] == 1) rgb <= `black;
        end
        
        else if(vcount > 110 && vcount < 190 && hcount > 100 && hcount < 110 )
        begin
                block_en[1] <= 1; 
                rgb <= `white;
                if(block_to_del[1] == 1)
                begin
                    block_en[1] <= 0;
                    rgb <= `black;
                end
                //if(block_to_del[0] == 1) rgb <= `black;
        end
        
         else if(vcount > 190 && vcount < 200 && hcount > 100 && hcount < 180 )
        begin
                block_en[2] <= 1; 
                rgb <= `white;
                if(block_to_del[2] == 1)
                begin
                    block_en[2] <= 0;
                    rgb <= `black;
                end
                //if(block_to_del[0] == 1) rgb <= `black;
        end
        
        else if(vcount > 200 && vcount < 280 && hcount > 170 && hcount < 180 )
        begin
                block_en[3] <= 1; 
                rgb <= `white;
                if(block_to_del[3] == 1)
                begin
                    block_en[3] <= 0;
                    rgb <= `black;
                end
                //if(block_to_del[0] == 1) rgb <= `black;
        end
        
        else if(vcount > 280 && vcount < 290 && hcount > 100 && hcount < 180 )
        begin
                block_en[4] <= 1; 
                rgb <= `white;
                if(block_to_del[4] == 1)
                begin
                    block_en[4] <= 0;
                    rgb <= `black;
                end
                //if(block_to_del[0] == 1) rgb <= `black;
        end
        
        else if(vcount > 100 && vcount < 110 && hcount > 220 && hcount < 300)
        begin
                block_en[5] <= 1; 
                rgb <= `white;
                if(block_to_del[5] == 1)
                begin
                    block_en[5] <= 0;
                    rgb <= `black;
                end
                //if(block_to_del[0] == 1) rgb <= `black;
        end
        
        else if(vcount > 110 && vcount < 190 && hcount > 220 && hcount < 230 )
        begin
                block_en[6] <= 1; 
                rgb <= `white;
                if(block_to_del[6] == 1)
                begin
                    block_en[6] <= 0;
                    rgb <= `black;
                end
                //if(block_to_del[0] == 1) rgb <= `black;
        end
        
        else if(vcount > 190 && vcount < 200 && hcount > 220 && hcount < 300 )
        begin
                block_en[7] <= 1; 
                rgb <= `white;
                if(block_to_del[7] == 1)
                begin
                    block_en[7] <= 0;
                    rgb <= `black;
                end
                //if(block_to_del[0] == 1) rgb <= `black;
        end
        
        else if(vcount > 200 && vcount < 280 && hcount > 220 && hcount < 230 )
        begin
                block_en[8] <= 1; 
                rgb <= `white;
                if(block_to_del[8] == 1)
                begin
                    block_en[8] <= 0;
                    rgb <= `black;
                end
                //if(block_to_del[0] == 1) rgb <= `black;
        end
        
         else if(vcount > 280 && vcount < 290 && hcount > 220 && hcount < 300 )
        begin
                block_en[9] <= 1; 
                rgb <= `white;
                if(block_to_del[9] == 1)
                begin
                    block_en[9] <= 0;
                    rgb <= `black;
                end
                //if(block_to_del[0] == 1) rgb <= `black;
        end
        
        
         else if(vcount > 100 && vcount < 290 && hcount > 340 && hcount < 350 )
        begin
                block_en[10] <= 1; 
                rgb <= `white;
                if(block_to_del[10] == 1)
                begin
                    block_en[10] <= 0;
                    rgb <= `black;
                end
                //if(block_to_del[0] == 1) rgb <= `black;
        end
        
         else if(vcount > 280 && vcount < 290 && hcount > 350 && hcount < 430 )
        begin
                block_en[11] <= 1; 
                rgb <= `white;
                if(block_to_del[11] == 1)
                begin
                    block_en[11] <= 0;
                    rgb <= `black;
                end
                //if(block_to_del[0] == 1) rgb <= `black;
        end
        
        else if(vcount > 100 && vcount < 290 && hcount > 430 && hcount < 440 )
        begin
                block_en[12] <= 1; 
                rgb <= `white;
                if(block_to_del[12] == 1)
                begin
                    block_en[12] <= 0;
                    rgb <= `black;
                end
                //if(block_to_del[0] == 1) rgb <= `black;
        end
        
        
            //else rgb <= block_num[2:0] + 3;
       //end
        //  rgb <= ~|block_num[3:0] ? block_num[2:0] : block_num[2:0] + 3'd3;
        
        else rgb <= `black;
    end
    
    always @ (posedge clk)
    begin
        if (!vsync)
        begin
            if (!flash_hold) flash_time <= flash_time + 1;
        
            flash_hold <= 1;
        end
            
        else
        begin
            flash_hold <= 0;
        end
        
        if (flash_time == 0)
        begin
            flash <= `black;
        end
        
        
        else if (flash_time == 3)
        begin
            if (win) flash <=  `white;
            else if (lose) flash <= `red;
        end
        
        else if (flash_time >= 6)
        begin
            flash_time <= 0;
        end
        
    end

endmodule