module FSM (clk, reset, right, left, y);

   input logic clk;
   input logic reset;
   input logic left;
   input logic right;

   output logic [5:0] y;

   typedef enum logic [3:0] {S0, R1, R2, R3, L1, L2, L3, E1, E2, E3} statetype;
   statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
      if (reset) state <= S0;
      else       state <= nextstate;
   
   // next state logic
   always_comb
      case (state)
         S0: begin
	         y <= 6'b000_000;	  
            if (right & ~left) nextstate <= R1; 
            else if(~right & left) nextstate <= L1;
            else if(right & left) nextstate <= E1;
            else nextstate <= S0;
         end
         L1: begin
	         y <= 6'b001_000;	  	  
 	         nextstate <= L2;
         end
         L2: begin
	         y <= 6'b011_000;	  	  
	         nextstate <= L3;
         end
         L3: begin
            y <= 6'b111_000;
            nextstate <= S0;
         end
         R1: begin
            y <= 6'b000_100;
            nextstate <= R2;
         end
         R2: begin
            y<= 6'b000_110;
            nextstate <= R3;
         end
         R3: begin
            y <= 6'b000_111;
            nextstate <= S0;
         end
         E1: begin
            y <= 6'b001_100;
            nextstate <= E2;
         end
         E2: begin
            y <= 6'b011_110;
            nextstate <= E3;
         end
         E3: begin
            y <= 6'b111_111;
            nextstate <=S0;
         end
         default: begin
	         y <= 6'b000_000;	  	  
	         nextstate <= S0;
         end
      endcase
   
endmodule
