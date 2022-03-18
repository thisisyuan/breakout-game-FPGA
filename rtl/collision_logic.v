module collision_logic(
                        input clk,
                        input reset_n,
                        input [9:0] vcount,
                        input [9:0] hcount,
                        input [9:0] ball_x,
                        input [9:0] ball_y,
                         input [9:0] ball_x1,
                        input [9:0] ball_y1,
                         input [9:0] ball_x2,
                        input [9:0] ball_y2,
                        input [9:0] left_position,
                        input [9:0] right_position,
                        input vsync,
                        input player_en,
                        input [12:0] block_en,
                        output reg win,
                        output reg lose,
                       // output wire [3:0] block_num,
                        output reg h_collision1,
                        output reg v_collision1,
                        output reg h_collision2,
                        output reg v_collision2,
                        output reg h_collision3,
                        output reg v_collision3,
                        output reg [4:0]collision_cnt,
                        output reg [12:0] block_to_del
                         );
                        
                        




        
    
//                             |========||========||========||========| 
//                        |========||========||========||========||========|
//                   |========||========||========||========||========||========|
//15 blocks 
//90 pixels wide = 540 wide along bottom rom
//10 pixels high... 30 pixels top to bottom
//start at (100,320)

//should implement as a dual-port ram
//each location in ram is a 8 x 8 block the value is the block number. 
//a lookup table then maps block number to color
// 64 locations x 16 locations
// 512 pixls x 128 pixels
    `include "defines.v"
    //reg block_clr;
    //wire [9:0] block_addr_r;
    //reg [9:0] block_addr_wr;
    //reg [14:0] block_to_del;
    reg [12:0] block_to_del1;
    reg [12:0] block_to_del2;
    reg [12:0] block_to_del3;
    reg[4:0] init=0;
    //reg [4:0] num_blocks = 13;
    //reg [9:0] block_addr;
    
    //reg checked;
   // reg [1:0] hold;
    
   // wire [9:0] x_addr;
    //wire [9:0] y_addr;    
    //assign x_addr = hcount - `blocks_hstart;
    //assign y_addr = `blocks_vend - vcount;
    
    //assign block_addr_r = {y_addr[6:3],x_addr[8:3]};


   /* block_positions block_positions_inst(   .clock(pxl_clk),
                                            .addressstall_a(1'b0),
                                            .data(4'b0000),
                                            .address(block_addr),
                                            .wren(block_clr),
                                            .q(block_num)  );
  
    always @ (posedge pxl_clk)
    begin
        if (vsync)  block_addr <= block_addr_r;
        else    block_addr <= block_addr_wr;
    
    end
    */
   // always @ (vcount,hcount,left_position,right_position,reset_n,win,lose,vsync,player_en,v_collision2,h_collision2,ball_x1,ball_y1,block_en,collision_cnt,block_to_del1)
    always@(posedge clk or negedge reset_n)
    begin
           
        if (!reset_n)
        begin
            //block_addr_wr <= 0;
            //checked <= 1;
            //block_clr <= 0;
            block_to_del1 <= 0;
            //v_collision <= 0;
            //h_collision <= 0;
            //hold <= 0;
          
            //lose <= 0;
            
            h_collision2 <= 0;
            v_collision2 <= 0;
            
           
        end
        
        else if (vsync)
        begin
            //block_clr <= 0;
           if (player_en) 
            begin   
                
                //else
                //       v_collision1 <= 0;      
             
                if (ball_x1 >= left_position &&  ball_x1 <= right_position
                    && ball_y1 + 3>= `player_vstart/*ball_y-3 <= vcount &&ball_y + 3 >= vcount*/) 
                        v_collision2 <= 1;
                //else
                  //      v_collision2 <= 0;     
             
             
                 
                  else
                 
                     
                     v_collision2 <= 0;
                     
                 
             end

else if (block_en[0])
                           begin
                                   if (ball_x1 == hcount && ball_y1 - 3 <= vcount && ball_y1+ 3 >= vcount)                            
                                   begin
                                       v_collision2 <= 1;
                                       block_to_del1[0]<=1;
              //                         num_blocks <= num_blocks - 1;
            //                           if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y1 == vcount && ball_x1 - 3 <= hcount && ball_x1 + 3 >= hcount)
                                   begin
                                       h_collision2 <= 1;
                                       block_to_del1[0]<=1;
                //                       num_blocks <= num_blocks - 1;
                     //                  if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision2 <=0;
                                        v_collision2 <= 0;
                                   end
                          end
    
    else if (block_en[1])
                           begin
                                   if (ball_x1 == hcount && ball_y1 - 3 <= vcount && ball_y1+ 3 >= vcount)                            
                                   begin
                                       v_collision2 <= 1;
                                       block_to_del1[1]<=1;
                  //                     num_blocks <= num_blocks - 1;
                 //                      if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y1 == vcount && ball_x1 - 3 <= hcount && ball_x1 + 3 >= hcount)
                                   begin
                                       h_collision2 <= 1;
                                       block_to_del1[1]<=1;
                  //                     num_blocks <= num_blocks - 1;
                  //                     if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision2 <=0;
                                        v_collision2 <= 0;
                                   end
                          end
                          
else if (block_en[2])
                           begin
                                   if (ball_x1 == hcount && ball_y1 - 3 <= vcount && ball_y1+ 3 >= vcount)                            
                                   begin
                                       v_collision2 <= 1;
                                       block_to_del1[2]<=1;
                    //                   num_blocks <= num_blocks - 1;
                   //                    if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y1 == vcount && ball_x1 - 3 <= hcount && ball_x1 + 3 >= hcount)
                                   begin
                                       h_collision2 <= 1;
                                       block_to_del1[2]<=1;
                 //                      num_blocks <= num_blocks - 1;
                //                       if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision2 <=0;
                                        v_collision2 <= 0;
                                   end
                          end
                          
else if (block_en[3])
                           begin
                                   if (ball_x1 == hcount && ball_y1 - 3 <= vcount && ball_y1+ 3 >= vcount)                            
                                   begin
                                       v_collision2 <= 1;
                                       block_to_del1[3]<=1;
               //                        num_blocks <= num_blocks - 1;
                //                       if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y1 == vcount && ball_x1 - 3 <= hcount && ball_x1 + 3 >= hcount)
                                   begin
                                       h_collision2 <= 1;
                                       block_to_del1[3]<=1;
              //                         num_blocks <= num_blocks - 1;
             //                          if (num_blocks == 1) win <= 1;
                                   end
                                   
                                   else
                                   begin
                                        h_collision2 <=0;
                                        v_collision2 <= 0;
                                   end
                          end
                          
  else if (block_en[4])
                           begin
                                   if (ball_x1 == hcount && ball_y1 - 3 <= vcount && ball_y1+ 3 >= vcount)                            
                                   begin
                                       v_collision2 <= 1;
                                       block_to_del1[4]<=1;
                     //                  num_blocks <= num_blocks - 1;
                      //                 if (num_blocks == 1) win <= 1;
                                  end                                
                                                                                
                                   else if (ball_y1 == vcount && ball_x1 - 3 <= hcount && ball_x1 + 3 >= hcount)
                                   begin
                                       h_collision2 <= 1;
                                       block_to_del1[4]<=1;
                          //             num_blocks <= num_blocks - 1;
                          //             if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision2 <=0;
                                        v_collision2 <= 0;
                                   end
                          end
       
 else if (block_en[5])
                           begin
                                   if (ball_x1 == hcount && ball_y1 - 3 <= vcount && ball_y1+ 3 >= vcount)                            
                                   begin
                                       v_collision2 <= 1;
                                       block_to_del1[5]<=1;
                       //                num_blocks <= num_blocks - 1;
                      //                 if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y1 == vcount && ball_x1 - 3 <= hcount && ball_x1 + 3 >= hcount)
                                   begin
                                       h_collision2 <= 1;
                                       block_to_del1[5]<=1;
                         //              num_blocks <= num_blocks - 1;
                         //              if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision2 <=0;
                                        v_collision2 <= 0;
                                   end
                          end
                          
 else if (block_en[6])
                           begin
                                   if (ball_x1 == hcount && ball_y1 - 3 <= vcount && ball_y1+ 3 >= vcount)                            
                                   begin
                                       v_collision2 <= 1;
                                       block_to_del1[6]<=1;
                  //                     num_blocks <= num_blocks - 1;
               //                        if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y1 == vcount && ball_x1 - 3 <= hcount && ball_x1 + 3 >= hcount)
                                   begin
                                       h_collision2 <= 1;
                                       block_to_del1[6]<=1;
               //                        num_blocks <= num_blocks - 1;
               //                        if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision2 <=0;
                                        v_collision2 <= 0;
                                   end
                          end
    
else if (block_en[7])
                           begin
                                   if (ball_x1 == hcount && ball_y1 - 3 <= vcount && ball_y1+ 3 >= vcount)                            
                                   begin
                                       v_collision2 <= 1;
                                       block_to_del1[7]<=1;
                     //                  num_blocks <= num_blocks - 1;
                     //                  if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y1 == vcount && ball_x1 - 3 <= hcount && ball_x1 + 3 >= hcount)
                                   begin
                                       h_collision2 <= 1;
                                       block_to_del1[7]<=1;
                  //                     num_blocks <= num_blocks - 1;
                  //                     if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision2 <=0;
                                        v_collision2 <= 0;
                                   end
                          end
                          
 else if (block_en[8])
                           begin
                                   if (ball_x1 == hcount && ball_y1 - 3 <= vcount && ball_y1+ 3 >= vcount)                            
                                   begin
                                       v_collision2 <= 1;
                                       block_to_del1[8]<=1;
              //                         num_blocks <= num_blocks - 1;
              //                         if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y1 == vcount && ball_x1 - 3 <= hcount && ball_x1 + 3 >= hcount)
                                   begin
                                       h_collision2 <= 1;
                                       block_to_del1[8]<=1;
                 //                      num_blocks <= num_blocks - 1;
                     //                  if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision2 <=0;
                                        v_collision2 <= 0;
                                   end
                          end
                          
 else if (block_en[9])
                           begin
                                   if (ball_x1 == hcount && ball_y1 - 3 <= vcount && ball_y1+ 3 >= vcount)                            
                                   begin
                                       v_collision2 <= 1;
                                       block_to_del1[9]<=1;
                   //                    num_blocks <= num_blocks - 1;
                   //                    if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y1 == vcount && ball_x1 - 3 <= hcount && ball_x1 + 3 >= hcount)
                                   begin
                                       h_collision2 <= 1;
                                       block_to_del1[9]<=1;
                 //                      num_blocks <= num_blocks - 1;
               //                        if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision2 <=0;
                                        v_collision2 <= 0;
                                   end
                          end
     
else if (block_en[10])
                           begin
                                   if (ball_x1 == hcount && ball_y1 - 3 <= vcount && ball_y1+ 3 >= vcount)                            
                                   begin
                                       v_collision2 <= 1;
                                       block_to_del1[10]<=1;
                  //                     num_blocks <= num_blocks - 1;
                     //                  if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y1 == vcount && ball_x1 - 3 <= hcount && ball_x1 + 3 >= hcount)
                                   begin
                                       h_collision2 <= 1;
                                       block_to_del1[10]<=1;
                  //                     num_blocks <= num_blocks - 1;
                   //                    if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision2 <=0;
                                        v_collision2 <= 0;
                                   end
                          end
  
  else if (block_en[11])
                           begin
                                   if (ball_x1 == hcount && ball_y1 - 3 <= vcount && ball_y1+ 3 >= vcount)                            
                                   begin
                                       v_collision2 <= 1;
                                       block_to_del1[11]<=1;
                  //                     num_blocks <= num_blocks - 1;
                   //                   if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y1 == vcount && ball_x1 - 3 <= hcount && ball_x1 + 3 >= hcount)
                                   begin
                                       h_collision2 <= 1;
                                       block_to_del1[11]<=1;
                  //                     num_blocks <= num_blocks - 1;
                  //                     if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision2 <=0;
                                        v_collision2 <= 0;
                                   end
                          end
            
else if (block_en[12])
                           begin
                                   if (ball_x1 == hcount && ball_y1 - 3 <= vcount && ball_y1+ 3 >= vcount)                            
                                   begin
                                       v_collision2 <= 1;
                                       block_to_del1[12]<=1;
                  //                     num_blocks <= num_blocks - 1;
                 //                      if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y1 == vcount && ball_x1 - 3 <= hcount && ball_x1 + 3 >= hcount)
                                   begin
                                       h_collision2 <= 1;
                                       block_to_del1[12]<=1;
                    //                   num_blocks <= num_blocks - 1;
                   //                    if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision2 <=0;
                                        v_collision2 <= 0;
                                   end
                          end
                          
     end
end

always @ (left_position,right_position,vcount,hcount,reset_n,win,lose,vsync,player_en,v_collision3,h_collision3,ball_x2,ball_y2,block_en,collision_cnt,block_to_del2)
   // always@(posedge clk or negedge reset_n)    right one!!!!
    begin
           
        if (!reset_n)
        begin
            //block_addr_wr <= 0;
            //checked <= 1;
            //block_clr <= 0;
            //block_to_del <= 0;
            //v_collision <= 0;
            //h_collision <= 0;
            //hold <= 0;
            //win <= 0;
            //lose <= 0;
            block_to_del2<=0;
            h_collision3 <= 0;
            v_collision3 <= 0;
            
            //collision_cnt <= 0;
        end
        
        else if (vsync)
        begin
            //block_clr <= 0;
           if (player_en) 
            begin   
                
                //else
                //       v_collision1 <= 0;      
             
                if (ball_x2 >= left_position &&  ball_x2 <= right_position
                    && ball_y2 + 3>= `player_vstart/*ball_y-3 <= vcount &&ball_y + 3 >= vcount*/) 
                        v_collision3 <= 1;
                //else
                  //      v_collision2 <= 0;     
             
             
                 
                  else
                 
                     
                     v_collision3 <= 0;
                     
                 
             end

else if (block_en[0])
                           begin
                                   if (ball_x2 == hcount && ball_y2 - 3 <= vcount && ball_y2+ 3 >= vcount)                            
                                   begin
                                       v_collision3 <= 1;
                                       block_to_del2[0]<=1;
                //                       num_blocks <= num_blocks - 1;
                                       //if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y2 == vcount && ball_x2 - 3 <= hcount && ball_x2 + 3 >= hcount)
                                   begin
                                       h_collision3 <= 1;
                                       block_to_del2[0]<=1;
                //                       num_blocks <= num_blocks - 1;
                //                       if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision3 <=0;
                                        v_collision3 <= 0;
                                   end
                          end
    
    else if (block_en[1])
                           begin
                                   if (ball_x2 == hcount && ball_y2 - 3 <= vcount && ball_y2+ 3 >= vcount)                            
                                   begin
                                       v_collision3 <= 1;
                                       block_to_del2[1]<=1;
              //                         num_blocks <= num_blocks - 1;
              //                         if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y2 == vcount && ball_x2 - 3 <= hcount && ball_x2 + 3 >= hcount)
                                   begin
                                       h_collision3 <= 1;
                                       block_to_del2[1]<=1;
                  //                     num_blocks <= num_blocks - 1;
                  //                     if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision3 <=0;
                                        v_collision3 <= 0;
                                   end
                          end
                          
else if (block_en[2])
                          begin
                                   if (ball_x2 == hcount && ball_y2 - 3 <= vcount && ball_y2+ 3 >= vcount)                            
                                   begin
                                       v_collision3 <= 1;
                                       block_to_del2[2]<=1;
                //                       num_blocks <= num_blocks - 1;
                //                      if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y2 == vcount && ball_x2 - 3 <= hcount && ball_x2 + 3 >= hcount)
                                   begin
                                       h_collision3 <= 1;
                                       block_to_del2[2]<=1;
                //                       num_blocks <= num_blocks - 1;
                 //                      if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision3 <=0;
                                        v_collision3 <= 0;
                                   end
                          end
                          
else if (block_en[3])
                           begin
                                   if (ball_x2 == hcount && ball_y2 - 3 <= vcount && ball_y2+ 3 >= vcount)                            
                                   begin
                                       v_collision3 <= 1;
                                       block_to_del2[3]<=1;
                     //                  num_blocks <= num_blocks - 1;
                        //               if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y2 == vcount && ball_x2 - 3 <= hcount && ball_x2 + 3 >= hcount)
                                   begin
                                       h_collision3 <= 1;
                                       block_to_del2[3]<=1;
                   //                    num_blocks <= num_blocks - 1;
                        //               if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision3 <=0;
                                        v_collision3 <= 0;
                                   end
                          end
                          
  else if (block_en[4])
                           begin
                                   if (ball_x2 == hcount && ball_y2 - 3 <= vcount && ball_y2+ 3 >= vcount)                            
                                   begin
                                       v_collision3 <= 1;
                                       block_to_del2[4]<=1;
              //                         num_blocks <= num_blocks - 1;
                //                       if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y2 == vcount && ball_x2 - 3 <= hcount && ball_x2 + 3 >= hcount)
                                   begin
                                       h_collision3 <= 1;
                                       block_to_del2[4]<=1;
               //                        num_blocks <= num_blocks - 1;
                      //                 if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision3 <=0;
                                        v_collision3 <= 0;
                                   end
                          end
       
 else if (block_en[5])
                           begin
                                   if (ball_x2 == hcount && ball_y2 - 3 <= vcount && ball_y2+ 3 >= vcount)                            
                                   begin
                                       v_collision3 <= 1;
                                       block_to_del2[5]<=1;
                  //                     num_blocks <= num_blocks - 1;
                   //                    if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y2 == vcount && ball_x2 - 3 <= hcount && ball_x2 + 3 >= hcount)
                                   begin
                                       h_collision3 <= 1;
                                       block_to_del2[5]<=1;
                //                       num_blocks <= num_blocks - 1;
              //                         if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision3 <=0;
                                        v_collision3 <= 0;
                                   end
                          end
                          
 else if (block_en[6])
                           begin
                                   if (ball_x2 == hcount && ball_y2 - 3 <= vcount && ball_y2+ 3 >= vcount)                            
                                   begin
                                       v_collision3 <= 1;
                                       block_to_del2[6]<=1;
                    //                   num_blocks <= num_blocks - 1;
                       //                if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y2 == vcount && ball_x2 - 3 <= hcount && ball_x2 + 3 >= hcount)
                                   begin
                                       h_collision3 <= 1;
                                       block_to_del2[6]<=1;
                    //                  num_blocks <= num_blocks - 1;
                     //                  if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision3 <=0;
                                        v_collision3 <= 0;
                                   end
                          end
    
else if (block_en[7])
                           begin
                                   if (ball_x2 == hcount && ball_y2 - 3 <= vcount && ball_y2+ 3 >= vcount)                            
                                   begin
                                       v_collision3 <= 1;
                                       block_to_del2[7]<=1;
                      //                 num_blocks <= num_blocks - 1;
                          //             if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y2 == vcount && ball_x2 - 3 <= hcount && ball_x2 + 3 >= hcount)
                                   begin
                                       h_collision3 <= 1;
                                       block_to_del2[7]<=1;
                        //               num_blocks <= num_blocks - 1;
                        //               if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision3 <=0;
                                        v_collision3 <= 0;
                                   end
                          end
                          
 else if (block_en[8])
                           begin
                                   if (ball_x2 == hcount && ball_y2 - 3 <= vcount && ball_y2+ 3 >= vcount)                            
                                   begin
                                       v_collision3 <= 1;
                                       block_to_del2[8]<=1;
                       //                num_blocks <= num_blocks - 1;
                     //                  if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y2 == vcount && ball_x2 - 3 <= hcount && ball_x2 + 3 >= hcount)
                                   begin
                                       h_collision3 <= 1;
                                       block_to_del2[8]<=1;
                      //                 num_blocks <= num_blocks - 1;
                         //             if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision3 <=0;
                                        v_collision3 <= 0;
                                   end
                          end
                          
 else if (block_en[9])
                           begin
                                   if (ball_x2 == hcount && ball_y2 - 3 <= vcount && ball_y2+ 3 >= vcount)                            
                                   begin
                                       v_collision3 <= 1;
                                       block_to_del2[9]<=1;
                     //                  num_blocks <= num_blocks - 1;
                     //                  if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y2 == vcount && ball_x2 - 3 <= hcount && ball_x2 + 3 >= hcount)
                                   begin
                                       h_collision3 <= 1;
                                       block_to_del2[9]<=1;
                      //                 num_blocks <= num_blocks - 1;
                      //                 if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision3 <=0;
                                        v_collision3 <= 0;
                                   end
                          end
     
else if (block_en[10])
                           begin
                                   if (ball_x2 == hcount && ball_y2 - 3 <= vcount && ball_y2+ 3 >= vcount)                            
                                   begin
                                       v_collision3 <= 1;
                                       block_to_del2[10]<=1;
                        //               num_blocks <= num_blocks - 1;
                         //              if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y2 == vcount && ball_x2 - 3 <= hcount && ball_x2 + 3 >= hcount)
                                   begin
                                       h_collision3 <= 1;
                                       block_to_del2[10]<=1;
                    //                  num_blocks <= num_blocks - 1;
                //                       if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision3 <=0;
                                        v_collision3 <= 0;
                                   end
                          end
  
  else if (block_en[11])
                           begin
                                   if (ball_x2 == hcount && ball_y2 - 3 <= vcount && ball_y2+ 3 >= vcount)                            
                                   begin
                                       v_collision3 <= 1;
                                       block_to_del2[11]<=1;
                    //                   num_blocks <= num_blocks - 1;
                     //                  if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y2 == vcount && ball_x2 - 3 <= hcount && ball_x2 + 3 >= hcount)
                                   begin
                                       h_collision3 <= 1;
                                       block_to_del2[11]<=1;
                     //                  num_blocks <= num_blocks - 1;
                     //                  if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision3 <=0;
                                        v_collision3 <= 0;
                                   end
                          end
            
else if (block_en[12])
                           begin
                                   if (ball_x2 == hcount && ball_y2 - 3 <= vcount && ball_y2+ 3 >= vcount)                            
                                   begin
                                       v_collision3 <= 1;
                                       block_to_del2[12]<=1;
                       //                num_blocks <= num_blocks - 1;
                     //                  if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y2 == vcount && ball_x2 - 3 <= hcount && ball_x2 + 3 >= hcount)
                                   begin
                                       h_collision3 <= 1;
                                       block_to_del2[12]<=1;
                       //                num_blocks <= num_blocks - 1;
                          //             if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision3 <=0;
                                        v_collision3 <= 0;
                                   end
                          end
                          
     end
end                

        
  always @ (left_position,right_position,vcount,hcount,reset_n,win,lose,vsync,player_en,v_collision1,h_collision1,ball_x,ball_y,block_en,collision_cnt,block_to_del3)
     //always@(posedge clk or negedge reset_n)
    begin
           
        if (!reset_n)
        begin
            //block_addr_wr <= 0;
            //checked <= 1;
            //block_clr <= 0;
            block_to_del3 <= 0;
            //v_collision <= 0;
            //h_collision <= 0;
            //hold <= 0;
            //win <= 0;
            //lose <= 0;
            h_collision1 <= 0;
            v_collision1 <= 0;
            
         //   collision_cnt <= 0;
        end
        
        else if (vsync)
        begin
            //block_clr <= 0;
           if (player_en) 
            begin   
                if (ball_x >= left_position &&  ball_x <= right_position
                    && ball_y + 3>= `player_vstart/*ball_y-3 <= vcount &&ball_y + 3 >= vcount*/) 
                    begin          
                       // init<= init + 1'b1;
                        collision_cnt <= collision_cnt + 1;
                        v_collision1 <= 1;
                    end
                //else
                //       v_collision1 <= 0;      
             
                 
                  else
             
                     v_collision1 <= 0;
                     
                 end
             end
           /*             
            else if (block_en[0])
            begin
                if (ball_x == hcount && ball_y - 3 <= vcount && ball_y + 3 >= vcount)
                begin
                    v_collision <= 1;
                    //block_to_delete <= block_num;
                    block_to_del[0]<=1;
                    num_blocks <= num_blocks - 1;
                    if (num_blocks == 1) win <= 1;       
                end
                
                else if (ball_y == vcount && ball_x - 3 <= hcount && ball_x + 3 >= hcount) 
                begin
                    h_collision <= 1;
                    //block_to_del <= block_num;
                    block_to_del[0]<=1;
                    num_blocks <= num_blocks - 1;
                    if (num_blocks == 1) win <= 1;
                end
                
                else
                begin
                    v_collision <= 0;
                    h_collision <= 0;
                end
            end
            */
            
              else if (block_en[0])
                           begin
                                   if (ball_x == hcount && ball_y - 3 <= vcount && ball_y + 3 >= vcount)                            
                                   begin
                                       v_collision1 <= 1;
                                       block_to_del3[0]<=1;
                        //               num_blocks <= num_blocks - 1;
                                      // if (num_blocks == 1) win <= 1;
                                   end                                
                                                                                
                                   else if (ball_y == vcount && ball_x - 3 <= hcount && ball_x + 3 >= hcount)
                                   begin
                                       h_collision1 <= 1;
                                       block_to_del3[0]<=1;
               //                        num_blocks <= num_blocks - 1;
              //                         if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision1 <=0;
                                        v_collision1 <= 0;
                                   end
                                        
                end                   
                                   
                                
             else if (block_en[1])
                               begin
                                  if (ball_x == hcount && ball_y - 3 <= vcount && ball_y + 3 >= vcount)                        
                                   begin
                                       v_collision1 <= 1;
                                       block_to_del3[1]<=1;
                //                       num_blocks <= num_blocks - 1;
                //                       if (num_blocks == 1) win <= 1;                   
                                   end
                                    
                                  else if (ball_y == vcount && ball_x - 3 <= hcount && ball_x + 3 >= hcount)                               
                                   begin
                                       h_collision1 <= 1;
                                       block_to_del3[1]<=1;
                  //                     num_blocks <= num_blocks - 1;
                    //                   if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision1 <= 0;
                                        v_collision1 <= 1;
                                   end
                                                              
                                end
                                    
                      else if (block_en[2])
                               begin
                                  if (ball_x == hcount && ball_y - 3 <= vcount && ball_y + 3 >= vcount)                        
                                   begin
                                       v_collision1 <= 1;
                                       block_to_del3[2]<=1;
              //                         num_blocks <= num_blocks - 1;
                         //              if (num_blocks == 1) win <= 1;                   
                                   end
                              
                                   else if (ball_y == vcount && ball_x - 3 <= hcount && ball_x + 3 >= hcount)                               
                                   begin
                                       h_collision1 <= 1;
                                       block_to_del3[2]<=1;
                 //                      num_blocks <= num_blocks - 1;
                        //               if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision1 <= 0;
                                        v_collision1 <= 1;
                                   end
                                                                
                                end
                                 

else if (block_en[3])
                               begin
                                  if (ball_x == hcount && ball_y - 3 <= vcount && ball_y + 3 >= vcount)                        
                                   begin
                                       v_collision1 <= 1;
                                       block_to_del3[3]<=1;
            //                           num_blocks <= num_blocks - 1;
                       //                if (num_blocks == 1) win <= 1;                   
                                   end
                                 
                                   else if (ball_y == vcount && ball_x - 3 <= hcount && ball_x + 3 >= hcount)                               
                                   begin
                                       h_collision1 <= 1;
                                       block_to_del3[3]<=1;
                //                       num_blocks <= num_blocks - 1;
                    //                   if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision1 <= 0;
                                         v_collision1 <= 1;
                                   end
                                                                  
                                end
                                    
 else if (block_en[4])
                             begin
                                  if (ball_x == hcount && ball_y - 3 <= vcount && ball_y + 3 >= vcount)                        
                                   begin
                                       v_collision1 <= 1;
                                       block_to_del3[4]<=1;
                 //                      num_blocks <= num_blocks - 1;
                       //                if (num_blocks == 1) win <= 1;                   
                                   end
                                                                          
                                   else if (ball_y == vcount && ball_x - 3 <= hcount && ball_x + 3 >= hcount)                               
                                   begin
                                       h_collision1 <= 1;
                                       block_to_del3[4]<=1;
                   //                    num_blocks <= num_blocks - 1;
                      //                 if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision1 <= 0;
                                        v_collision1 <= 1;
                                   end
                                                                     
                                end


else if (block_en[5])
                                begin
                                  if (ball_x == hcount && ball_y - 3 <= vcount && ball_y + 3 >= vcount)                        
                                   begin
                                       v_collision1 <= 1;
                                       block_to_del3[5]<=1;
                   //                    num_blocks <= num_blocks - 1;
                        //               if (num_blocks == 1) win <= 1;                   
                                   end
                                  
                                   else if (ball_y == vcount && ball_x - 3 <= hcount && ball_x + 3 >= hcount)                               
                                   begin
                                       h_collision1 <= 1;
                                       block_to_del3[5]<=1;
                //                       num_blocks <= num_blocks - 1;
                         //              if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision1 <= 0;
                                        v_collision1 <= 1;
                                   end
                                   
                                                                      
                                end
                                
                                    
else if (block_en[6])
                                begin
                                  if (ball_x == hcount && ball_y - 3 <= vcount && ball_y + 3 >= vcount)                        
                                   begin
                                       v_collision1 <= 1;
                                       block_to_del3[6]<=1;
                    //                   num_blocks <= num_blocks - 1;
                        //               if (num_blocks == 1) win <= 1;                   
                                   end
                                  
                                   else if (ball_y == vcount && ball_x - 3 <= hcount && ball_x + 3 >= hcount)                               
                                   begin
                                       h_collision1 <= 1;
                                       block_to_del3[6]<=1;
                      //                 num_blocks <= num_blocks - 1;
                       //                if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision1 <= 0;
                                        v_collision1 <= 1;
                                   end
                                   
                                                                      
                                end


else if (block_en[7])
                                begin
                                  if (ball_x == hcount && ball_y - 3 <= vcount && ball_y + 3 >= vcount)                        
                                   begin
                                       v_collision1 <= 1;
                                       block_to_del3[7]<=1;
                  //                     num_blocks <= num_blocks - 1;
                     //                  if (num_blocks == 1) win <= 1;                   
                                   end

                                   else if (ball_y == vcount && ball_x - 3 <= hcount && ball_x + 3 >= hcount)                               
                                   begin
                                       h_collision1 <= 1;
                                       block_to_del3[7]<=1;
               //                        num_blocks <= num_blocks - 1;
                  //                     if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision1 <= 0;
                                         v_collision1 <= 1;
                                   end
                                   
                                                                      
                                end
                                    
else if (block_en[8])
                                begin
                                  if (ball_x == hcount && ball_y - 3 <= vcount && ball_y + 3 >= vcount)                        
                                   begin
                                       v_collision1 <= 1;
                                       block_to_del3[8]<=1;
                 //                      num_blocks <= num_blocks - 1;
                         //              if (num_blocks == 1) win <= 1;                   
                                   end
     
                                  else if (ball_y == vcount && ball_x - 3 <= hcount && ball_x + 3 >= hcount)                               
                                   begin
                                       h_collision1 <= 1;
                                       block_to_del3[8]<=1;
                     //                  num_blocks <= num_blocks - 1;
                         //              if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision1 <= 0;
                                        v_collision1 <= 1;
                                   end
                                  
                                                                      
                                end
                                    

else  if (block_en[9])
                                begin
                                  if (ball_x == hcount && ball_y - 3 <= vcount && ball_y + 3 >= vcount)                        
                                   begin
                                       v_collision1 <= 1;
                                       block_to_del3[9]<=1;
                  //                     num_blocks <= num_blocks - 1;
                           //            if (num_blocks == 1) win <= 1;                   
                                   end
                                             
                                   else if (ball_y == vcount && ball_x - 3 <= hcount && ball_x + 3 >= hcount)                               
                                   begin
                                       h_collision1 <= 1;
                                       block_to_del3[9]<=1;
                  //                     num_blocks <= num_blocks - 1;
                         //              if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision1 <= 0;
                                        v_collision1 <= 1;
                                   end
                                  
                                                                      
                                end
                                    
 else if (block_en[10])
                                begin
                                  if (ball_x == hcount && ball_y - 3 <= vcount && ball_y + 3 >= vcount)                        
                                   begin
                                       v_collision1 <= 1;
                                       block_to_del3[10]<=1;
                //                       num_blocks <= num_blocks - 1;
                         //              if (num_blocks == 1) win <= 1;                   
                                   end
                            
                                   else if (ball_y == vcount && ball_x - 3 <= hcount && ball_x + 3 >= hcount)                               
                                   begin
                                       h_collision1 <= 1;
                                       block_to_del3[10]<=1;
                      //                 num_blocks <= num_blocks - 1;
                          //             if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision1 <= 0;
                                        v_collision1 <= 1;
                                   end
                                   
                                                                      
                                end

 else if (block_en[11])
                               begin
                                  if (ball_x == hcount && ball_y - 3 <= vcount && ball_y + 3 >= vcount)                        
                                   begin
                                       v_collision1 <= 1;
                                       block_to_del3[11]<=1;
                   //                    num_blocks <= num_blocks - 1;
                          //             if (num_blocks == 1) win <= 1;                   
                                   end
                                    
                                   else if (ball_y == vcount && ball_x - 3 <= hcount && ball_x + 3 >= hcount)                               
                                   begin
                                       h_collision1 <= 1;
                                       block_to_del3[11]<=1;
                     //                  num_blocks <= num_blocks - 1;
                          //             if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision1 <= 0;
                                        v_collision1 <= 1;
                                   end
                                   
                                                                      
                                end
                                   
    else  if (block_en[12])
                      begin
                                  if (ball_x == hcount && ball_y - 3 <= vcount && ball_y + 3 >= vcount)                        
                                   begin
                                       v_collision1 <= 1;
                                       block_to_del3[12]<=1;
                      //                 num_blocks <= num_blocks - 1;
                               //        if (num_blocks == 1) win <= 1;                   
                                   end
                                                        
                                  else if (ball_y == vcount && ball_x - 3 <= hcount && ball_x + 3 >= hcount)                               
                                   begin
                                       h_collision1 <= 1;
                                       block_to_del3[12]<=1;
                          //             num_blocks <= num_blocks - 1;
                          //             if (num_blocks == 1) win <= 1;
                                   end
                                   else
                                   begin
                                        h_collision1 <= 0;
                                        v_collision1 <= 1;
                                   end
                                  
                                                                      
                                end
                         
      
 
         
                   
           
        end
        
 always@(lose,win,reset_n)
 begin
        if(!reset_n)
        begin
            lose =0;
            win = 0;
        end
       // if (ball_y >= `bottom_edge || ball_y1 >= `bottom_edge || ball_y2 >= `bottom_edge)   
        //        lose = 1;
     //   if(num_blocks == 1) win=1;       
         
 end
 
 always@(posedge clk)
 begin
          block_to_del <= (block_to_del1 | block_to_del2) | block_to_del3;
 end
    
endmodule
            
        /*
        else if (!vsync && checked) //initialize addresses
        begin
            block_addr_wr <= 0;
            checked <= 0;
            block_clr <= 0;
            hold <= 0;
        end
        
        
        else if (!vsync && !checked)
        begin
            if (block_num != 0 && block_num == block_to_del) 
            begin
                block_clr <= 1;
            end

            else 
            begin
                block_clr <= 0;
                //hold <= 0;
                //block_addr_wr <= block_addr_wr + 1;
            end
            
            if (hold != 2 ) block_addr_wr <= block_addr_wr;
            else block_addr_wr <= block_addr_wr + 1;
            
            hold <= hold + 1;
            
            if (block_addr_wr >= 256) 
            begin
                block_addr_wr <= 0;
                checked <= 1;
            end
        end
       */
