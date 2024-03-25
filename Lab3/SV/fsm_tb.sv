`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  right;
   logic  left;
   logic  reset;
   logic  y;
   
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
	#500 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#5 $fdisplay(desc3, "%b || %b %b || %b", 
		     reset, right, left, y);
     end   
   
   initial 
     begin
     
     //right test       nano seconds  
     #0   reset = 1'b1; //0
     #50  reset = 1'b0; //10
     //left test
     #100 reset = 1'b1; //20
     #150 reset = 1'b0; //30
     //left and right test
     #200 reset = 1'b1; //40
     #250 reset = 1'b0; //50

     //right inputs
     #0   right = 1'b0; //0
     #25  right = 1'b1; //5
     #25  right = 1'b0; //5
     //left inputs
     #100  left = 1'b0; //20
     #125  left = 1'b1; //25
     #125  left = 1'b0; //25
     //left and right inputs
     #200  left = 1'b0; //40
     #200 right = 1'b0; //40
     #225  left = 1'b1; //45
     #225 right = 1'b1; //45
     #225  left = 1'b0; //45
     #225 right = 1'b0; //45

     end

endmodule // FSM_tb

