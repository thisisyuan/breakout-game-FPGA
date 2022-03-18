module encoder(	input wire clk,
			    input wire reset_n,
				input wire vsync,
				input wire left,
				input wire right,
				input wire [1:0]speed,
				//output reg [WIDTH-1:0] ctrl,
			 output reg [9:0]right_position,
		     output reg [9:0]left_position);
	
	//parameter WIDTH = 6;
	//parameter LIMIT = 19;
    reg [9:0]right_position = 360;
    reg [9:0]left_position = 300;
	//parameter DEBOUNCE = 15000;
	//reg [9:0] left_position = 300;
	//reg [9:0] right_position = 360;  
	
	//parameter INITIAL = 9;
	
	//integer debounce;
			
	//reg hold;
	`include "defines.v"
//	initial begin
//		ctrl = INITIAL;
//	end
		
/*	always @ (posedge clk or negedge reset_n)
	begin 
		if (!reset_n)
		begin
			ctrl <= 9;
			debounce <= 0;
			hold <= 0;
		end
		
		else if (!a && b && !hold) 
		begin
			debounce <= debounce + 1'b1;
			if (debounce >= DEBOUNCE)
			begin
				if (ctrl < LIMIT) ctrl <= ctrl + 1'b1; 
				hold <= 1;
				debounce <= 0;
			end
		end
		
		else if (a &&  !b && !hold) 
		begin
			debounce <= debounce + 1'b1;
			if (debounce >= DEBOUNCE)
			begin
				if (ctrl > 1) ctrl <= ctrl - 1'b1; 
				hold <= 1;
				debounce <= 0;
			end
		end
		
		else if (a && hold) 
		begin
			debounce <= debounce + 1'b1;
			if (debounce >= DEBOUNCE)
			begin
				hold <= 0;
				debounce <= 0;
			end
		end
		
		else debounce <= 0;
	end
	
	
	always@(negedge reset_n)
	begin   
		if (!reset_n)
		begin
			//ctrl <= 9;
			//debounce <= 0;
			right_position <= 360;
			left_position <= 300;
		end
    end
    */
    
    always@(posedge vsync)
        begin            
            if( left && (left_position >= `left_edge) )
            begin
               left_position <= left_position - speed;  
			   right_position <= right_position - speed;  
		    end
		    
		    else if( right && (right_position <= `right_edge))
		    begin
		       left_position <= left_position + speed;
		       right_position <= right_position + speed;
		    end
	   end
endmodule
