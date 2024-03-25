`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  right;
   logic  left;
   logic  reset;
   logic  [5:0] y;
   
   integer handle3;
   integer desc3;
   
   // Instantiate DUT
   FSM dut (clk, reset, right, left, y);
   
   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk; //1 nano second
     end

   initial
     begin
	// Gives output file name
	handle3 = $fopen("fsm.out");
	// Tells when to finish simulation
	#600 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#10 $fdisplay(desc3, "%b || %b %b || %b", 
		     reset, right, left, y);
     end   
   
   initial 
     begin
     
     //right test       nano seconds  
     #0  reset = 1'b1;  //start line
     #5  reset = 1'b0; //section 1 line 

     //right inputs 
     #0  right = 1'b0; //section 1 line 
     #0  left = 1'b0;  //section 1 line 
     #5  right = 1'b1; //section 2 line 
     #0  left = 1'b0;  //section 2 line 
     #10 right = 1'b0; //section 3 line 
     #0  left = 1'b0;  //section 3 line 
     
     //left inputs 
     #30  left = 1'b0; //section 4 line 
     #0  right = 1'b0;//section 4 line 
     #5  left = 1'b1; //section 5 line 
     #0  right = 1'b0;//section 5 line 
     #10 left = 1'b0; //section 6 line 
     #0 right = 1'b0; //section 6 line

     //left and right inputs
     #30 left = 1'b0;  //section 9 line
     #0 right = 1'b0; 
     #5 left = 1'b1;  //section 10 line
     #0 right = 1'b1; 
     #10 left = 1'b0;  //section 11 line
     #0 right = 1'b0; 

     end

endmodule // FSM_tb