module ball_logic(  input clk,
                    input reset_n,
                    input vsync,
                    input h_collision1,
                    input h_collision2,
                    input h_collision3,
                    input v_collision1,
                    input v_collision2,
                    input v_collision3,
                    input [4:0]collision_cnt,
                    input start,
                    output reg [9:0] ball_x,
                    output reg [9:0] ball_y,
                    output reg [9:0] ball_x1,
                    output reg [9:0] ball_y1,
                    output reg [9:0] ball_x2,
                    output reg [9:0] ball_y2  );

    parameter down_right = 3'b000;
    parameter down_left = 3'b001;
    parameter up_right = 3'b010;
    parameter up_left = 3'b011;
    parameter stop = 3'b100;

    reg draw1;
    reg draw2;
    reg draw3;
    reg [2:0] ball_state;
    reg [2:0] next_ball_state;
    reg [2:0] ball_state1;
    reg [2:0] next_ball_state1;
    reg [2:0] ball_state2;
    reg [2:0] next_ball_state2;
    reg [9:0] temp_x;
    reg [9:0] temp_y;
    `include "defines.v"
    
    always@(posedge clk)
    begin         
          if (!reset_n)  
              begin
              draw1 <= 1; //?               
            //lose <= 0;
                 ball_y <= 455;
                 ball_x <= 330;       
             end
             
            
               
                            
        else if (!vsync && !draw1) 
        begin
            draw1 <= 1;           
            case(ball_state)
                stop:
                begin
                    ball_x <= ball_x;
                    ball_y <= ball_y;
                end
                
                down_right:
                begin
                    ball_x <= ball_x + 2'd1;
                    ball_y <= ball_y + 2'd2;
                end
                
                down_left:
                begin
                    ball_x <= ball_x - 2'd1;
                    ball_y <= ball_y + 2'd2;
                end
                
                up_right:
                begin
                    ball_x <= ball_x + 2'd1;
                    ball_y <= ball_y - 2'd2;
                end
                
                up_left:
                begin
                    ball_x <= ball_x - 2'd1;
                    ball_y <= ball_y - 2'd2;
                end
                
                default:
                begin
                    ball_x <= ball_x + 2'd1;
                    ball_y <= ball_y + 2'd2;
                end
            endcase
        end
                
       else if (vsync && draw1)
        begin
            draw1 <= 0;
        end
 end
        
always@(posedge clk)
begin
if (!reset_n)  
              begin            
                 draw2 <= 0;            
            //lose <= 0;                    
             end
             
    else if(collision_cnt == 1)
         begin
           temp_x <= ball_x;
           temp_y <= ball_y;
            ball_y1 <= temp_y;
            ball_x1 <= temp_x;
            
            draw2 <= 1;
            
         end             
           
         
       else if (!vsync && !draw2) 
        begin
            draw2 <= 1;
            case(ball_state1)
                stop:
                begin
                    ball_x1 <= ball_x1;
                    ball_y1 <= ball_y1;
                end
                
                down_right:
                begin
                    ball_x1 <= ball_x1 + 2'd1;
                    ball_y1 <= ball_y1 + 2'd2;
                end
                
                down_left:
                begin
                    ball_x1 <= ball_x1 - 2'd1;
                    ball_y1 <= ball_y1 + 2'd2;
                end
                
                up_right:
                begin
                    ball_x1 <= ball_x1 + 2'd1;
                    ball_y1 <= ball_y1 - 2'd2;
                end
                
                up_left:
                begin
                    ball_x1 <= ball_x1 - 2'd1;
                    ball_y1 <= ball_y1 - 2'd2;
                end
                
                default:
                begin
                    ball_x1 <= ball_x1 + 2'd1;
                    ball_y1 <= ball_y1 + 2'd2;
                end
            endcase
        end
                
        else if (vsync && draw2)
        begin
            draw2 <= 0;
        end
 end
            
always@(posedge clk)
begin        
if (!reset_n)  
              begin
               
                 draw3 <= 0;
            //lose <= 0;                    
             end
             
            else if(collision_cnt == 1)
         begin
           temp_x <= ball_x;
           temp_y <= ball_y;
         
            
            draw3 <= 1;
         end     
          
      else if (!vsync && !draw3) 
        begin
            draw3 <= 1;
            case(ball_state2)
                stop:
                begin
                    ball_x2 <= ball_x2;
                    ball_y2 <= ball_y2;
                end
                
                down_right:
                begin
                    ball_x2 <= ball_x2 + 2'd1;
                    ball_y2 <= ball_y2 + 2'd2;
                end
                
                down_left:
                begin
                    ball_x2 <= ball_x2 - 2'd1;
                    ball_y2 <= ball_y2 + 2'd2;
                end
                
                up_right:
                begin
                    ball_x2 <= ball_x2 + 2'd1;
                    ball_y2 <= ball_y2 - 2'd2;
                end
                
                up_left:
                begin
                    ball_x2 <= ball_x2 - 2'd1;
                    ball_y2 <= ball_y2 - 2'd2;
                end
                
                default:
                begin
                    ball_x2 <= ball_x2 + 2'd1;
                    ball_y2 <= ball_y2 + 2'd2;
                end
            endcase
        end
                
        else if (vsync && draw3)
        begin
            draw3 <= 0;
        end
 end
    
    always @ (posedge clk)
    begin
        if (!reset_n) 
        begin
            ball_state <= stop; 
            ball_state1 <= stop;   
            ball_state2 <= stop; 
        end  
        else
        begin
            ball_state <= next_ball_state;
            
            ball_state1 <= next_ball_state1;
             
           ball_state2 <= next_ball_state2;
       end
  end



    always @ (ball_state or ball_x or ball_y or h_collision1 or v_collision1 or start)
    begin
        case (ball_state)
            stop:
            begin
                if (start == 1) next_ball_state <= up_right;
                else next_ball_state <= stop;
            end
            
            down_right:
            begin
                if (ball_y >= `bottom_edge) next_ball_state <= up_right;
                else if (ball_x >= `right_edge) next_ball_state <= down_left;
                else if (v_collision1) next_ball_state <= up_right;
                else if (h_collision1) next_ball_state <= down_left;
                else next_ball_state <= down_right;
            end
            
            down_left:
            begin
                if (ball_y >= `bottom_edge) next_ball_state <= up_left;
                else if (ball_x <= `left_edge) next_ball_state <= down_right;
                else if (v_collision1) next_ball_state <= up_left;
                else if (h_collision1) next_ball_state <= down_right;
                else next_ball_state <= down_left;
            end
            
            up_right:
            begin
                if (ball_y <= `top_edge) next_ball_state <= down_right;
                else if (ball_x >= `right_edge) next_ball_state <= up_left;
                else if (v_collision1) next_ball_state <= down_right;
                else if (h_collision1) next_ball_state <= up_left;
                else next_ball_state <= up_right;
            end
            
            up_left:
            begin
                if (ball_y <= `top_edge) next_ball_state <= down_left;
                else if (ball_x <= `left_edge) next_ball_state <= up_right;
                else if (v_collision1) next_ball_state <= down_left;
                else if (h_collision1) next_ball_state <= up_right;
                else next_ball_state <= up_left;
            end 
        endcase
    end
    
    always @ (ball_state1 or ball_x1 or ball_y1 or h_collision2 or v_collision2 or start or collision_cnt)
    begin
        case (ball_state1)
            stop:
            begin
                 if (start == 1&&collision_cnt>2) next_ball_state1 <=stop;
                else 
                begin
                 next_ball_state1 <= up_right;
                 //ball_x1<=ball_x;
                 //ball_y1<=ball_y;
                  end
            end
            
            down_right:
            begin
                if (ball_y1 >= `bottom_edge) next_ball_state1 <= up_right;
                else if (ball_x1 >= `right_edge) next_ball_state1 <= down_left;
                else if (v_collision2) next_ball_state1 <= up_right;
                else if (h_collision2) next_ball_state1 <= down_left;
                else next_ball_state1 <= down_right;
            end
            
            down_left:
            begin
                if (ball_y1 >= `bottom_edge) next_ball_state1 <= up_left;
                else if (ball_x1 <= `left_edge) next_ball_state1 <= down_right;
                else if (v_collision2) next_ball_state1 <= up_left;
                else if (h_collision2) next_ball_state1 <= down_right;
                else next_ball_state1 <= down_left;
            end
            
            up_right:
            begin
                if (ball_y1 <= `top_edge) next_ball_state1 <= down_right;
                else if (ball_x1 >= `right_edge) next_ball_state1 <= up_left;
                else if (v_collision2) next_ball_state1 <= down_right;
                else if (h_collision2) next_ball_state1 <= up_left;
                else next_ball_state1<= up_right;
            end
            
            up_left:
            begin
                if (ball_y1 <= `top_edge) next_ball_state1 <= down_left;
                else if (ball_x1 <= `left_edge) next_ball_state1 <= up_right;
                else if (v_collision2) next_ball_state1 <= down_left;
                else if (h_collision2) next_ball_state1 <= up_right;
                else next_ball_state1 <= up_left;
            end 
        endcase
    end
    
    always @ (ball_state2 or ball_x2 or ball_y2 or h_collision3 or v_collision3 or start or collision_cnt)
    begin
        case (ball_state2)
            stop:
            begin
                 if (start == 1&&1>collision_cnt) next_ball_state2 <=stop;
                else 
                begin
                 next_ball_state2 <= up_left;
                 //ball_x2<=ball_x;
                // ball_y2<=ball_y;
                  end
            end
            
            down_right:
            begin
                if (ball_y2 >= `bottom_edge) next_ball_state2 <= up_right;
                else if (ball_x2 >= `right_edge) next_ball_state2 <= down_left;
                else if (v_collision3) next_ball_state2 <= up_right;
                else if (h_collision3) next_ball_state2 <= down_left;
                else next_ball_state2 <= down_right;
            end
            
            down_left:
            begin
                if (ball_y2 >= `bottom_edge) next_ball_state2 <= up_left;
                else if (ball_x2 <= `left_edge) next_ball_state2 <= down_right;
                else if (v_collision3) next_ball_state2 <= up_left;
                else if (h_collision3) next_ball_state2 <= down_right;
                else next_ball_state2 <= down_left;
            end
            
            up_right:
            begin
                if (ball_y2 <= `top_edge) next_ball_state2 <= down_right;
                else if (ball_x2 >= `right_edge) next_ball_state2 <= up_left;
                else if (v_collision3) next_ball_state2 <= down_right;
                else if (h_collision3) next_ball_state2 <= up_left;
                else next_ball_state2 <= up_right;
            end
            
            up_left:
            begin
                if (ball_y2 <= `top_edge) next_ball_state2 <= down_left;
                else if (ball_x2 <= `left_edge) next_ball_state2 <= up_right;
                else if (v_collision3) next_ball_state2 <= down_left;
                else if (h_collision3) next_ball_state2 <= up_right;
                else next_ball_state2 <= up_left;
            end 
        endcase
    end
endmodule
